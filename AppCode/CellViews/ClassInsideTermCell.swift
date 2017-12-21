//
//  ClassInsideTermCell.swift
//  SSUSchedulePlanner
//
//  Created by Ivan Lim on 12/2/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class ClassInsideTermCell: UITableViewCell {

    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classUnits: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
