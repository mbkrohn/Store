//
//  Basket.swift
//  Store
//
//  Created by BA Link Ltd on 15/12/2021.
//

import UIKit

class Basket{
    var favoriteProducts : [Product]?
    
    func addProduct(newProduct : Product){
        if var favorites = favoriteProducts {
            favorites.append(newProduct)
        } else {
            favoriteProducts = [newProduct]
        }
    }
    
    func removeProduct(productToRemove: Product){
        if var favorites = favoriteProducts {
            favorites.removeAll(where: { $0 == productToRemove })
        }
    }
    
    func emptyBasket(){
        if var favorites = favoriteProducts {
            favorites.removeAll()
        }
    }
    

    
    
}
