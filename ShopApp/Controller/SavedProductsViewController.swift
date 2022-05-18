//
//  SavedProductsViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit


protocol UpdateSavedArray {
    func deleteAllSavedProducts()
}

class SavedProductsViewController: UIViewController, AddtoSaved{
    
    
    
    var delegate: UpdateSavedArray? = nil
    
    @IBOutlet weak var savedTableView: UITableView!
    var savedProducts: [Product] = []
//        didSet {
//            DispatchQueue.main.async {
//                self.savedTableView.reloadData()
//            }
//        }
    
    func saveProduct(arr: [Product]) {
        savedProducts.append(contentsOf: arr)
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        self.savedProducts.removeAll()
        self.delegate?.deleteAllSavedProducts()
        savedTableView.reloadData()
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SavedProductCell", bundle: nil)
        savedTableView.register(nib, forCellReuseIdentifier: "SavedProductCell")
        savedTableView.delegate = self
        savedTableView.dataSource = self
        savedTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    



}

extension SavedProductsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedProducts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = savedTableView.dequeueReusableCell(withIdentifier: "SavedProductCell", for: indexPath) as? SavedProductCell else {
            return UITableViewCell()
        }
                
        let product = savedProducts[indexPath.row]
        cell.configureSavedProducts(product: product)
        return cell
    }
    
    
}




