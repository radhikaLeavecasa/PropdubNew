//
//  AddPropertyVM.swift
//  PropDub
//
//  Created by acme on 04/07/24.
//

import UIKit
import ObjectMapper

class AddPropertyVM: NSObject {
    
    var arrCategoryModel: [CategoryModel]?
    var arrSubCategoryModel: [CategoryModel]?
    var arrType: [CategoryModel]?
    
    func categoryApi(_ completion: @escaping (Bool,String) -> Void) {
        WebService.callApi(api: .category, method: .get, param: [:], header: true) { status, msg, response in
            if status == true {
                if let data = response as? [String:Any] {
                    if let list = data["data"] as? [[String:Any]] {
                        if let list2 = Mapper<CategoryModel>().mapArray(JSONArray: list) as [CategoryModel]? {
                            self.arrCategoryModel = list2
                            completion(true, "")
                        }
                    }
                }
            } else {
                completion(true, msg)
            }
        }
    }
    
    func subCategoryApi(_ completion: @escaping (Bool,String) -> Void) {
        WebService.callApi(api: .subCategory, method: .get, param: [:], header: true) { status, msg, response in
            if status == true {
                if let data = response as? [String:Any] {
                    if let list = data["data"] as? [[String:Any]] {
                        if let list2 = Mapper<CategoryModel>().mapArray(JSONArray: list) as [CategoryModel]? {
                            self.arrSubCategoryModel = list2
                            completion(true, "")
                        }
                    }
                }
            } else {
                completion(true, msg)
            }
        }
    }
    
    func typeApi(_ completion: @escaping (Bool,String) -> Void) {
        WebService.callApi(api: .type, method: .get, param: [:], header: true) { status, msg, response in
            if status == true {
                if let data = response as? [String:Any] {
                    if let list = data["data"] as? [[String:Any]] {
                        if let list2 = Mapper<CategoryModel>().mapArray(JSONArray: list) as [CategoryModel]? {
                            self.arrType = list2
                            completion(true, "")
                        }
                    }
                }
            } else {
                completion(true, msg)
            }
        }
    }
}
