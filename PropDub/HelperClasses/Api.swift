//
//  Api.swift
//  Josh
//
//  Created by Esfera-Macmini on 12/04/22.
//

import Foundation

let baseUrl = "https://admin.propdub.com/api/"
let imageBaseUrl = "https://admin.propdub.com/"

extension Api {
    func baseURl() -> String {
        return baseUrl + self.rawValued()
    }
}

enum Api: Equatable {
    
    case homeApi
    case developerApi
    case saveSuperAgent
    case contactAgent
    case userLogin
    case verifyUserLogin
    case superAgentLogin
    case agentLogin
    case category
    case subCategory
    case type
   
    func rawValued() -> String {
        switch self {
        case .homeApi:
            return "projectapi"
        case .developerApi:
            return "developerapi"
        case .saveSuperAgent:
            return "save-super-agent"
        case .contactAgent:
            return "contact"
        case .userLogin:
            return "send-otp"
        case .verifyUserLogin:
            return "verify-user-otp"
        case .superAgentLogin:
            return "send-user-otp"
        case .agentLogin:
            return "login"
        case .category:
            return "categoryapi"
        case .subCategory:
            return "subcategoryapi"
        case .type:
            return "typeapi"
        }
    }
}

func isSuccess(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    if let isSucess = json["status"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["success"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["status"] as? String {
        if isSucess == "success" {
            return true
        }
    }
    if let isSucess = json["success"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    
    if let isSucess = json["code"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    
    if let isSucess = json["success"] as? Bool {
        if isSucess == true {
            return true
        }
    }
    
    if let isSucess = json["status"] as? Bool {
        if isSucess == true {
            return true
        }
    }
    return false
}

func isInActivate(json : [String : Any]) -> Bool{
    if let isSucess = json["code"] as? Int {
        if isSucess == 401 {
            return true
        }
    }
    return false
}

func isAlreadyLogin(json : [String : Any]) -> Bool{
    if let isSucess = json["code"] as? Int {
        if isSucess == 403 {
            return true
        }
    }
    return false
}

func isAlreadyAdded(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 405 {
            return true
        }
    }
    return false
}

func isDocumentVerificationFalse(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 402 {
            return true
        }
    }
    return false
}

func isMobileVarifiedFalse(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 402 {
            return true
        }
    }
    return false
}

func message(json : [String : Any]) -> String{
    if let message = json["message"] as? String {
        return message
    }
    if let message = json["message"] as? [String:Any] {
        if let msg = message.values.first as? [String] {
            return msg[0]
        }
    }
    if let error = json["error"] as? String {
        return error
    }
    
    return " "
}

func isBodyCount(json : [[String : Any]]) -> Int{
    return json.count
}
