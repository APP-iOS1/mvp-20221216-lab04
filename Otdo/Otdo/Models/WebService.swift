//
//  WebService.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import Foundation

class WebService {
    func fetchData(url: String) async throws -> Weather? {
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(Weather.self, from: data)
        return result
    }
}
