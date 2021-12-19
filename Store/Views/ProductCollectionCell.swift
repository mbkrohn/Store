//
//  ProductCollectionCell.swift
//  Store
//
//  Created by BA Link Ltd on 19/12/2021.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
