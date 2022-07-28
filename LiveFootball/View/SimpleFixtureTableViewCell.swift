//
//  SimpleFixtureTableViewCell.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import UIKit

class SimpleFixtureTableViewCell: UITableViewCell {

    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayName: UILabel!
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
