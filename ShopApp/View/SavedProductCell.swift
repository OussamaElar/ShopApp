//
//  SavedProductCell.swift
//  ShopApp
//
//  Created by developer on 5/12/22.
//

import UIKit

class SavedProductCell: UITableViewCell {
    
    
    @IBOutlet weak var savedProductLabel: UILabel!
    @IBOutlet weak var savedProductImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // on progress
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureSavedProducts(product: Product) {
        savedProductLabel.text = product.name
        if let imageLink = product.imageUrl {
            self.loadSavedPoductImage(imageUrl:imageLink)
        }
    }
    
    func loadSavedPoductImage(imageUrl: String) {
        WebService.shared.getImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                if let image = image {
                    self.savedProductImg.image = UIImage(data: image)
                }
            }
        }
    }
    
}
