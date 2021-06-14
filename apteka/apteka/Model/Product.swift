//
//  Product.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 5/1/21.
//

import Foundation
import UIKit

struct Product: Decodable {
    var id: Int
    var image: String
    var title: String
    var category: Int
    var price: String
    var description: String
    
    enum CodingKeys : String, CodingKey {
        case id, category, title, image, price, description
    }
}

struct ProductRequest: Decodable {
    let products: [Product]
    
    enum CodingKeys : String, CodingKey {
        case products = "results"
    }
}
