//
//  NewsViewModel.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

struct NewsViewModel {
    // MARK: - Properties
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    let searchTextBehavior: BehaviorRelay<String> = .init(value: "")
    private var newsModelSubject = PublishSubject<[Article]>()
    var newsModelObservable: Observable<[Article]> {
        return newsModelSubject
    }
    var pageSize = 6
    var language = "en"
    
    // MARK:  Fetch User Data From Api
    func fetchNewsData(_ pageSize: Int, keyword: String?) {
        self.loadingBehavior.accept(true)
        
        api.getNews(language: language, pageSize: pageSize, keyword: keyword ?? "all news") {(result) in
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let news):
                self.newsModelSubject.onNext(news)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
        
    }

}
