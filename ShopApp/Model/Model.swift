//
//  Model.swift
//  ShopApp
//
//  Created by developer on 5/11/22.
//

import Foundation

struct Product: Decodable {
    let brand: String
    let name: String
    let imageUrl: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
    case imageUrl = "image_link"
    case name, brand, price
    }
}
