//
//  LoginVM.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit

class LoginVM: NSObject {
    func userLoginApi(param:[String:Any], _ completion: @escaping (Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .userLogin, method: .post, param: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if response is [String: Any] {
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
    
    func superAgentLoginApi(param:[String:Any], _ completion: @escaping (Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .superAgentLogin, method: .post, param: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if response is [String: Any] {
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
    
    func agentLoginApi(param:[String:Any], _ completion: @escaping (Bool, String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .agentLogin, method: .post, param: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    let userData = data[CommonParam.DATA] as? [String:Any] ?? [:]
                    Cookies.userInfoSave(dict:userData)
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
}
