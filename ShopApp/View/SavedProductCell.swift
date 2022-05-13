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
    
}
