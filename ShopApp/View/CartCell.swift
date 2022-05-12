//
//  CartCell.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class CartCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var items: [Product] = []
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.textLabel?.text = "\(item)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapping cell \(indexPath.section) \(indexPath.row)")
    }

    @IBOutlet weak var tableView: UITableView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
