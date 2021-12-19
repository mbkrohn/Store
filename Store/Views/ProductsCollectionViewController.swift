//
//  ProductsCollectionViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit


class ProductsCollectionViewController: UIViewController {

    let cellId = "productCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionCell: UICollectionViewCell!
    
    
    var productsModel : ProductsModel?
    var selctedCategory : String?
    
    var products : [Product]? {
        get{
            if let category = selctedCategory {
                return productsModel?.products?[category]
            } else  {
                return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
//        setLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.title = selctedCategory
    }

    
    func loadImage(url:String?)->UIImage?{
        
        guard let url = url, let imageUrl = URL(string: url) else { return nil }
        
        let imageData = try! Data(contentsOf: imageUrl)
        if let image = UIImage(data: imageData){
            return image
        }
        return nil
    }
 
    
//    /*override*/ func viewWillLayoutSubviews1() {
//        let margin: CGFloat = 10
//        let cellsPerRow = 5
//        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//        flowLayout.itemSize =  CGSize(width: itemWidth, height: itemWidth)
//       }
    private let numberOfItemPerRow = 2

    private let screenWidth = UIScreen.main.bounds.width
    private let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let minimumInteritemSpacing = CGFloat(10)
    private let minimumLineSpacing = CGFloat(10)

    // Calculate the item size based on the configuration above
    private var itemSize: CGSize {
        let interitemSpacesCount = numberOfItemPerRow - 1
        let interitemSpacingPerRow = minimumInteritemSpacing * CGFloat(interitemSpacesCount)
        let rowContentWidth = screenWidth - sectionInset.right - sectionInset.left - interitemSpacingPerRow

        let width = rowContentWidth / CGFloat(numberOfItemPerRow)
        let height = width // feel free to change the height to whatever you want

        return CGSize(width: width, height: height)
    }
    
    fileprivate func setLayout1() {
        var layout : UICollectionViewFlowLayout
        layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        print(view.frame.width)
        print(view.frame.height)
        layout.itemSize = CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        collectionView.collectionViewLayout = layout
    }
    
}
    
    // MARK: UICollectionViewDelegate
extension ProductsCollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itemCount = products?.count {
                    return itemCount
                }
                return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionCell
        
        if let productsArray = products {
            let product = productsArray[indexPath.row]
            cell.backgroundColor = .blue
            // productImage
            cell.productImageView.image = loadImage(url: product.imageUrl)
            // Description
            cell.titleLabel.text = product.title
            // Price
            cell.priceLabel.text = "\(product.price ?? 0.0)"
        }
        return cell
    }
    
        
}
    
extension ProductsCollectionViewController : UICollectionViewDelegate{
        
}
    
    
    
    
