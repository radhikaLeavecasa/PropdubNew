//
//  OtpVC.swift
//  PropDub
//
//  Created by acme on 05/06/24.
//

import UIKit
import OTPFieldView

class OtpVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwStack: UIStackView!
    @IBOutlet weak var vwOtp: OTPFieldView!
    //MARK: - Variables
    var otp = String()
    var isOtpComplete = false
    var viewModel = OtpVM()
    var email = String()
    var type = Int()
    var isSuperAgent = false
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        vwStack.isHidden = isSuperAgent
        setupOtpView()
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionNext(_ sender: Any) {
        if self.isOtpComplete == true {
            let param = [WSRequestParams.WS_REQS_PARAM_EMAIL: self.email,
                         WSRequestParams.WS_REQS_PARAM_OTP: self.otp] as! [String:AnyObject]
            viewModel.otpVerifyApi(param) { val, msg in
                if val {
                    if self.isSuperAgent {
                        let vc = ViewControllerHelper.getViewController(ofType: .BecomeSuperAgentVC, StoryboardName: .Main) as! BecomeSuperAgentVC
                        self.setView(vc: vc)
                    } else {
                        //                    let vc = ViewControllerHelper.getViewController(ofType: .HomeVC, StoryboardName: .Main) as! HomeVC
                        //                    self.setView(vc: vc)
                    }
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION,titleMsg: "Oops!", vc: self)
                    } else {
                        Proxy.shared.presentAlert(msg,titleMsg: "Oops!", vc: self)
                    }
                }
            }
        }
    }
    //MARK: - Custom method
    func setupOtpView(){
        self.vwOtp.fieldsCount = 4
        self.vwOtp.fieldBorderWidth = 1.5
        self.vwOtp.filledBackgroundColor = .clear
        self.vwOtp.defaultBackgroundColor = .clear
        self.vwOtp.defaultBorderColor = .APP_BLACK_CLR
        self.vwOtp.filledBorderColor = .APP_BLACK_CLR
        self.vwOtp.cursorColor = .APP_BLACK_CLR
        self.vwOtp.displayType = .square
        self.vwOtp.fieldSize = 60
        self.vwOtp.separatorSpace = 10
        self.vwOtp.shouldAllowIntermediateEditing = true
        self.vwOtp.delegate = self
        self.vwOtp.initializeUI()
    }
}

extension OtpVC: OTPFieldViewDelegate {
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        //print("Has entered all OTP? \(hasEntered)")
        self.isOtpComplete = hasEntered

        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        // print("OTPString: \(otpString)")
        self.otp = otpString
    }
}
