//
//  TodayTableViewController.swift
//  Time-Application
//
//  Created by Даниил on 10.10.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController {
    
//    var jsonURI: String?
//    let representation = URepresentation()
//    var day: UDataElementStudyDay?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        jsonURI = Defaults.userSchedule()
//        
//        if let uri = jsonURI {
//            let target = UService.getData(path: uri, onLevel: .widget)
//            
//            representation.loadDataWith(target) { result in
//                switch result {
//                case .success():
//                    
//                    self.tableView.reloadData()
//                    print("success")
//                    
//                case .failure(let error):
//                    switch error {
//                    case .dataError: Defaults.deleteUserSchedule()
//                    default: break
//                    }
//                }
//            }
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return representation.data.isEmpty ? 0 : 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let data = representation.data.map {$0 as! UDataElementStudyDay}
//        self.day = data.actualDay()
//        
//        if let day = self.day {
//            return day.classes.count
//        } else {
//            return 0
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "l5Cell", for: indexPath) as! ClassTableViewCell
//        
//
//        return cell
//    }
}
 
