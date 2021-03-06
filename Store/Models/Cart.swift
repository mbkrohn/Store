//
//  Basket.swift
//  Store
//
//  Created by BA Link Ltd on 15/12/2021.
//

import UIKit

class Cart{
    
    let cartFileName : String
    var shoppingCart : Set<Product>
    
    init(storgeFileName : String = "cart.plist"){
        self.cartFileName = storgeFileName
        shoppingCart = Set<Product>()
    }
    
    
    func addProduct(newProduct : Product){
        shoppingCart.insert(newProduct)
    }
    
    func removeProduct(productToRemove: Product){
        shoppingCart.remove(productToRemove)
    }
    
    func removeProduct(productId: String){
        if let found = getProduct(byId: productId) {
            shoppingCart.remove(found)
        }
    }
    
    func getProduct(byId productId : String)->Product? {
        if shoppingCart.isEmpty { return nil }
        return shoppingCart.first(where: { $0.id == productId})
    }
    
    func emptyBasket(){
        shoppingCart.removeAll()
    }
    
    
    // this is called before closing the app
    func saveCartItemsToFile(){
        guard shoppingCart.isEmpty else { return }
        
        var cartFile : URL?
        do {
            cartFile = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor: nil, create: false ).appendingPathComponent(cartFileName)
        } catch {
            print("Error while creating cart storage file\(error)")
        }
        
        if let path=cartFile?.path, !FileManager.default.fileExists(atPath: path){
            return
        }
        
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
        var cartFile : URL?
        do {
            cartFile = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor: nil, create: false ).appendingPathComponent(cartFileName)
        } catch {
            print("Error while creating cart storage file\(error)")
        }
        
        if let path=cartFile?.path, !FileManager.default.fileExists(atPath: path){
            return
        }
        
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
