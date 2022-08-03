//
//  StandingTableViewCell.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import UIKit

class StandingTableViewCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var matchPlayed: UILabel!
    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var draw: UILabel!
    @IBOutlet weak var lose: UILabel!
    @IBOutlet weak var goalDiff: UILabel!
    @IBOutlet weak var pts: UILabel!
    
    var teamId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
