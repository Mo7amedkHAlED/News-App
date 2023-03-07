//
//  ServiceAPI.swift
//  News App
//
//  Created by Mohamed Khaled on 06/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
// MARK: - UsersAPIProtocol

protocol UsersAPIProtocol {
    
    func getNews(language: String, pageSize:Int, keyword: String, completion: @escaping (Result<[Article], Error>) -> Void)
    func getHeadlines(language: String, pageSize:Int, completion: @escaping (Result<[Article], Error>) -> Void)
}

//MARK: - Requests
class ServiceAPI: UsersAPIProtocol, BaseAPI {
    func getHeadlines(language: String, pageSize: Int, completion: @escaping (Result<[Article], Error>) -> Void) {
        fetchData(target: .getHeadlines(pageSize: pageSize, language: language), onComplete: completion)
    }
    
    typealias router = Service
    func getNews(language: String, pageSize: Int, keyword: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        fetchData(target: .getNews(pageSize: pageSize, language: language, keyword: keyword), onComplete: completion)
    }
}
