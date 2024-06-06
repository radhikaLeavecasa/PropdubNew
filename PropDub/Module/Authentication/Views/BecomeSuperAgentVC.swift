//
//  BecomeSuperAgentVC.swift
//  PropDub
//
//  Created by acme on 06/06/24.
//

import UIKit
import IQKeyboardManagerSwift

class BecomeSuperAgentVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtVwDescp: IQTextView!
    @IBOutlet weak var txtFldFrontImg: UITextField!
    @IBOutlet weak var txtFldPassport: UITextField!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldAadharBack: UITextField!
    //MARK: - Variables
    var viewModel = BecomeSuperAgentVM()
    var imgPassprt: UIImage?
    var imgAadhar1: UIImage?
    var imgAadhar2: UIImage?
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - @IBActions
    @IBAction func actionUploadImg(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.txtFldPassport.becomeFirstResponder()
        case 1:
            txtFldFrontImg.becomeFirstResponder()
        default:
            txtFldAadharBack.becomeFirstResponder()
        }
    }
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionSubmit(_ sender: Any) {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_NAME: txtFldName.text!,
                                           WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!,
                                           WSRequestParams.WS_REQS_PARAM_MOBILE: txtFldPhone.text,
                                           WSRequestParams.WS_REQS_PARAM_DESCRIPTION: txtVwDescp.text!] as! [String: AnyObject]
        
        let imgParam: [String: UIImage] = [WSRequestParams.WS_REQS_PARAM_AADHAR_ONE: imgAadhar1,
                                           WSRequestParams.WS_REQS_PARAM_AADHAR_TWO: imgAadhar2,
                                           WSRequestParams.WS_REQS_PARAM_PASSPORT: imgPassprt] as! [String: UIImage]
        
        
        viewModel.becomeSuperAgentApi(param: params, dictImage: imgParam) { val, msg in
            if val {
                
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION,titleMsg: "Oops", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg,titleMsg: "Oops!", vc: self)
                }
            }
        }
    }
    //MARK: - Custom method
    func isValidatePassanger() -> Bool {
        if txtFldEmail.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_EMAIL)
            return false
        } else if txtFldEmail.text?.isValidEmail() == false {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VALID_EMAIL)
            return false
        }else if txtFldName.text?.isEmptyCheck() == true{
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_NAME_TWO)
            return false
        }else if txtFldPhone.text?.isEmptyCheck() == true{
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_MOBILE)
            return false
        } else if txtFldLocation.text?.isEmptyCheck() == true{
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_LOCATION)
            return false
        } else if txtFldPassport.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.UPLOAD_PASSPORT_PHOTO)
            return false
        } else if txtFldFrontImg.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.UPLOAD_AADHAR_CARD1)
            return false
        } else if txtFldAadharBack.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.UPLOAD_AADHAR_CARD2)
            return false
        } 
        return true
    }
}

extension BecomeSuperAgentVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let _ = ImagePickerManager().pickImage(self) { img in
            switch textField {
            case self.txtFldPassport:
                self.imgPassprt = img
            case self.txtFldFrontImg:
                self.imgAadhar1 = img
            default:
                self.imgAadhar2 = img
            }
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
}
