//
//  TypesViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet var categoriesTableView: UITableView!
    var categories = ProductsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categories.requestProducts(actionOnResponse: whatever)

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
        let cell = UITableViewCell()
        cell.textLabel?.text = categories.categoriesList[indexPath.row]
        return cell
    }
    

    func whatever(isValidStatus: Bool){
        DispatchQueue.main.async {
            if(isValidStatus){
                self.categoriesTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CategoriesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

