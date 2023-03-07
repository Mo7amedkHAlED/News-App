//
//  Constants.swift
//  News App
//
//  Created by Mohamed Khaled on 06/03/2023.
//
import Foundation

struct Constants {
    static let baseURL = "https://newsapi.org/"
    static let apiKey = "58aa2a7586654d32ae3156d87ea58859"
    static let genericeError = "Something went wrong, please try again later"
    static let pageSize = 6
    
    enum Parameter {
        static let apiKey = "apiKey"
        static let page = "page"
        static let pageSize = "pageSize"
        static let search = "q"
        static let headline = "country"
        static let headline2 = "us"
        static let language = "language"
    }
    
    enum Header {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let json = "application/json"
    }
}
