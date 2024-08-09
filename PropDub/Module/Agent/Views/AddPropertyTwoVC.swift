//
//  AddPropertyTwoVC.swift
//  PropDub
//
//  Created by acme on 03/07/24.
//

import UIKit
import IQKeyboardManagerSwift

class AddPropertyTwoVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var cnstHeightGalleryVw: NSLayoutConstraint!
    @IBOutlet weak var collVwImages: UICollectionView!
    @IBOutlet weak var txtVwDescription: IQTextView!
    @IBOutlet weak var txtVwLocation: IQTextView!
    @IBOutlet weak var txtVwAmenities: IQTextView!
    @IBOutlet weak var txtFldBrochure: UITextField!
    @IBOutlet weak var txtFldLogo: UITextField!
    @IBOutlet weak var txtFldHandover: UITextField!
    @IBOutlet weak var txtFldImage: UITextField!
    @IBOutlet weak var txtFldGallery: UITextField!
    @IBOutlet weak var txtFldMapVideo: UITextField!
    @IBOutlet weak var addVideo: UITextField!
    @IBOutlet weak var txtFldUnitPrice: UITextField!
    @IBOutlet weak var txtFldAddMasterPlan: UITextField!
    @IBOutlet weak var txtFldAddFloor: UITextField!
    //MARK: - Variables
    var params = [String: AnyObject]()
    var imgParams = [String: UIImage]()
    var selectedImg = UIImage()
    var selectedLogo = UIImage()
    var arrSelectedGalleryImgs = [UIImage]()
    var viewModel = AddPropertyTwoVM()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionSubmit(_ sender: Any) {
        if isValidateForm() {
            imgParams["image"] = selectedImg
            params["handover"] = txtFldHandover
            for (index, category) in arrSelectedGalleryImgs.enumerated() {
                imgParams["gallery[\(index)]"] = category
            }
            imgParams["logo"] = selectedLogo
            params["brochure"] = txtFldBrochure
            params["floor_plan"] = txtFldAddFloor
            params["master_plan"] = txtFldAddMasterPlan
            params["unit_plan"] = txtFldUnitPrice
            params["viedo"] = addVideo
            params["map"] = txtFldMapVideo
            params["amenities"] = txtVwAmenities
            params["near_by_location"] = txtVwLocation
            params["description"] = txtVwDescription
            
            viewModel.addAgentPropertyApi(param: params, dictImage: imgParams) { val, msg in
                if val {
                    
                } else {
                    if msg == CommonError.INTERNET {
                        Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                    } else {
                        Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                    }
                }
            }
        }
        
    }
    @IBAction func actionUploadImage(_ sender: Any) {
        txtFldImage.becomeFirstResponder()
    }
    @IBAction func actionGallery(_ sender: Any) {
        txtFldGallery.becomeFirstResponder()
    }
    @IBAction func actionLogo(_ sender: Any) {
        txtFldLogo.becomeFirstResponder()
    }
    //MARK: - Custom methods
    func isValidateForm() -> Bool {
        if txtFldImage.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.SELECT_IMG)
            return false
        } else if txtFldHandover.text?.isEmptyCheck() == true{
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_HANDOVER)
            return false
        } else if arrSelectedGalleryImgs.count == 0 {
            Proxy.shared.showSnackBar(message: CommonMessage.SELECT_GALLERY)
            return false
        } else if txtFldLogo.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.SELECT_LOGO)
            return false
        } else if txtFldBrochure.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_BROCHURE_URL)
            return false
        } else if txtFldAddFloor.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_FLOOR_PLAN)
            return false
        } else if txtFldAddMasterPlan.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_MASTER_PLAN)
            return false
        } else if txtFldUnitPrice.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_UNIT_PLAN)
            return false
        } else if addVideo.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_VIDEO_URL)
            return false
        } else if addVideo.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_MAP_URL)
            return false
        } else if txtVwAmenities.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_AMENITIES)
            return false
        } else if txtVwLocation.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_NEAR_BY_LOC)
            return false
        } else if txtVwDescription.text?.isEmptyCheck() == true {
            Proxy.shared.showSnackBar(message: CommonMessage.ENTER_DESCRP)
            return false
        }
        return true
    }
}

extension AddPropertyTwoVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let _ = ImagePickerManager().pickImage(self) { img, name in
            switch textField {
            case self.txtFldImage:
                self.selectedImg = img
                self.txtFldImage.text = name
            case self.txtFldGallery:
                if !self.arrSelectedGalleryImgs.contains(img) {
                    self.arrSelectedGalleryImgs.append(img)
                    self.cnstHeightGalleryVw.constant = 120
                    self.collVwImages.reloadData()
                }
            case self.txtFldLogo:
                self.selectedLogo = img
                self.txtFldLogo.text = name
            default:
                break
            }
        }
        return false
    }
}

extension AddPropertyTwoVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrSelectedGalleryImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVwImages.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
        cell.imgVwGallery.image = arrSelectedGalleryImgs[indexPath.row]
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(actionDeleteGalleryImg), for: .touchUpInside)
        return cell
    }
    @objc func actionDeleteGalleryImg(_ sender: UIButton) {
        arrSelectedGalleryImgs.remove(at: sender.tag)
        cnstHeightGalleryVw.constant = arrSelectedGalleryImgs.count == 0 ? 60 : 120
        collVwImages.reloadData()
    }
}
