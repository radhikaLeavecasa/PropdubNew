//
//  ContactUsVM.swift
//  PropDub
//
//  Created by acme on 30/05/24.
//

import UIKit
import Alamofire

class ContactUsVM: NSObject {
    func contactUsApi(param:[String:Any], _ completion: @escaping (Bool) -> Void) {
        WebService.callApi(api: .contactAgent, method: .post ,param: param,encoding: JSONEncoding.default, header: true) { status, msg, response in
            if status == true {
                if let responseValue = response as? [String: Any] {
//                    if let data = responseValue["data"] as? [String: Any] {
//                        if let data2 = data["Response"] as? [String: Any] {
                            completion(true)
//                            if let insurance = Mapper<InsuranceModel>().map(JSON: data2) as InsuranceModel? {
//                                self.insuranceModel = insurance
//                                self.delegate?.onSuccess()
//                            }
//                        }
//                    }
                }
            }else{
                completion(true)
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
