//
//  UITableView.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import Result

extension UITableView {
    func reloadDataDependingOn(_ result: UVoidResult) -> Void {
        switch result {
        case .success():
            self.reloadData()
        case .failure(_ ):
            print("error")
        }
    }
}
