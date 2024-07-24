//
//  MyListingTVC.swift
//  PropDub
//
//  Created by acme on 23/07/24.
//

import UIKit

class MyListingTVC: UITableViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var btnDeleteProperty: UIButton!
    @IBOutlet weak var btnEditProperty: UIButton!
    @IBOutlet weak var imgVwProperty: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
