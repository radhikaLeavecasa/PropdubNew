//
//  TabbarVC.swift
//  LeaveCasa
//
//  Created by acme on 08/09/22.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    //MARK: - Variables
    var Index = 2
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabbar()
//        if LoaderClass.shared.isFirstTime {
//            // Check App New Update Available
//            VersionCheck.shared.checkForUpdate { (isUpdate) in
//                if isUpdate {
//                    DispatchQueue.main.async {
//                        Alert.showAlertWithOkCancel(message: "Upgrade your travel experience. New features just a click away!", actionOk: "Update", actionCancel: "Skip") {
//                            if let url = URL(string: "https://apps.apple.com/in/app/leavecasa/id1640461250"),
//                               UIApplication.shared.canOpenURL(url){
//                                if #available(iOS 10.0, *) {
//                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                                } else {
//                                    UIApplication.shared.openURL(url)
//                                }
//                            }
//                        } completionCancel: {
//                            LoaderClass.shared.isFirstTime = false
//                        }
//                    }
//                }
//            }
//        }
    }
    //MARK: - Setup Tabbar ViewController
    func setupTabbar(){
        
        self.tabBar.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        self.tabBar.layer.shadowRadius = 8
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        self.tabBar.layer.cornerRadius = 15
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .darkGray
        
        //ADD View Controllers
        let developer = ViewControllerHelper.getViewController(ofType: .DeveloperVC, StoryboardName: .Main) as! DeveloperVC
        let developerIcon = UITabBarItem(title: "Developers", image: UIImage(named: "ic_developer_unselected"), selectedImage: UIImage(named: "ic_developer_selected"))
        developer.tabBarItem = developerIcon
        
        let home = ViewControllerHelper.getViewController(ofType: .HomeVC, StoryboardName: .Main) as! HomeVC
        let homeIcon = UITabBarItem(title: "Home", image: UIImage(named: "ic_home_unselected"), selectedImage: UIImage(named: "ic_home_selected"))
        home.tabBarItem = homeIcon
        
        let property = ViewControllerHelper.getViewController(ofType: .HomeVC, StoryboardName: .Main) as! HomeVC
        let propertyIcon = UITabBarItem(title: "Properties", image: UIImage(named: "ic_propertyTab_unselected"), selectedImage: UIImage(named: "ic_propertyTab_selected"))
        property.tabBarItem = propertyIcon
        
        let shortlisted = ViewControllerHelper.getViewController(ofType: .HomeVC, StoryboardName: .Main) as! HomeVC
        let shortlistedIcon = UITabBarItem(title: "Shortlisted", image: UIImage(named: "ic_shortlisted_unselected"), selectedImage: UIImage(named: "ic_shortlisted_selected"))
        shortlisted.tabBarItem = shortlistedIcon
        
        let enquiry = ViewControllerHelper.getViewController(ofType: .EnquiryVC, StoryboardName: .Main) as! EnquiryVC
        let enquiryIcon = UITabBarItem(title: "Enquiry", image: UIImage(named: "ic_enquiry_unselected"), selectedImage: UIImage(named: "ic_enquiry_selected"))
        enquiry.tabBarItem = enquiryIcon
        
        let controllers = [property,developer,home,shortlisted,enquiry]
        
        self.viewControllers = controllers
        self.selectedIndex = self.Index
        
    }
}
