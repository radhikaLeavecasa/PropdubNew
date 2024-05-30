//
//  FilterVC.swift
//  PropDub
//
//  Created by acme on 27/05/24.
//

import UIKit
import WARangeSlider

class FilterVC: UIViewController{
    //MARK: - @IBOutlets
    @IBOutlet weak var constAmenitiesHeight: NSLayoutConstraint!
    @IBOutlet weak var collVwAmenities: UICollectionView!
    @IBOutlet weak var lblMaxBudget: UILabel!
    @IBOutlet weak var lblMinimumBudget: UILabel!
    @IBOutlet weak var collVwConfiguration: UICollectionView!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var txtFldLocality: UITextField!
    //MARK: - Variables
    var arrConfiguration = ["1BR","2BR","3BR","4BR","Duplex","Studios"]
    var arrAmenities = ["Swimming Pool","Kids Pool","Jacuzzi","Fitness Center/Gym","Kids Play Area","Cycling Track","Tennis Court","Golf Simulator","Climbing Wall","Badminton Court","Basketball Court","Spa and Wellness Center","Sauna and Steam Room"," Yoga/Meditation Room","Multi-purpose Sports Court","Community Lounge","Outdoor Party Area","BBQ Area","Business Center","Beauty Salon","Wi-Fi Enabled Common Areas","Rooftop Terrace","Library","Jogging Track","Garden/Park Area"]
    var selectedAmenity = [String]()
    var selectedConf = [String]()
    var isClear = true
    typealias filterCompletion = (_ minValue: Int, _ maxValue: Int, _ selectedAmenity: [String], _ selectedConf: [String], _ isClear: Bool) -> Void
    var filterComplDelegate: filterCompletion? = nil
    var minValue = Int()
    var maxValue = Int()
    
    
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        collVwAmenities.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        rangeSlider.lowerValue = Double(minValue)
        rangeSlider.upperValue = Double(maxValue)
        
        lblMinimumBudget.text = "AED \(Int(rangeSlider.lowerValue))"
        lblMaxBudget.text = "AED \(Int(rangeSlider.upperValue))"
    }
    //MARK: - Custom methods
    @objc func sliderValueChanged(_ rangeSlider: RangeSlider) {
        lblMinimumBudget.text = "AED \(Int(rangeSlider.lowerValue))"
        lblMaxBudget.text = "AED \(Int(rangeSlider.upperValue))"
        self.isClear = rangeSlider.lowerValue > 0 || rangeSlider.upperValue < 90000000 ? false : true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let collectionView = object as? UICollectionView {
            self.constAmenitiesHeight.constant = collectionView.contentSize.height
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    deinit {
        collVwAmenities.removeObserver(self, forKeyPath: "contentSize")
    }
    //MARK: - @IBActions
    @IBAction func actionSearch(_ sender: Any) {
    }
    @IBAction func actionClearAll(_ sender: Any) {
        self.isClear = true
        selectedAmenity = []
        selectedConf = []
        lblMinimumBudget.text = "AED 0"
        lblMaxBudget.text = "AED 90000000"
        rangeSlider.lowerValue = 0
        rangeSlider.upperValue = 90000000
        collVwAmenities.reloadData()
        collVwConfiguration.reloadData()
    }
    @IBAction func actionFindProperty(_ sender: Any) {
        self.dismiss(animated: true) {
            guard let filter = self.filterComplDelegate else { return }
            filter(Int(self.rangeSlider.lowerValue), Int(self.rangeSlider.upperValue), self.selectedAmenity, self.selectedConf, self.isClear)
        }
    }
    @IBAction func actionCross(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwAmenities ? arrAmenities.count : arrConfiguration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
        if collectionView == collVwAmenities {
            cell.lblTitle.text = arrAmenities[indexPath.row]
            if selectedAmenity.contains(arrAmenities[indexPath.row]) {
                cell.btnCheck.setImage(UIImage(named: "ic_tick"), for: .normal)
            } else {
                cell.btnCheck.setImage(UIImage(named: "ic_untick"), for: .normal)
            }
        } else {
            cell.lblTitle.text = arrConfiguration[indexPath.row]
            if selectedConf.contains(arrConfiguration[indexPath.row]) {
                cell.vwBackground.backgroundColor =  .APP_BLACK_CLR
                cell.lblTitle.textColor = .white
            } else {
                cell.vwBackground.backgroundColor =  .clear
                cell.lblTitle.textColor = .APP_BLACK_CLR
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwAmenities {
            return CGSize(width: self.collVwAmenities.frame.size.width/2, height: 60)
        } else {
            let label = UILabel(frame: CGRect.zero)
            label.text = arrConfiguration[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width+15, height: self.collVwConfiguration.frame.size.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collVwAmenities {
            if !selectedAmenity.contains(arrAmenities[indexPath.row]) {
                selectedAmenity.append(arrAmenities[indexPath.row])
                self.isClear = false
            } else {
                let index = self.selectedAmenity.firstIndex(of: arrAmenities[indexPath.row]) ?? 0
                self.selectedAmenity.remove(at: index)
                self.isClear = selectedAmenity.count == 0 ? true : false
            }
            collVwAmenities.reloadData()
        } else {
            if !selectedConf.contains(arrConfiguration[indexPath.row]) {
                selectedConf.append(arrConfiguration[indexPath.row])
                self.isClear = false
            } else {
                let index = self.selectedConf.firstIndex(of: arrConfiguration[indexPath.row]) ?? 0
                self.selectedConf.remove(at: index)
                self.isClear = selectedConf.count == 0 ? true : false
            }
            collVwConfiguration.reloadData()
        }
    }
}
