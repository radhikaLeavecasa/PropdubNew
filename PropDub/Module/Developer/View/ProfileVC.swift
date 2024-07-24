//
//  ProfileVC.swift
//  PropDub
//
//  Created by acme on 29/05/24.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var constLogoutHeight: NSLayoutConstraint!
    @IBOutlet weak var vwAgentTwo: UIView!
    @IBOutlet weak var vwStackInside: UIView!
    @IBOutlet weak var constStachVwHeight: NSLayoutConstraint!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnLoginSignup: UIButton!
    @IBOutlet weak var imgVwProfilePic: UIImageView!
    //MARK: - Variables
    var isLogin = false
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        constLogoutHeight.constant = isLogin ? 45 : 0
        constStachVwHeight.constant = isLogin ? 276 : 0
        vwStackInside.isHidden = !isLogin
        vwAgentTwo.isHidden = !isLogin
        btnLogout.isHidden = !isLogin
    }
    @IBAction func actionSignupLogin(_ sender: Any) {
        let vc = ViewControllerHelper.getViewController(ofType: .LoginVC, StoryboardName: .Main) as! LoginVC
        self.pushView(vc: vc)
    }
    @IBAction func actionPages(_ sender: UIButton) {
        let vc = ViewControllerHelper.getViewController(ofType: .AboutUsVC, StoryboardName: .Main) as! AboutUsVC
        switch sender.tag {
        case 0:
            vc.url = "https://propdub.com/contact-us"
        case 1:
            vc.url = "https://propdub.com/help"
        case 2:
            vc.url = "https://propdub.com/faq"
        case 3:
            vc.url = "https://propdub.com/about"
        case 4, 5:
            vc.url = "https://propdub.com/privacy-policy"
        default:
            break
        }
    }
    @IBAction func actionLogout(_ sender: Any) {
        isLogin = false
    }
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionSocialLinks(_ sender: UIButton) {
        var urlStr = ""
        switch sender.tag {
        case 1:
            urlStr = "https://www.instagram.com/propdub/"
        case 0:
            urlStr = "https://www.facebook.com/people/PropDub-Real-Estate-LLC/100090628761086/"
        case 2:
            urlStr = "https://x.com/propdub"
        default:
            urlStr = "https://www.linkedin.com/company/propdub-real-estate-llc/"
        }
        guard let url = URL(string: urlStr)  else { return }

        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func actionBecomeSuperAgent(_ sender: Any) {
        let vc = ViewControllerHelper.getViewController(ofType: .BecomeAgentVC, StoryboardName: .Main) as! BecomeAgentVC
        self.pushView(vc: vc)
    }
}
