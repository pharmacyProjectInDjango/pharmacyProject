//
//  Category.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 6/14/21.
//

import Foundation

struct Category: Decodable {
    var id: Int
    var name: String
    
    enum CodingKeys : String, CodingKey {
        case id, name
    }
}

struct CategoryRequest: Decodable {
    let categories: [Category]
    
    enum CodingKeys : String, CodingKey {
        case categories = "results"
    }
}
