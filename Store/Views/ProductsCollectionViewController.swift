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
    
    
    var productsModel : ProductsModel?
    var selctedCategory : String?
    
    var products : [Product]? {
        get{
            if let category = selctedCategory {
                return productsModel?.getProducts(forCategory: category)
            } else  {
                return nil
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didChangedProductSelection, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSelection(_:)), name: .didChangedProductSelection, object: nil)
        
        setLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        self.title = selctedCategory
    }

    @objc func didChangeSelection(_ notification: Notification){
        collectionView.reloadData()
    }
    
    
    func loadImage(url:String?)->UIImage?{
        
        guard let url = url, let imageUrl = URL(string: url) else { return nil }
        
        let imageData = try! Data(contentsOf: imageUrl)
        if let image = UIImage(data: imageData){
            return image
        }
        return nil
    }
 
    
    private let numberOfItemPerRow = 3

//    /*private*/ let screenWidth = UIScreen.main.bounds.width
//    /*private*/ let sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//    /*private*/ let minimumInteritemSpacing = CGFloat(10)
//    /*private*/ let minimumLineSpacing = CGFloat(10)
//
//    // Calculate the item size based on the configuration above
//    private var itemSize: CGSize {
//        let interitemSpacesCount = numberOfItemPerRow - 1
//        let interitemSpacingPerRow = minimumInteritemSpacing * CGFloat(interitemSpacesCount)
//        let rowContentWidth = screenWidth - sectionInset.right - sectionInset.left - interitemSpacingPerRow
//
//        let width = rowContentWidth / CGFloat(numberOfItemPerRow)
//        let height = width // feel free to change the height to whatever you want
//
//        return CGSize(width: width, height: height)
//    }
    
    fileprivate func setLayout() {
        let layout = UICollectionViewFlowLayout()
        //layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        print(view.frame.width)
        print(view.frame.height)
        layout.itemSize = CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
       // layout.itemSize = itemSize

        collectionView.collectionViewLayout = layout
    }
    
}
    
    // MARK: UICollectionViewDelegate
extension ProductsCollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itemCount = products?.count {
                    return itemCount
                }
                return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionCell
        
        if let productsArray = products {
            let product = productsArray[indexPath.row]

            // productImage
            cell.productImageView.image = loadImage(url: product.imageUrl)

            // title
            cell.titleLabel.text = product.title

            // price
            cell.priceLabel.text = "\(product.price ?? 0.0)"
            
            // heartButton
            if product.isSelected != nil && product.isSelected! {
                cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            } else {
                cell.heartButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            }
            
            cell.productId = product.id
//            cell.productCellDelegate = self
            
            print("cellForRowAt")
        }
        return cell
    }
    
    
//    func getProduct(byId productId : String)->Product?{
//        return products?.first(where: {$0.id == productId })
//    }
    
    
    
}
    

extension ProductsCollectionViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cv = collectionView
//        let cell = cv.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionCell
        if let product = products?[indexPath.row] {
            let userInfo = [product.id : product]
            NotificationCenter.default.post(name: .didRequestSelectionChange, object: nil, userInfo: userInfo)
        }
//        cell.heartButton.sendActions(for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

}

//extension ProductsCollectionViewController : ProductCollectionCellDelegate {
//
//    func heartPressed(_ sender: UIButton, for productId : String) {
//        guard product = cart?.getProduct(byId: productId) else { return }
//
//        if product.isSelected != nil {
//            product.isSelected = !product.isSelected!
//        } else {
//            product.isSelected = true
//        }
//        collectionView.reloadData()
//    }
//}

//
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//
//
//
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//
//    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
//        return true
//    }
//
//    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
//        self.printThatItWorked()
//    }
//
//    func printThatItWorked()
//    {
//        println("It worked")
//    }
//




    
    

    
