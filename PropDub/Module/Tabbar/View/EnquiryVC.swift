//
//  EnquiryVC.swift
//  PropDub
//
//  Created by acme on 07/06/24.
//

import UIKit
import IQKeyboardManagerSwift

class EnquiryVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtFldDescription: IQTextView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldMobile: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    
    //MARK: - Variables
    var viewModel = ContactUsVM()
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - @IBActions
    @IBAction func actionRequestToCallBack(_ sender: UIButton) {
        if isValidatePassanger() {
            let param: [String:AnyObject] = [WSRequestParams.WS_REQS_PARAM_NAME : txtFldName.text!,
                                             WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!,
                                             WSRequestParams.WS_REQS_PARAM_PHONE: txtFldMobile.text!,
                                             WSRequestParams.WS_RESP_PARAM_TYPE: Strings.REQUEST_CALL_BACK,
                                             WSResponseParams.WS_RESP_PARAM_MESSAGE : txtFldDescription.text ?? "",
                                             WSRequestParams.WS_REQS_PARAM_JOB_TYPE: "" as NSString,
                                             WSRequestParams.WS_REQS_PARAM_SOURCE: "" as NSString] as! [String:AnyObject]
            
            
            viewModel.contactUsApi(param: param) { val,msg in
                if val {
                    Proxy.shared.presentAlert(CommonMessage.CONTACT_MSG,titleMsg: CommonMessage.CONFIRMATION_MSG, vc: self)
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION,titleMsg: CommonMessage.OOPS, vc: self)
                    } else {
                        Proxy.shared.presentAlert(msg,titleMsg: CommonMessage.OOPS, vc: self)
                    }
                }
            }
        }
    }
    
    @IBAction func actionCallEmailNow(_ sender: UIButton) {
    }
    //MARK: - Custom method
    func isValidatePassanger() -> Bool {
        if txtFldName.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_NAME)
            return false
        } else if txtFldMobile.text?.isEmptyCheck() == true{
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_PHONE)
            return false
        } else if txtFldEmail.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
            return false
        } else if txtFldEmail.text?.isValidEmail() == false {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
            return false
        }
        return true
    }
}
