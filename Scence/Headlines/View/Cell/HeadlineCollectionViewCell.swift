//
//  HeadlineCollectionViewCell.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import UIKit

class HeadlineCollectionViewCell: UICollectionViewCell {
    static let ID = String(describing: HeadlineCollectionViewCell.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var headlineView: UIView!
    @IBOutlet weak var autherName: UILabel!
    @IBOutlet weak var titlelab: UILabel!
    @IBOutlet weak var headlineImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        
    }
    // MARK: - Method To Set UP Cell
    func SetupCell(_ model : Article){
        let imageURL = URL(string: model.urlToImage ?? " ")
        headlineImage.sd_setImage(with: imageURL)
        titlelab.text = model.title
        autherName.text = model.author
        
    }
    // MARK: - Method To Add Shadow To View
    func addShadow(){
        headlineView.layer.shadowColor = UIColor.gray.cgColor
        headlineView.layer.shadowOpacity = 0.3
        headlineView.layer.shadowOffset = CGSize.zero
        headlineView.layer.shadowRadius = 6
        headlineView.layer.cornerRadius = 8
    }

}
