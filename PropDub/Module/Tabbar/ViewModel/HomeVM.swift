//
//  HomeVM.swift
//  PropDub
//
//  Created by acme on 22/05/24.
//

import UIKit
import ObjectMapper

class HomeVM: NSObject {
    
    var homeData: HomeModel?
    var arrDeveloperList: [DeveloperModel]?
    var arrPremiumList = [DataItemModel]()
    var arrFreshFinds = [DataItemModel]()
    var arrTrendingList = [DataItemModel]()
    
    func getHomeApi(_ completion: @escaping() -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .homeApi, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    let homeData = HomeModel(JSON: data)
                    Proxy.shared.arrPropertyList = homeData?.data
                    for i in homeData?.data ?? [] {
                        if ((i.type?.range(of: "featured", options: .caseInsensitive)) != nil) {
                            self.arrPremiumList.append(i)
                        } 
                        if (i.cat!.contains("Fresh Finds")) || (i.type!.contains("Fresh Finds")) {
                            self.arrFreshFinds.append(i)
                        } 
                        if (i.type?.range(of: "Hot Selling", options: .caseInsensitive) != nil) {
                            self.arrTrendingList.append(i)
                        }
                    }
                    completion()
                }
            } else {
                //view.pushNoInterConnection(view: view, titleMsg: "Alert", msg: msg)
            }
        }
    }
    
    func developerHomeApi(_ completion: @escaping() -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .developerApi, method: .get, param: [:], header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    let responseModel = Mapper<HomeModel>().map(JSON: data)
                    self.arrDeveloperList = responseModel?.dataDeveloper ?? []
                    completion()
                }
            } else {
                //view.pushNoInterConnection(view: view, titleMsg: "Alert", msg: msg)
            }
        }
    }
}
