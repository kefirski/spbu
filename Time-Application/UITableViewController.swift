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
    func reloadDataDependingOn(_ result: UVoidResult, success: () -> Void = {}) -> Void {
        switch result {
        case .success():
            self.tableView.reloadData()
            success()
        case .failure(let error):
            print("error")
            switch error {
                case .dataError: print("data error")
                case .networkFailure: print("network error")
                case .responseCodeError: print("response error")
            }
        }
        
        self.refreshControl?.endRefreshing()
    }
    
    func setupUI(f: () -> Void = {}) {
        tableView.setBackgroundColor()
        tableView.separatorColor = UColor.lightGreyContentColor
        
        f()
    }
    
    var mainRowHeight: CGFloat {
        return 65
    }
    
    func setupNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            let img = UIImage()
            navigationBar.shadowImage = img
            navigationBar.setBackgroundImage(img, for: .default)
            
            navigationBar.backgroundColor = UColor.backgroundColor
            navigationBar.tintColor = UColor.greyContentColor
            
            let backItem = UIBarButtonItem()
            backItem.title = "Назад"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
