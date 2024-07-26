//
//  BecomeSuperAgentVM.swift
//  PropDub
//
//  Created by acme on 06/06/24.
//

import UIKit

class BecomeSuperAgentVM: NSObject {
    func becomeSuperAgentApi(param:[String:Any],dictImage: [String: UIImage], _ completion: @escaping(Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.uploadImageWithURL(api: .saveSuperAgent, dictImage: dictImage, parameter: param) { status, msg, response in
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
