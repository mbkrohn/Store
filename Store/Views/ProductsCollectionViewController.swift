//
//  ProductsCollectionViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductsCollectionViewController: UICollectionViewController {

    var selctedCategory : String?
    var products : [Product]? {
        get{
            if Auth.isLoggedIn {
                return products
            } else {
                return nil
            }
               
        }
        set{}
        
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.title = selctedCategory
    }

// MARK:- UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let itemCount = products?.count {
            return itemCount
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionCell
        
        if let products = products {
            let product = products[indexPath.row]
            cell.backgroundColor = .blue
            // productImage
            cell.productImage.image = loadImage(url: product.imageUrl)
            // Description
            cell.descriptionLabel.text = product.description
            // Price
            cell.priceLabel.text = "\(product.price ?? 0.0)"
        }
    
        return cell
    }

    
    func loadImage(url:String?)->UIImage?{
        
        guard let url = url, let imageUrl = URL(string: url) else { return nil }
        
        let imageData = try! Data(contentsOf: imageUrl)
        if let image = UIImage(data: imageData){
            return image
        }
        return nil
    }
    
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // if var cell = collectionView.cellForItem(at: indexPath) as! ProductCollectionCell {
        //   let heart = cell.heartButton.        }
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
