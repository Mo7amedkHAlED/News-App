//
//  HeadlineViewModel.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import RxCocoa
import RxSwift


struct HeadlineViewModel {
    // MARK: - Properties
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var headlineModelSubject = PublishSubject<[Article]>()
    var headlineModelObservable: Observable<[Article]> {
        return headlineModelSubject
    }
    
    var pageSize = 6
    var language = "en"
    
    // MARK:  Fetch User Data From Api
    func fetchHeadlineData(_ pageSize: Int) {
        self.loadingBehavior.accept(true)
        api.getHeadlines(language: language, pageSize: pageSize) { (result) in
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let headline):
                self.headlineModelSubject.onNext(headline)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
        
    }
}
