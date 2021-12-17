//
//  Basket.swift
//  Store
//
//  Created by BA Link Ltd on 15/12/2021.
//

import UIKit

class Cart{
    
    let cartFileName : String
    var cartFile : URL?
    var shoppingCart : Set<Product>?
    
    init(storgeFileName : String = "cart.plist"){
        self.cartFileName = storgeFileName
    }
    
    
    func addProduct(newProduct : Product){
        if var shopCart = shoppingCart {
//            if shopCart.first(where: { $0 == newProduct }) == nil {
                shopCart.insert(newProduct)
//            }
        } else {
            shoppingCart = [newProduct]
        }
    }
    
    func removeProduct(productToRemove: Product){
        if var shopCart = shoppingCart {
//            shopCart.removeAll(where: { $0 == productToRemove })
            shopCart.remove(productToRemove)
        }
    }
    
    func emptyBasket(){
        if var favorites = shoppingCart {
            favorites.removeAll()
        }
    }
    

    fileprivate func createStorage(){
        do {
            cartFile = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor: nil, create: true ).appendingPathComponent(cartFileName)
        } catch {
            print("Error while creating file \(error)")
        }
    }
    
    // this is called before closing the app
    func saveCartItemsToFile(){
        guard let shopCart = shoppingCart else {return }
        if shopCart.isEmpty { return }
            
        let encoder = PropertyListEncoder()
        if let cartFile = cartFile {
            do {
                let data = try encoder.encode(shoppingCart)
                try data.write(to: cartFile)
            } catch {
                print("Error while saving shopping cart to file \(error)")
            }
        }
    }
    
    // this is called when the app loads
    func loadCartItemsFromFile(){
        let decoder = PropertyListDecoder()
        if let cartFile = cartFile {
            do {
                let data = try Data(contentsOf: cartFile)
                shoppingCart = try decoder.decode(Set<Product>.self, from: data)
            } catch {
                print("Error while reading shopping cart from file \(error)")
            }
        }
    }
    
    
}
