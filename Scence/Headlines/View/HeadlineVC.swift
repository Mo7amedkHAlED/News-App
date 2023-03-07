//
//  HeadlineVC.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class HeadlineVC: UIViewController {
    static let ID = String(describing: HeadlineVC.self)
    
    // MARK: - @IBOutlet
    @IBOutlet weak var headlineCollectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    // MARK: - Properties
    var headlineViewModel = HeadlineViewModel()
    private let disposeBag = DisposeBag()
    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        subscribeToResponse()
        subscribeToLoading()
        subscribeToBranchSelection()
        getHeadlineData(pageSize: headlineViewModel.pageSize)
        headlineCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

    }
    // MARK: - Configure Collection View
    func registerCollectionView() {
        headlineCollectionView.register(UINib(nibName: HeadlineCollectionViewCell.ID, bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.ID)
        
    }
    // MARK: - Binding Collection View Cell With Model Data
    func subscribeToResponse() {
        self.headlineViewModel.headlineModelObservable
            .bind(to: headlineCollectionView
                .rx
                .items(cellIdentifier: HeadlineCollectionViewCell.ID,
                       cellType: HeadlineCollectionViewCell.self)) { row, data, cell in
                cell.SetupCell(data)
            }.disposed(by: disposeBag)
    }
        // MARK: - Create Method To Know Selection Cell
        func subscribeToBranchSelection() {
            headlineCollectionView
                .rx
                .modelSelected(Article.self)
                .subscribe(onNext: { [weak self ] model in
                    self?.showPhoto(model.url ?? "")
                }).disposed(by: disposeBag)
        }
        // MARK: - Method to show & hidden loader
        func subscribeToLoading() {
            headlineViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
                if isLoading {
                    self.indicator.startAnimating()

                } else {
                    self.indicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
        }
    // MARK: - Scroll view & paginaion Method
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == headlineCollectionView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
                self.headlineViewModel.pageSize += 6
                headlineViewModel.fetchHeadlineData(headlineViewModel.pageSize)
            }
        }
    }
        // MARK: - To Navegite to anther View Controller
        func showPhoto(_ url : String) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: WebKitVC.ID) as! WebKitVC
            vc.urlString = url
            navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: - Get Headline Data List From Api
        func getHeadlineData(pageSize :Int) {
            headlineViewModel.fetchHeadlineData(pageSize)
        }
}

// MARK: - Extension Headline View Controller To Implement FlowLayout
extension HeadlineVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: (width / 2 )  , height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

    
