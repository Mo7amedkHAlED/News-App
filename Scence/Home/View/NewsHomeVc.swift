//
//  NewsHomeVc.swift
//  News App
//
//  Created by Mohamed Khaled on 06/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import NVActivityIndicatorView

class NewsHomeVc: UIViewController, UIScrollViewDelegate {
    static let ID = String(describing: NewsHomeVc.self)
    
    // MARK: - @IBOutlet
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var newsTableView: UITableView!
    // MARK: - Properties
    var newsViewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController()
    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        custmizeNavController()
        registerTableView()
        subscribeToResponse()
        getNewsData(pageSize:newsViewModel.pageSize)
        searchControllerSetup()
        subscribeToLoading()
        subscribeToBranchSelection()
    }
    // MARK: - Search Controller SetUp
    func searchControllerSetup() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController
            .searchBar
            .searchTextField
            .rx.text.orEmpty
            .bind(to: newsViewModel.searchTextBehavior)
            .disposed(by: disposeBag)
    
        newsViewModel.searchTextBehavior.asObservable().subscribe(onNext: { search in
            if !search.isEmpty {
                self.newsViewModel.fetchNewsData(self.newsViewModel.pageSize, keyword: search)
            }
        }).disposed(by: disposeBag)
    }
    // MARK: - Custmize Navigation Controller
    func custmizeNavController(){
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    // MARK: - Configure Table View
    func registerTableView() {
        newsTableView.register(UINib(nibName: NewsTableViewCell.ID, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.ID)
    }
    // MARK: - Create Method To Know Selection Cell
    func subscribeToBranchSelection() {
        newsTableView
            .rx
            .modelSelected(Article.self)
            .subscribe(onNext: { [weak self ] model in
                self?.showAlbums(model)
        }).disposed(by: disposeBag)
    }
    // MARK: - To Navegite To Anther View Controller
    func showAlbums(_ model:Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: DetailsVC.ID) as! DetailsVC
        vc.detailsViewModel.DataDetails = model
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Binding Table View Cell With Model Data
    func subscribeToResponse() {
        self.newsViewModel.newsModelObservable
            .bind(to: newsTableView
                .rx
                .items(cellIdentifier: NewsTableViewCell.ID,
                        cellType: NewsTableViewCell.self)) { row,data,cell in
                cell.cellSetup(data)
            }.disposed(by: disposeBag)
    }
    // MARK: - Scroll view & paginaion Method
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == newsTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
                self.newsViewModel.pageSize += 6
                getNewsData(pageSize:newsViewModel.pageSize)
            }
        }
    }
    // MARK: - Method to show & hidden loader
    func subscribeToLoading() {
        newsViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.indicator.startAnimating()

            } else {
                self.indicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
    // MARK: - Get News Data List From Api
    func getNewsData(pageSize :Int) {
        newsViewModel.fetchNewsData(pageSize, keyword: nil)
    }
}
// MARK: - Extension News Table To Implement FlowLayout
extension NewsHomeVc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}
// MARK: - Extension To Handel Cancel Button
extension NewsHomeVc: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getNewsData(pageSize: newsViewModel.pageSize)
    }
}
