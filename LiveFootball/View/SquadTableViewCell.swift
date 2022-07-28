//
//  SquadTableViewCell.swift
//  LiveFootball
//
//  Created by Jeonghoon Oh on 7/28/22.
//

import UIKit

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var posColor: UIImageView!
    @IBOutlet weak var pos: UILabel!
    var playerID: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
