//
//  PropertyDetailVC.swift
//  PropDub
//
//  Created by acme on 24/05/24.
//

import UIKit
import AdvancedPageControl
import SDWebImage

class PropertyDetailVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var constStackBottom: NSLayoutConstraint!
    @IBOutlet weak var vwLocation: UIView!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var constTblVwLocationHeight: NSLayoutConstraint!
    @IBOutlet weak var tblVwLocation: UITableView!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var collVwImages: UICollectionView!
    @IBOutlet weak var constTblVwHeightDetail: NSLayoutConstraint!
    @IBOutlet weak var collVwBottom: UICollectionView!
    @IBOutlet weak var imgVwQRCode: UIImageView!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldFullName: UITextField!
    @IBOutlet weak var lblLanguages: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var imgVwAgent: UIImageView!
    @IBOutlet weak var tblVwAmenities: UITableView!
    @IBOutlet weak var tblVwPropertyDetail: UITableView!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblDesp: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var constTblVwHeightAmenities: NSLayoutConstraint!
    //MARK: - Variables
    var arrDetails = ["Starting Price", "Unit", "Propert Id"]
    var arrBottom = ["Call Us", "Email Us", "Book a Viewing", "Schedule A Call"]
    var arrNearByLocation = [String]()
    var propertyDetail: DataItemModel?
    var arrAmenities = [String]()
    var selectedIndex = -1
    var arrImages = [String]()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        handleData()
        tblVwAmenities.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tblVwLocation.addObserver(self, forKeyPath: "contentSize", options: .new, context: UnsafeMutableRawPointer(bitPattern: 1))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "contentSize" {
            
            if context == nil {
                if object is UITableView {
                    if let newValue = change?[.newKey]{
                        let newSize = newValue as! CGSize
                        self.constTblVwHeightAmenities.constant = newSize.height
                    }
                }
            } else {
                if object is UITableView {
                    if let newValue = change?[.newKey]{
                        let newSize = newValue as! CGSize
                        constTblVwLocationHeight.constant = newSize.height
                    }
                }
            }
        }
    }
    
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionLike(_ sender: Any) {
    }
    @IBAction func actionBookViewing(_ sender: Any) {
    }
    @IBAction func actionScheduleMeeting(_ sender: Any) {
    }
    @IBAction func actionCallNow(_ sender: Any) {
    }
    @IBAction func actionEmailNow(_ sender: Any) {
    }
    @IBAction func actionDownload(_ sender: Any) {
    }
    //MARK: - Custom methods
    func handleData() {
        lblPropertyName.text = propertyDetail?.location
        lblDesp.text = propertyDetail?.description?.htmlToString
        lblAgentName.text = propertyDetail?.agent?.name
        lblDesignation.text = propertyDetail?.agent?.designation
        lblLanguages.text = propertyDetail?.agent?.language
        imgVwQRCode.sd_setImage(with: URL(string: "\(imageBaseUrl)\(propertyDetail?.agent?.qrCode ?? "")"), placeholderImage: .placeholderImage())
        imgVwAgent.sd_setImage(with: URL(string: "\(imageBaseUrl)\(propertyDetail?.agent?.images ?? "")"), placeholderImage: .placeholderImage())
        
        if propertyDetail?.amenities != "" {
            let components = propertyDetail?.amenities?.components(separatedBy: "\n")
            for component in components ?? [] {
                // Remove the numbering (e.g., "1. ", "2. ", etc.) from each component
                if let index = component.firstIndex(of: ".") {
                    let substring = component.suffix(from: component.index(after: index)).trimmingCharacters(in: .whitespacesAndNewlines)
                    arrAmenities.append(String(substring))
                }
            }
        }
        
        constTblVwHeightDetail.constant = CGFloat(45*arrDetails.count)
      //  constTblVwHeightAmenities.constant = CGFloat(45*arrAmenities.count)
        arrImages = propertyDetail?.gallery?.components(separatedBy: ", ") ?? []
        
        self.pageController.drawer = ScaleDrawer(numberOfPages: arrImages.count, height: 10, width: 10, space: 6, raduis: 10, currentItem: 0, indicatorColor: .white, dotsColor: .clear, isBordered: true, borderColor: .white, borderWidth: 1.0, indicatorBorderColor: .white, indicatorBorderWidth: 1.0)
        self.pageController.numberOfPages = arrImages.count 
        
        if propertyDetail?.nearByLocation != "" {
            let components = propertyDetail?.nearByLocation?.components(separatedBy: "\n")
            for component in components ?? [] {
                // Remove the numbering (e.g., "1. ", "2. ", etc.) from each component
                if let index = component.firstIndex(of: ".") {
                    let substring = component.suffix(from: component.index(after: index)).trimmingCharacters(in: .whitespacesAndNewlines)
                    arrNearByLocation.append(String(substring))
                }
            }
        }
        
        if arrNearByLocation.count == 0 {
            vwLocation.isHidden = true
            constStackBottom.constant = 0
        }
        
        collVwImages.registerNib(nibName: "PropertyImagesXIB")
        
       // constTblVwLocationHeight.constant = CGFloat(40*arrNearByLocation.count)
        collVwImages.reloadData()
        tblVwAmenities.reloadData()
        tblVwLocation.reloadData()
        tblVwAmenities.layoutIfNeeded()
    }
}

extension PropertyDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tblVwAmenities ? arrAmenities.count : tableView == tblVwLocation ? arrNearByLocation.count : arrDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyTVC", for: indexPath) as! PropertyTVC
        if tableView == tblVwAmenities {
            cell.lblOne.text = arrAmenities[indexPath.row].replacingOccurrences(of: "\r", with: "")
        } else if tableView == tblVwLocation {
            cell.lblOne.text = arrNearByLocation[indexPath.row].components(separatedBy: "-")[0]
            cell.lblTwo.text = "- \(arrNearByLocation[indexPath.row].components(separatedBy: "-")[1])"
        } else {
            cell.lblOne.text = arrDetails[indexPath.row]
            cell.lblTwo.text = indexPath.row == 0 ? "- \(propertyDetail?.startingPrice ?? "")" : indexPath.row == 1 ? "- \(propertyDetail?.unit ?? "")" : "- \(propertyDetail?.id ?? 0)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension PropertyDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwImages ? arrImages.count : arrBottom.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwImages {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyImagesXIB", for: indexPath) as! PropertyImagesXIB
            cell.imgProperty.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrImages[indexPath.row])"), placeholderImage: .placeholderImage())
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
            cell.lblTitle.text = arrBottom[indexPath.row]
            cell.vwBackground.backgroundColor = selectedIndex == indexPath.row ? .clear : UIColor(named: "APP_BLACK_CLR")
            cell.lblTitle.textColor = selectedIndex == indexPath.row ? .APP_BLACK_CLR : .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwImages {
            return CGSize(width: self.collVwImages.frame.size.width, height: (self.collVwImages.frame.size.height))
        } else {
            let label = UILabel(frame: CGRect.zero)
            label.text = arrBottom[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width+15, height: self.collVwBottom.frame.size.height)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == collVwImages {
            
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            
            let index = Int(round(offSet/width))
            self.pageController.setPage(index)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collVwBottom {
            selectedIndex = indexPath.row
            collVwBottom.reloadData()
        }
    }
}
