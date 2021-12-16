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
    var categories = ProductsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categories.requestProducts(actionOnResponse: {isValidResponse in
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
        categories.categoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = categories.categoriesList[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension CategoriesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), let cellText = cell.textLabel?.text {
            selectedCategory = cellText
            performSegue(withIdentifier: segueId, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsView = segue.destination as! ProductsCollectionViewController
        productsView.selctedCategory = selectedCategory
        if let selectedCategory = selectedCategory {
            productsView.products = categories.getProducts(forCategory: selectedCategory)
        }
    }
}

