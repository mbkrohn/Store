//
//  ProductsStore.swift
//  Store
//
//  Created by BA Link Ltd on 14/12/2021.
//

import UIKit

class ProductsStore{
    
    // MARK: - Url's
    
    static let productsUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    static let createBasketUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    // MARK: - Properties
    
    var products : [String:[Product]]?
    
    var categoriesList : [String]{
        get{
            var categoriesArray = [String]()
            if let productsDict = products {
                categoriesArray = productsDict.keys.map{String($0)}
            }
            return categoriesArray
        }
    }
    
    // MARK: - Methods
    
    func requestProducts(actionOnResponse:@escaping(Bool)->Void){
        let url = URL(string: ProductsStore.productsUrl)
        
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
                        let allProducts = try JSONDecoder().decode([Product].self, from: safeData)
                        self.arrangeProductsByType(productsList: allProducts)
                    } catch {
                        print("Error while trying to decode products: \(error)")
                    }
                }
            }
            actionOnResponse(isValidStatus)
        }
        task.resume()
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
    
    fileprivate func arrangeProductsByType(productsList: [Product]) {
        products = [String:[Product]]()
        // seek through the list of products and add all product of the same type to the collection
        // under the right key (key=product.type)
        for product in productsList {
            let productType = product.type ?? "Misc"
                if var categoryList = products?[productType]{
                    categoryList.append(product)
                } else {
                    products?[productType] = [product]
                }
        }
    }
    
    
    
    
}

// MARK: - 
struct Product: Codable, Equatable {
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
}




