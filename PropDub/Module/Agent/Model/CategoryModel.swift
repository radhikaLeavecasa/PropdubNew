//
//  CategoryModel.swift
//  PropDub
//
//  Created by acme on 04/07/24.
//

import UIKit
import ObjectMapper

struct CategoryModel: Mappable {
    var id: Int = 0
    var name: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}
