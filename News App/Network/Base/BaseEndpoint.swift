//
//  BaseEndpoint.swift
//  News App
//
//  Created by Mohamed Khaled on 06/03/2023.
//

import Foundation
import Moya

protocol BaseEndpoint: TargetType {
    var baseURL: URL { get }
}

extension BaseEndpoint {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
}
