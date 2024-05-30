//
//  UIImageExtension.swift
//  PropDub
//
//  Created by acme on 22/05/24.
//

import UIKit

extension UIImage{
    
    class func placeholderImage() -> UIImage{
        return UIImage.init(named: "ic_defaultPic") ?? UIImage()
    }
}
