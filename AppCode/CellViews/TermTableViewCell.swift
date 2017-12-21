//
//  TermTableViewCell.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/25/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class TermTableViewCell: UITableViewCell {

    
    @IBOutlet weak var term: UILabel!
    @IBOutlet weak var numberOfUnits: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
