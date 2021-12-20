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
    
    var productId : String?
    
    var productCellDelegate : ProductCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartPressed(_ sender: UIButton) {
        if let prodId = productId {
            NotificationCenter.default.post(name: .didRequestSelectionChange, object: nil, userInfo: [prodId: prodId])
//            productCellDelegate?.heartPressed(sender, for: prodId)
        }
    }
    
}


protocol ProductCollectionCellDelegate{
    func heartPressed(_ sender: UIButton, for productId: String)
}


