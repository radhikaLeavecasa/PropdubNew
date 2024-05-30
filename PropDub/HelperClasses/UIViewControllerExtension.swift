//
//  UIViewControllerExtension.swift
//  PropDub
//
//  Created by acme on 23/05/24.
//

import UIKit

extension UIViewController{
    func popView(){
        self.navigationController?.popViewController(animated: true)
    }
    func pushView(vc:UIViewController, title: String = "", animated: Bool = true){
        DispatchQueue.main.async {
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    func setView(vc: UIViewController, animation: Bool = true){
        DispatchQueue.main.async {
            self.navigationController?.setViewControllers([vc], animated: animation)
        }
    }
}
