//
//  TypesViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    let segueId = "categories2products"
    let cellId = "categoryCell"
    
    var selectedCategory : String?
    
    @IBOutlet var categoriesTableView: UITableView!
    var products : ProductsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = (UIApplication.shared.delegate as! AppDelegate).productsModel
        guard products != nil else { fatalError() }
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        
        products!.requestProducts(actionOnResponse: {isValidResponse in
            DispatchQueue.main.async {
                if(isValidResponse){
                    self.categoriesTableView.reloadData()
                }
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
}

//MARK: UITableViewDataSource

extension CategoriesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = products?.categories?[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension CategoriesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = products?.categories?[indexPath.row]
        DispatchQueue.main.async { [weak self] in
            if let segue = self?.segueId {
                self?.performSegue(withIdentifier: segue, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsView = segue.destination as! ProductsCollectionViewController
        
        productsView.productsModel = products
        productsView.selctedCategory = selectedCategory
    }
}

