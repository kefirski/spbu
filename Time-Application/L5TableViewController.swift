//
//  L5TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class L5TableViewController: UITableViewController {

    var jsonURI: String!
    let representation = URepresentation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let target = UService.getData(path: jsonURI, onLevel: .l5)
        representation.loadDataWith(target) { result in
            self.tableView.reloadDataDependingOn(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return representation.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesFor(day: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l5Cell", for: indexPath)
        
        let uClass = classFor(day: indexPath.section, index: indexPath.row)
        
        cell.textLabel?.text = uClass.title

        return cell
    }
    
    func classesFor(day d: Int) -> [UClass] {
        let day = representation.data[d] as! UDataElementStudyDay
        return day.classes
    }
    
    func classFor(day d: Int, index n: Int) -> UClass {
        let day = representation.data[d] as! UDataElementStudyDay
        return day.classes[n]
    }

}




