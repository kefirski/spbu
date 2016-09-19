//
//  UITableView.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit
import Result

extension UITableViewController {
    func reloadDataDependingOn(_ result: UVoidResult) -> Void {
        switch result {
        case .success():
            self.tableView.reloadData()
        case .failure(_ ):
            print("error")
        }
    }
    
    func setupUI(f: () -> Void) {
        tableView.setBackgroundColor()
        tableView.separatorColor = UColor.lightGreyContentColor
        
        f()
    }
    
    var mainRowHeight: CGFloat {
        return 65
    }
}
