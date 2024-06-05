//
//  LoginVC.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet var btnUserAgentLogin: [UIButton]!
    @IBOutlet weak var btnNextSkip: UIButton!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    //MARK: - Variable
    var viewModel = LoginVM()
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionUserAgentLogin(_ sender: UIButton) {
        for btn in btnUserAgentLogin {
            btnUserAgentLogin[btn.tag].backgroundColor = sender.tag == btn.tag ? .APP_BLACK_CLR : .white
            btnUserAgentLogin[0].setTitleColor(sender.tag == btn.tag ? .white : .APP_BLACK_CLR, for: .normal)
            vwPassword.isHidden = sender.tag == 0
            if sender.tag == 0 {
                if txtFldEmail.text?.isEmptyCheck() == true {
                    Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
                } else if txtFldEmail.text?.isValidEmail() == false {
                    Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
                } else {
                    let param: [String:AnyObject] = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!] as! [String:AnyObject]
                    viewModel.userLoginApi(param: param, { val, msg in
                        if val {
                            let vc = ViewControllerHelper.getViewController(ofType: .OtpVC, StoryboardName: .Main) as! OtpVC
                            vc.email = self.txtFldEmail.text!
                            self.pushView(vc: vc)
                            Proxy.shared.showSnackBar(message: msg)
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                            } else {
                                Proxy.shared.showSnackBar(message: msg)
                            }
                        }
                    })
                }
            }
        }
    }
    @IBAction func actionAgreeTerms(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func actionNextSkip(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            break
        default:
            popView()
        }
    }
}
