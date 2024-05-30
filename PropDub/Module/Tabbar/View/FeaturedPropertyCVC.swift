//
//  FeaturedPropertyCVC.swift
//  PropDub
//
//  Created by acme on 21/05/24.
//

import UIKit

class FeaturedPropertyCVC: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgVwSymbol: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVwFeatureProperty: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
}
