//
//  AddPropertyTwoVCM.swift
//  PropDub
//
//  Created by acme on 09/08/24.
//

import UIKit

class AddPropertyTwoVM: NSObject {
    func addAgentPropertyApi(param:[String:Any], dictImage: [String: UIImage], _ completion: @escaping(Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.uploadImageWithURL(api: .addAgentProperty(Cookies.userInfo()?.id ?? 0), dictImage: dictImage, parameter: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status {
                let responseData = response as? [String:Any] ?? [:]
                completion(true, msg)
            }else{
                completion(false, msg)
            }
        }
    }
}
