//
//  PlayerCell.swift
//  Football App
//
//  Created by BarisOdabasi on 27.05.2021.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
