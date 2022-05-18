//
//  CartViewController.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

protocol UpdateCartArray {
    func deletFromArray(index: Int)
    func deletAllCart()
}

protocol AddtoSaved {
    func saveProduct(arr: [Product])
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var priceTotal: UILabel!
    @IBOutlet weak var cartTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cartProductArr: [Product] = []
    
    var delgate: UpdateCartArray? = nil
    var savedProductDelegate: AddtoSaved? = nil
    
    @IBAction func saveProducts(_ sender: UIBarButtonItem) {
        self.savedProductDelegate?.saveProduct(arr: cartProductArr)
        self.cartProductArr.removeAll()
        self.delgate?.deletAllCart()
        self.totalCartValue()
        self.tableView.reloadData()
    }
    
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
    
    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion -> Void in
            print("index: ", indexPath.row)
            print("cartCount: ", self.cartProductArr.count)
            self.delgate?.deletFromArray(index: indexPath.row)
            self.cartProductArr.remove(at: indexPath.row)
            self.totalCartValue()
            self.tableView.reloadData()
            completion(true)
        }
        return action
    }
    
//    private func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UIContextualAction {
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion -> Void in
//            self.cartProductArr.remove(at: indexPath.row)
//            completion(true)
//        }
//        return deleteAction
//    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            cartProductArr.remove(at: indexPath.row)
////            deletedCartItem()
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//            tableView.endUpdates()
//        }
//    }
    
    
    
   public func totalCartValue() {
        var cartPriceTotal: Double = 0
        for (x,_) in cartProductArr.enumerated() {
            cartPriceTotal += Double(cartProductArr[x].price!)!
        }
        priceTotal.text = "$\(cartPriceTotal)"
    }
    func deletedCartItem() -> Double{
        var cartPriceTotal: Double = 0
        for (x,_) in cartProductArr.enumerated() {
            cartPriceTotal = Double(priceTotal.text!)! - Double(cartProductArr[x].price!)!
        }
        return cartPriceTotal
//        priceTotal.text = "$\(cartPriceTotal)"
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "CartCell", bundle: nil)
        super.viewDidLoad()
        print("cartItems: ", cartProductArr.count)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "CartCell")
        totalCartValue()
        


        // Do any additional setup after loading the view.
    }

}
