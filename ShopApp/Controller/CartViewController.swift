//
//  CartViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    var cartProductArr: [Product] = [] {
            didSet {
                DispatchQueue.main.async {
                    self.cartTableView.reloadData()
                }
            }
         }
    
    func cartTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProductArr.count
    }
    
    
    func cartTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartCell else {
            return UITableViewCell()
        }
        let product = cartProductArr[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)

        // Do any additional setup after loading the view.
    }
    

}
