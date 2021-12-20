//
//  ProductsStore.swift
//  Store
//
//  Created by BA Link Ltd on 14/12/2021.
//

import UIKit
extension Notification.Name{
    static let didRequestSelectionChange = Notification.Name("didRequestSelectionChange")
    static let didChangedProductSelection = Notification.Name("didChangedProductSelection")
}

class ProductsModel{
    
    // MARK: - Url's
    static let productsUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    static let createBasketUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    // MARK: - Properties
    private var allProducts : [Product]?
    
    
    var products : [Product]?{
        get{
            if !Auth.isLoggedIn {
                allProducts = nil
            }
            return allProducts
        }
        set{
            allProducts = newValue
        }
    }
    
    
    var categories : [String]{
        get{
            var categoriesSet = Set<String>()
            if let productsArray = products {
                for product in productsArray {
                    categoriesSet.insert(product.type ?? "misc")
                }
            }
            return categoriesSet.map{$0}
        }
    }
    
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeIsSelected(_:)), name: .didRequestSelectionChange, object: nil)
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .didRequestSelectionChange, object: nil)
    }
    
    
    @objc func changeIsSelected(_ notification: Notification){
        guard let productId = notification.userInfo?.first?.key as? String else { return }
        guard products != nil, let index = products?.firstIndex(where: {$0.id == productId}) else { return }
        
        if let isSelected = products![index].isSelected {
            products![index].isSelected = !isSelected
        } else {
            products![index].isSelected = true
        }
        
        NotificationCenter.default.post(name: .didChangedProductSelection, object: self, userInfo: [productId : products![index]])
    }
    
    
    
    func requestProducts(actionOnResponse: @escaping(Bool)->Void){
        let url = URL(string: ProductsModel.productsUrl)
        
        guard let url = url else {fatalError()}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let tokenStr = "Bearer \(String(describing: Auth.tokenId!))"
        request.addValue(tokenStr, forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error while sending products request: \(error)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            let isValidStatus = self.isValidStatusCode(statusCode : statusCode)
            if isValidStatus {
                if let safeData = data {
                    do {
                        self.products = try JSONDecoder().decode([Product].self, from: safeData)
                    } catch {
                        print("Error while trying to decode products: \(error)")
                    }
                }
            }
            actionOnResponse(isValidStatus)
        }
        task.resume()
    }
    
    
    func getProducts(forCategory category : String)->[Product]{
        var categoryProducts = [Product]()
        if let prodcutDict = products {
            for product in prodcutDict {
                if product.type == category {
                    categoryProducts.append(product)
                }
            }
        }
        return categoryProducts
    }
    
    // MARK: - Private methods
    
    fileprivate func isValidStatusCode(statusCode: Int)-> Bool{
        switch statusCode{
        case 200..<299:
            return true
        default:
            return false
        }
    }
}

// MARK: - 
struct Product: Codable, Hashable{
    
    let id : String?
    let title : String?
    let type : String?
    let description : String?
    let filename: String?
    let height : Int?
    let width : Int?
    let price : Float?
    let rating : Int?
    let imageUrl: String?
    var isSelected : Bool?
}




