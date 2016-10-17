//
//  ClassTableViewCell.swift
//  Time-Application
//
//  Created by Даниил on 19.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {
    
    
    @IBOutlet var timeBegin: UILabel!
    @IBOutlet var timeEnd: UILabel!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var location: UILabel!
    
    @IBOutlet var separator: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let color = separator.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        if selected {
            separator.backgroundColor = color
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let color = separator.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            separator.backgroundColor = color
        }
    }

}
