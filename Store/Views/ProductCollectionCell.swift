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
    var isSelectedProoduct = false
    
    var productCellDelegate : ProductCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartPressed(_ sender: UIButton) {
        guard productId != nil  else { return }
        isSelectedProoduct = !isSelectedProoduct
        print(sender)
        if isSelectedProoduct {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        productCellDelegate?.heartPressed(forProduct: productId!, toAdd: isSelectedProoduct)
    }
    
}


protocol ProductCollectionCellDelegate{
    func heartPressed(forProduct productId :String, toAdd: Bool)
}


