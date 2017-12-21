//
//  ScheduleTableViewCell.swift
//  SSUSchedulePlanner
//
//  Created by Ivan Lim on 11/8/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleName: UILabel!
    @IBOutlet weak var scheduleDate: UILabel!
    @IBOutlet weak var scheduleUnits: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
