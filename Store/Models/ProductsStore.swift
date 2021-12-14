//
//  ProductsStore.swift
//  Store
//
//  Created by BA Link Ltd on 14/12/2021.
//

import Foundation

struct ProductsStore{
    
    let tokenId = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImpvaG4uZG9lQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6IkpvaG4iLCJsYXN0bmFtZSI6IkpvaG4iLCJpYXQiOjE2Mzk0ODM2ODF9.oke_d_y4Lxjjj-ENWqqmDUl45szRsRXLxP6lhOcyYRY"
    
    let productsUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    let createBasketUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    func requestProducts(){

        let url = URL(string: productsUrl)
        
        guard let url = url else {fatalError()}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        
        
        //request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
        request.addValue("Basic  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImpvaG4uZG9lQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6IkpvaG4iLCJsYXN0bmFtZSI6IkpvaG4iLCJpYXQiOjE2Mzk0ODM2ODF9.oke_d_y4Lxjjj-ENWqqmDUl45szRsRXLxP6lhOcyYRY", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error while sending products request: \(error)")
                return
            }
            
            if let safeData = data {
                do {
                    let products = try JSONDecoder().decode([Product].self, from: safeData)
                    print(products)
                } catch {
                    print("Error while trying to decode products: \(error)")
                }
            }
        }
        task.resume()
    }
    
}

struct Products : Codable {
    let product : [Product]
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

    
    

