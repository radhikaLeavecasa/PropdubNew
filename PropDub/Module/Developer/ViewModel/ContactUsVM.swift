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
        WebService.callApi(api: .contactAgent, method: .post ,param: param,encoding: JSONEncoding.default, header: true) { status, msg, response in
            if status == true {
                if response is [String: Any] {
                    completion(true, "")
                }
            }else{
                completion(false, msg)
                //                LoaderClass.shared.stopAnimation()
                //                if msg == CommonError.INTERNET{
                //                    view.pushNoInterConnection(view: view)
                //                }else{
                //                    view.pushNoInterConnection(view: view,titleMsg: "Alert!", msg: msg)
                //                }
            }
        }
    }
}
