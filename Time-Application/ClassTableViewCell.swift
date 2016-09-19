//
//  ClassTableViewCell.swift
//  Time-Application
//
//  Created by Даниил on 19.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timeBegin: UILabel!
    @IBOutlet weak var timeEnd: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var separator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
