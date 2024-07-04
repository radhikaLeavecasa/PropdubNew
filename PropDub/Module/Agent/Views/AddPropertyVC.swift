//
//  AddPropertyVC.swift
//  PropDub
//
//  Created by acme on 03/07/24.
//

import UIKit
import DropDown

class AddPropertyVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var cnstCollVwHeightType: NSLayoutConstraint!
    @IBOutlet weak var collVwType: UICollectionView!
    @IBOutlet weak var cnstCollVwHeightSubCat: NSLayoutConstraint!
    @IBOutlet weak var collVwSubCategory: UICollectionView!
    @IBOutlet weak var cnstCollVwHeightCategory: NSLayoutConstraint!
    @IBOutlet weak var collVwCategory: UICollectionView!
    @IBOutlet weak var txtFldArea: UITextField!
    @IBOutlet weak var txtFldUnit: UITextField!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldTowerName: UITextField!
    @IBOutlet weak var txtFldDeveloper: UITextField!
    @IBOutlet weak var txtFldAgent: UITextField!
    @IBOutlet weak var txtFldType: UITextField!
    @IBOutlet weak var txtFldSubCategory: UITextField!
    @IBOutlet weak var txtFldCategory: UITextField!
    @IBOutlet var btnOptions: [UIButton]!
    //MARK: - Variables
    var viewModel = AddPropertyVM()
    let dropDown = DropDown()
    var arrCat = [String]()
    var arrSubCat = [String]()
    var arrType = [String]()
    var arrDevelopers = [String]()
    
    var arrSelectedCat = [String]()
    var arrSelectedSubCat = [String]()
    var arrSelectedType = [String]()
    var arrSelectedDevelopers = [String]()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        Proxy.shared.loadAnimation()
        group.enter()
        viewModel.categoryApi { val, msg in
            if val {
                for i in self.viewModel.arrCategoryModel ?? [] {
                    self.arrCat.append(i.name)
                }
                for i in Proxy.shared.arrDeveloperList ?? [] {
                    self.arrDevelopers.append(i.name ?? "")
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        }
        
        group.enter()
        viewModel.subCategoryApi({ val, msg in
            if val {
                for i in self.viewModel.arrSubCategoryModel ?? [] {
                    self.arrSubCat.append(i.name)
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        })
        
        group.enter()
        viewModel.typeApi({ val, msg in
            if val {
                for i in self.viewModel.arrType ?? [] {
                    self.arrType.append(i.name)
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        })
       
        group.notify(queue: .main) {
            Proxy.shared.stopAnimation()
        }
    }
    //MARK: - @IBActions
    @IBAction func actionProfile(_ sender: Any) {
    }
    
    @IBAction func actionNotifications(_ sender: Any) {
    }
    
    @IBAction func actionNext(_ sender: Any) {
    }
    @IBAction func actionListingAddProject(_ sender: Any) {
    }
    
}
extension AddPropertyVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      
        if textField == txtFldCategory {
            self.showShortDropDown(textFeild: textField, data: arrCat, dropDown: dropDown) { val, index in
                self.arrSelectedCat.append(val)
            }
            return false
        } else if textField == txtFldSubCategory {
            self.showShortDropDown(textFeild: textField, data: arrSubCat, dropDown: dropDown) { val, index in
                self.arrSelectedSubCat.append(val)
            }
            return false
        } else if textField == txtFldType {
            self.showShortDropDown(textFeild: textField, data: arrType, dropDown: dropDown) { val, index in
                self.arrSelectedType.append(val)
            }
            return false
        } else if textField == txtFldDeveloper {
            self.showShortDropDown(textFeild: textField, data: arrDevelopers, dropDown: dropDown) { val, index in
                self.txtFldDeveloper.text = val
            }
            return false
        } else {
            return true
        }
    }
}

extension AddPropertyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwCategory ? arrSelectedCat.count : collectionView == collVwSubCategory ? arrSelectedSubCat.count : arrSelectedType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
        if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedSubCat[indexPath.row]
        } else if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedSubCat[indexPath.row]
        } else if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedType[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = collectionView == collVwCategory ? arrSelectedSubCat[indexPath.item] : collectionView == collVwSubCategory ? arrSelectedSubCat[indexPath.row] : arrSelectedType[indexPath.row]
        label.sizeToFit()
        if collectionView == collVwCategory {
            return CGSize(width: label.frame.width+15, height: self.collVwCategory.frame.size.height)
        } else if collectionView == collVwSubCategory {
            return CGSize(width: label.frame.width+15, height: self.collVwSubCategory.frame.size.height)
        } else {
            return CGSize(width: label.frame.width+15, height: self.collVwType.frame.size.height)
        }
    }
}
