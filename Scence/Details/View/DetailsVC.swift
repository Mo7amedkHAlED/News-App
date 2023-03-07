//
//  DetailsVC.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsVC: UIViewController {
    static let ID = String(describing: DetailsVC.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var DesLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var timelab: UILabel!
    @IBOutlet weak var autherName: UILabel!
    @IBOutlet weak var image: UIImageView!
    // MARK: - Properties
    var detailsViewModel = DetailsViewModel()
    private let disposeBag = DisposeBag()    
    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationItem.title = "Details"
    }
    // MARK: - Method To Set UP UI
    func setupUI() {
        let imageURL = URL(string: detailsViewModel.DataDetails?.urlToImage ?? " ")
        image.sd_setImage(with:imageURL )
        titleLab.text = detailsViewModel.DataDetails?.title
        timelab.text = detailsViewModel.DataDetails?.publishedAt?.timeConvert()
        DesLab.text = detailsViewModel.DataDetails?.description
        autherName.text = detailsViewModel.DataDetails?.author
    }
}
