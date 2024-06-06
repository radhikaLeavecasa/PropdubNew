//
//  BecomeAgentVC.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit

class BecomeAgentVC: UIViewController {

    @IBOutlet weak var txtFldEmail: UITextField!
    
    var viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func actionNext(_ sender: Any) {
        
        if txtFldEmail.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
        } else if txtFldEmail.text?.isValidEmail() == false {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
        } else {
            let param: [String:AnyObject] = [WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!] as! [String:AnyObject]
            viewModel.superAgentLoginApi(param: param, { val, msg in
                if val {
                    let vc = ViewControllerHelper.getViewController(ofType: .OtpVC, StoryboardName: .Main) as! OtpVC
                    vc.email = self.txtFldEmail.text!
                    self.pushView(vc: vc)
                    Proxy.shared.showSnackBar(message: msg)
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION,titleMsg: "Oops", vc: self)
                    } else {
                        Proxy.shared.presentAlert(msg,titleMsg: "Oops", vc: self)
                    }
                }
            })
        }
    }
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
}
