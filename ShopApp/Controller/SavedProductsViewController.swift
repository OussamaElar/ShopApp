//
//  SavedProductsViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class SavedProductsViewController: UIViewController {
    
    
    
    @IBOutlet weak var savedTableView: UITableView!
    var savedProducts: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.savedTableView.reloadData()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SavedProductCell", bundle: nil)
        savedTableView.register(nib, forCellReuseIdentifier: "SavedProductCell")
        savedTableView.delegate = self
        savedTableView.dataSource = self
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
//        cell.configureSavedProduct(product: product)
        return cell
    }
    
    
}
