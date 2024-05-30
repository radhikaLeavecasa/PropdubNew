//
//  ContactUsVC.swift
//  PropDub
//
//  Created by acme on 29/05/24.
//

import UIKit

class ContactUsVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var lblReraNumber: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    //MARK: - Variables
    var image = String()
    var name = String()
    var designation = String()
    var reraNo = String()
    var viewModel = ContactUsVM()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imgVwProfile.sd_setImage(with: URL(string: "\(imageBaseUrl)\(image)") , placeholderImage: .placeholderImage())
        // lblReraNumber.text = reraNo
        lblName.text = name
        lblDesignation.text = designation
    }
    @IBAction func actionBookViewing(_ sender: UIButton) {
        let param: [String:AnyObject] = [WSRequestParams.WS_REQS_PARAM_NAME : txtFldName.text!,
                                         WSRequestParams.WS_REQS_PARAM_EMAIL: txtFldEmail.text!,
                                         WSRequestParams.WS_REQS_PARAM_PHONE: txtFldPhone.text!,
                                         WSRequestParams.WS_RESP_PARAM_TYPE: sender.tag == 0 ? "Book a Viewing" : "Schedule a call",
                                         WSResponseParams.WS_RESP_PARAM_MESSAGE : "" as NSString,
                                         WSRequestParams.WS_REQS_PARAM_JOB_TYPE: "" as NSString,
                                         WSRequestParams.WS_REQS_PARAM_SOURCE: "" as NSString] as! [String:AnyObject]
        
        
        viewModel.contactUsApi(param: param) { val in
            if val {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func actionCall(_ sender: Any) {
    }
    @IBAction func actionEmail(_ sender: Any) {
    }
    @IBAction func actionCross(_ sender: Any) {
        dismiss(animated: true)
    }
    //MARK:- Custom methods
    func isValidatePassanger() -> Bool {
        if txtFldName.text?.isEmptyCheck() == true {
            // pushNoInterConnection(view: self,titleMsg: "Alert", msg: "\(CommonMessage.PLEASE_CHOOSE) pax \(at+1) \(CommonMessage.PLEASE_FILL_TITLE)")
            return false
        } else if txtFldPhone.text?.isEmptyCheck() == true{
            //pushNoInterConnection(view: self,titleMsg: "Alert", msg: "\(CommonMessage.PLEASE_FILL) pax \(at+1) \(CommonMessage.PLEASE_FILL_DATE_OF_BIRTH)")
            return false
        } else if txtFldEmail.text?.isEmptyCheck() == true {
            //  pushNoInterConnection(view: self,titleMsg: "Alert", msg: "\(CommonMessage.PLEASE_FILL) pax \(at+1) \(CommonMessage.PLEASE_FILL_EMAIL)")
            return false
        }else if txtFldEmail.text?.isValidEmail() == false {
            //  pushNoInterConnection(view: self,titleMsg: "Alert", msg: "\(CommonMessage.PLEASE_FILL) pax \(at+1) \(CommonMessage.PLEASE_FILL_VALID_EMAIL)")
            return false
        }
        
        return true
    }
}
