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
    
    func reloadData(dependingOn result: UVoidResult, success: () -> Void = {}) -> Void {
        switch result {
        case .success():
            tableView.reloadData()
            success()
        case .failure(let error):
            print("error")
            switch error {
            case .dataError: print("data error")
            case .networkFailure: print("network error")
            case .responseCodeError: print("response error")
            }
        }
        
        refreshControl?.endRefreshing()
    }
    
    func setupUI(_ f: () -> Void = {}) {
        tableView.setBackgroundColor()
        tableView.separatorColor = UColor.lightGreyContentColor
        
        f()
    }
    
    var mainRowHeight: CGFloat { return 65 }
    
    func setupNavigationBar() {
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        
        navigationBar.backgroundColor = UColor.backgroundColor
        navigationBar.tintColor = UColor.greyContentColor
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
