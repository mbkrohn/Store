//
//  Favort.swift
//  Store
//
//  Created by user210577 on 12/18/21.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var cart : Cart?
    var cartIterator : Set<Product>.Iterator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cart = (UIApplication.shared.delegate as! AppDelegate).cart
        
//        let p1 = Product(id: "firstp", title: "FirstP", type: nil, description: nil, filename: nil, height: nil, width: nil, price: nil, rating: nil, imageUrl: nil)
//        let p2 = Product(id: "secondp", title: "SecondP", type: nil, description: nil, filename: nil, height: nil, width: nil, price: nil, rating: nil, imageUrl: nil)
//        cart?.addProduct(newProduct: p1)
//        cart?.addProduct(newProduct: p2)
//
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let cart = cart {
            return cart.shoppingCart.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)

        if cartIterator == nil{
            cartIterator = cart?.shoppingCart.makeIterator()
        }

        let product = cartIterator?.next()
        
        let productTitle = product?.title
        if productTitle != nil
        {
            cell.textLabel?.text = productTitle
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
