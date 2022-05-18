//
//  CartViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var priceTotal: UILabel!
    @IBOutlet weak var cartTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProductArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartCell else {
            return UITableViewCell()
        }
        let product = cartProductArr[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    // deleeting a cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartProductArr.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            deletedCartItem()
            
            tableView.endUpdates()
        }
    }
    
    var cartProductArr: [Product] = productCartArr {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
         }
   public func totalCartValue() {
        var cartPriceTotal: Double = 0
        for (x,_) in productCartArr.enumerated() {
            cartPriceTotal += Double(productCartArr[x].price!)!
        }
        priceTotal.text = "$\(cartPriceTotal)"
    }
    func deletedCartItem() {
        var cartPriceTotal: Double = 0
        for product in cartProductArr {
            cartPriceTotal = Double(product.price!)!
        }
        for product in cartProductArr {
            cartPriceTotal -= Double(product.price!)!
        }
        //        for (x,_) in productCartArr.enumerated() {
        //            cartPriceTotal = Double(priceTotal.text!)! - Double(productCartArr[x].price!)!
        priceTotal.text = "$\(cartPriceTotal)"
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "CartCell", bundle: nil)
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "CartCell")
        totalCartValue()
        

        // Do any additional setup after loading the view.
    }

}
