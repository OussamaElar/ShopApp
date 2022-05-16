//
//  ProductCell.swift
//  ShopApp
//
//  Created by developer on 5/11/22.
//

import UIKit
import QuartzCore

class ProductCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var brand: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configure(product: Product) {
        price.text = "Price: " + "$\(product.price ?? " " )"
        price.layer.cornerRadius = 2
        price.layer.masksToBounds = true
        name.text = product.name
        brand.text = "Brand: " + "\(product.brand ?? " " )"
        if let imageLink = product.imageUrl {
            self.loadImage(imageUrl: imageLink)
        }
    }
    
    func loadImage(imageUrl: String) {
        WebService.shared.getImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: image!)
            }
        }
    }
    
}
