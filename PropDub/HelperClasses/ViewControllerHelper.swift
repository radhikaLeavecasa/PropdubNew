//
//  ViewControllerHelper.swift
//  Josh
//
//  Created by Esfera-Macmini on 21/03/22.
//

import UIKit

enum StoryboardName : String{
    
    case Main
  
}

enum ViewControllerType : String{
    
    case HomeVC
    case DeveloperVC
    case PropertyListVC
    case TabbarVC
    case SplashVC
    case PropertyDetailVC
    case FilterVC
    case ContactUsVC
    
}

class ViewControllerHelper: NSObject {
    class func getViewController(ofType viewControllerType: ViewControllerType, StoryboardName:StoryboardName) -> UIViewController {
        var viewController: UIViewController?
        let storyboard = UIStoryboard(name: StoryboardName.rawValue, bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: viewControllerType.rawValue)
        if let vc = viewController {
            return vc
        } else {
            return UIViewController()
        }
    }
}