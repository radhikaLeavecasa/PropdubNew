//
//  ContactUsVM.swift
//  PropDub
//
//  Created by acme on 30/05/24.
//

import UIKit
import Alamofire

class ContactUsVM: NSObject {
    func contactUsApi(param:[String:Any], _ completion: @escaping (Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .contactAgent, method: .post ,param: param,encoding: JSONEncoding.default, header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if response is [String: Any] {
                    completion(true, "")
                }
            }else{
                completion(false, msg)
            }
        }
    }
}
