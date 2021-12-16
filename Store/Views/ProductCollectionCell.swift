//
//  ProductCollectionCell.swift
//  Store
//
//  Created by BA Link Ltd on 16/12/2021.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {

    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }

}
