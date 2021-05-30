//
//  DetailCell.swift
//  Football App
//
//  Created by BarisOdabasi on 24.05.2021.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet var imageViewCell: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var subscribeNameLabel: UILabel!
    @IBOutlet var toDetailLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
