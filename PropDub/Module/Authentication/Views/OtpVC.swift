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
    @IBOutlet weak var vwOtp: OTPFieldView!
    //MARK: - Variables
    var otp = String()
    var isOtpComplete = false
    var viewModel = OtpVM()
    var email = String()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
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
//                    let vc = ViewControllerHelper.getViewController(ofType: .HomeVC, StoryboardName: .Main) as! HomeVC
//                    self.setView(vc: vc)
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.showSnackBar(message: CommonMessage.NO_INTERNET_CONNECTION)
                    } else {
                        Proxy.shared.showSnackBar(message: msg)
                    }
                }
            }
        }
    }
    //MARK: - Custom method
    func setupOtpView(){
        self.vwOtp.fieldsCount = 4
        self.vwOtp.fieldBorderWidth = 2
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
