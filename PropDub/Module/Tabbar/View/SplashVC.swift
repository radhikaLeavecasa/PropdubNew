//
//  SplashVC.swift
//  PropDub
//
//  Created by acme on 23/05/24.
//

import UIKit

class SplashVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgVwSplash: UIImageView!
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        Proxy.shared.setupGIF("splashscreen", imgVW: imgVwSplash)
        DispatchQueue.main.asyncAfter(deadline: .now()+8, execute: {
            let vc = ViewControllerHelper.getViewController(ofType: .TabbarVC, StoryboardName: .Main) as! TabbarVC
            self.setView(vc: vc)
        })
    }
}
