//
//  UIViewControllerExtension.swift
//  PropDub
//
//  Created by acme on 23/05/24.
//

import UIKit
import DropDown

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
    func showShortDropDown(textFeild:UITextField,data:[String],dropDown: DropDown, completion: @escaping(String,Int)->()) {
        DispatchQueue.main.async {
            textFeild.resignFirstResponder()
            
            dropDown.anchorView = textFeild.plainView
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            
            dropDown.dataSource = data
            dropDown.separatorColor = .gray
            dropDown.selectionAction = { (index: Int, item: String) in
                completion(item, index)
            }
            dropDown.show()
        }
    }
}
