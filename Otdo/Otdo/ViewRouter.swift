//
//  ViewRouter.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .loginView
    
}

enum Page {
    case registerView
    case loginView
    case mainView
}

