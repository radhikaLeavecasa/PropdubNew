//
//  OtpVM.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit

class OtpVM: NSObject {
    func otpVerifyApi(_ param:[String:AnyObject], _ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .verifyUserLogin, method: .post, param: param, header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
//                    let data2 = data["data"] as? [String:Any]
//                    self.id = data2?["id"] as? Int ?? 0
//                    GetData.share.saveUserToken(token: "\(self.id)")
                    let userData = data[CommonParam.DATA] as? [String:Any] ?? [:]
                    Cookies.userInfoSave(dict:userData)
                   // GetData.share.saveUserToken(token: response[CommonParam.USER_TOKEN] as? String ?? "")
                    completion(true, "")
                }
            } else {
                completion(true, msg)
            }
        }
    }
}
