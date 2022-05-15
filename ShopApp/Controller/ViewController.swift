//
//  ViewController.swift
//  ShopApp
//
//  Created by developer on 5/11/22.
//

import UIKit

var productCartArr: [Product] = []
class ViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    var products: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductCell")
        tableView.dataSource = self
        tableView.delegate = self
        getData()
    }
    
    deinit {
        print("TV Deinit")
    }
    // 
    func getData() {
        WebService.shared.getProducts { products in
            self.products = products
        }
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected")
        let product = products[indexPath.row]
        self.showAlert(product: product)
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cart Total: \(productCartArr.count)")
    }
    
    
}
extension ViewController {
    func showAlert(product: Product) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionAdd = UIAlertAction(title: "Add To Cart", style: .default) { action in
            self.passingData(product: product)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            print("alert show")
        }
    }
    
    func passingData(product: Product) {
        productCartArr.append(product)
        print("item added to cart \n total items: \(productCartArr.count)")
        cartButton.image = UIImage(systemName: "cart.fill")
        print(product.price!)
    }
}

