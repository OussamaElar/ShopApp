//
//  CartViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate {
    
    var vc = ViewController()

    @IBOutlet weak var cartTableView: UITableView!
    
    func cartTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vc.productCartArr.count
    }
    
    
    func cartTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartCell else {
            return UITableViewCell()
        }
        let product = vc.productCartArr[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    

}
