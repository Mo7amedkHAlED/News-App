//
//  Service.swift
//  News App
//
//  Created by Mohamed Khaled on 06/03/2023.
//

import Foundation
import Moya

enum Service {
    case getNews(pageSize: Int, language: String, keyword: String)
    case getHeadlines(pageSize: Int, language: String)
}
extension Service: BaseEndpoint {
    
    // MARK: - This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .getNews:
            return "v2/everything"
        case.getHeadlines:
            return "v2/top-headlines"
        }
    }
    
    // MARK: - Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        case .getHeadlines:
            return .get
        }
    }
    
    // MARK: - Here we specify body parameters, objects, files etc.
    var task: Task {
        switch self {
            
        case .getNews(let pageSize,let language, let keyword):
            return .requestParameters(parameters: [Constants.Parameter.search: keyword,
                                                   Constants.Parameter.pageSize: pageSize,
                                                   Constants.Parameter.language:language,
                                                   Constants.Parameter.apiKey : Constants.apiKey], encoding: URLEncoding.default)
        case.getHeadlines(let pageSize,let language):
            return .requestParameters(parameters: [Constants.Parameter.headline: Constants.Parameter.headline2,
                                                   Constants.Parameter.pageSize: pageSize,
                                                   Constants.Parameter.language:language,
                                                   Constants.Parameter.apiKey : Constants.apiKey], encoding: URLEncoding.default)
            
        }
    }
    
    // MARK: -  These are the headers that our service requires.
    var headers: [String: String]? {
        return [Constants.Header.contentType : Constants.ContentType.json]
    }
}
