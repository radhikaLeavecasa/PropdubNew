//
//  LoginVC.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwAgree: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet var btnUserAgentLogin: [UIButton]!
    @IBOutlet weak var btnNextSkip: UIButton!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    //MARK: - Variable
    var viewModel = LoginVM()
    var selectedTab = 0
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionUserAgentLogin(_ sender: UIButton) {
        selectedTab = sender.tag
        vwPassword.isHidden = sender.tag == 0
        vwAgree.isHidden = sender.tag == 1
        
        for btn in btnUserAgentLogin {
            if sender.tag == btn.tag {
                btnUserAgentLogin[btn.tag].backgroundColor = .APP_BLACK_CLR
                btnUserAgentLogin[btn.tag].setTitleColor(.white, for: .normal)
            } else {
                btnUserAgentLogin[btn.tag].backgroundColor = .white
                btnUserAgentLogin[btn.tag].setTitleColor(.APP_BLACK_CLR, for: .normal)
            }
        }
    }
    @IBAction func actionAgreeTerms(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func actionNextSkip(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if selectedTab == 0 {
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
                            vc.type = self.selectedTab
                            self.pushView(vc: vc)
                            Proxy.shared.showSnackBar(message: msg)
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                            } else {
                                Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                            }
                        }
                    })
                }
            } else {
                if txtFldEmail.text?.isEmptyCheck() == true {
                    Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
                } else if txtFldEmail.text?.isValidEmail() == false {
                    Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
                } else if txtFldPassword.text?.isEmptyCheck() == true {
                    Proxy.shared.showSnackBar(message: CommonMessage.ENTER_PASSWORD)
                } else {
                    let param: [String:AnyObject] = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!,
                                                     WSRequestParams.WS_REQS_PARAM_PASSWORD: txtFldPassword.text!] as! [String:AnyObject]
                    viewModel.userLoginApi(param: param, { val, msg in
                        if val {
                            let vc = ViewControllerHelper.getViewController(ofType: .TabbarVC, StoryboardName: .Main) as! TabbarVC
                            self.setView(vc: vc)
                            Proxy.shared.showSnackBar(message: msg)
                        } else {
                            if msg == CommonError.INTERNET {
                                Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION,titleMsg: "Oops!", vc: self)
                            } else {
                                Proxy.shared.presentAlert(msg,titleMsg: "Oops!", vc: self)
                            }
                        }
                    })
                }
            }
        default:
            popView()
        }
    }
}
