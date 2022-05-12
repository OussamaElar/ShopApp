//
//  CartCell.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class CartCell: UITableViewCell {
    
    var pc = ProductCell()
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(product: Product) {
        productPrice.text = "$\(product.price ?? "")"
        productName.text = product.name
        self.loadImage(imageUrl: product.imageUrl!)
    }
    
    func loadImage(imageUrl: String) {
        WebService.shared.getImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                self.cartImageView.image = UIImage(data: image!)
            }
        }
    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
