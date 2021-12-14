//
//  ProductsStore.swift
//  Store
//
//  Created by BA Link Ltd on 14/12/2021.
//

import Foundation

class ProductsStore{
    
    var products : [String:[Product]]?
    
    
    
    let productsUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    let createBasketUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    
    func arrangeProductsByType(productList allProducts: [Product]){
        for product in allProducts {
            products?[product.type]?.append(product)
        }
    }

    
     func requestProducts(){
        let url = URL(string: productsUrl)
        
        guard let url = url else {fatalError()}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
         request.addValue("Bearer \(Auth.tokenId)", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error while sending products request: \(error)")
                return
            }
            
            if let safeData = data {
                do {
                    let allProducts = try JSONDecoder().decode([Product].self, from: safeData)
                    self.arrangeProductsByType(productList: allProducts)
                } catch {
                    print("Error while trying to decode products: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
}


struct Product: Codable {
    let id : String
    let title : String
    let type : String
    let description : String
    let filename: String
    let height : Int
    let width : Int
    let price : Float
    let rating : Int
    let imageUrl: String
}

    
    

