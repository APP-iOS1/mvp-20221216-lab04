//
//  LocationManager.swift
//  Otdo
//
//  Created by hyemi on 2022/12/20.
//

import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    
    @Published var start: String = ""
    @Published var end: String = ""
    
    @Published var startPoint: CLLocation = .init()
    @Published var endPoint: CLLocation = .init()
    
    @Published var myAdd: String = ""
    
    var cancellable1: AnyCancellable?
    var cancellable2: AnyCancellable?
    
    var typeOfInput: Bool = false
    
    @Published var fetchedPlaces: [CLPlacemark] = []
    
    override init() {
        super.init()
        
        mapView.delegate = self
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
        
        cancellable1 = $start
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value.isEmpty {
                    self.fetchedPlaces = []
                } else {
                    self.fetchPlaces(value: value)
                }
            })
        
        cancellable2 = $end
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value.isEmpty {
                    self.fetchedPlaces = []
                } else {
                    self.fetchPlaces(value: value)
                }
            })
        
        self.mapView.showsUserLocation = true
        //        self.mapView.setUserTrackingMode(.follow, animated: true)
        
//        let customGesture = UIGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
//        self.mapView.addGestureRecognizer(customGesture)
    }
    
    func fetchPlaces(value: String) {
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value
                
                let response = try await MKLocalSearch(request: request).start()
                
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                    })
                })
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
    
    // 사용자에게 위치 권한을 요청하는 메소드
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways: manager.requestLocation()
        case.authorizedWhenInUse: manager.requestLocation()
        case .denied: ()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        default: ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        self.convertCLLocationToAddress(location: currentLocation)
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
//        guard let newLocation = view.annotation?.coordinate else { return }
//        print(newLocation)
//    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 300,
            longitudinalMeters: 300)
        
        mapView.setRegion(region, animated: true)
    }
    
    // 지도가 움직일 때 호출되는 메소드
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        self.convertCLLocationToAddress(location: location)
    }
    
    // Coordinate2D(위, 경도)를 실제 주소로 변환해주는 메소드
    func convertCLLocationToAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        
        // location -> real address
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            if !self.typeOfInput {
                self.start = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
            } else {
                self.end = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
            }
        }
    }
    
    // 실제 주소를 Coordinate2D(위, 경도)로 변환해주는 메소드
    // 일단 임시로 서울역 위, 경도를 넣었음
    func convertAddressToCLLocation() {
        let location = CLLocationCoordinate2D(latitude: 37.555946, longitude: 126.972317)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
    /// 제스처 조작
//    @objc
//    private func didTappedMapView(_ sender: UITapGestureRecognizer) {
//        let viewPoint: CGPoint = sender.location(in: self.mapView)
//        let mapPoint: CLLocationCoordinate2D = self.mapView.convert(viewPoint, toCoordinateFrom: self.mapView)
//        let location: CLLocation = CLLocation(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
//
//        if sender.state == .ended {
//            print("터치 끝")
//            self.convertCLLocationToAddress(location: location)
//        } else {
//            print("안녕")
//        }
//    }
}
