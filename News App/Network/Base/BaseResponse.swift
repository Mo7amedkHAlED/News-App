//
//  BaseResponse.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import Foundation


class BaseResponse<T: Codable>: Codable {
    var status: String?
    var totalResults: Int?
    var articles: T?
}
