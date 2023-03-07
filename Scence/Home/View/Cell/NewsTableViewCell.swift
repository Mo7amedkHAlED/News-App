//
//  NewsTableViewCell.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    static let ID = String(describing: NewsTableViewCell.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var NewsTime: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        addShadow()
    }
    // MARK: -  View Life Cycle
    func cellSetup(_ model: Article) {
        let image = model.urlToImage
        let imageURL = URL(string: image ?? " ")
        newsImage.sd_setImage(with: imageURL)
        newsTitle.text = model.title
        newsDescription.text = model.description
        newsAuthor.text = model.author
        NewsTime.text = model.publishedAt?.timeConvert()
    }
    // MARK: - Method To Add Shadow To View
    func addShadow(){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 8
    }
}
