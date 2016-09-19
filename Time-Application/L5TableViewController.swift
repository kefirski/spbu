//
//  L5TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit
import QuartzCore

class L5TableViewController: UITableViewController {

    var jsonURI: String!
    let representation = URepresentation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI {
            tableView.estimatedRowHeight = 85.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        let target = UService.getData(path: jsonURI, onLevel: .l5)
        representation.loadDataWith(target) { result in
            self.reloadDataDependingOn(result) {
                self.scrollToActualDay()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "l5Cell", for: indexPath) as! ClassTableViewCell
        cell.setBackgroundColor()
        
        let uClass = classFor(indexPath)
        
        cell.timeBegin.text = uClass.timeBegin
        cell.timeEnd.text = uClass.timeEnd
        
        cell.title.text = uClass.mainTitle
        
        
        if let location = uClass.location {
            cell.location.text = location
        } else {
            cell.location.isHidden = true
        }
        
        for label in [cell.timeBegin, cell.timeEnd, cell.title, cell.location] {
            label!.textColor = UColor.greyContentColor
        }
        
        if uClass.isEnded {
            cell.separator.backgroundColor = UColor.lightGreyContentColor
        } else {
            cell.separator.backgroundColor = UColor.redContentColor
        }
        
        return cell
    }
    
     override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderTableViewCell
        
        let day = representation.data[section] as! UDataElementStudyDay
        
        headerCell.title.text = day.title.uppercaseFirst
        headerCell.title.textColor = UColor.greyContentColor

        return headerCell.contentView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    

    
    func classesFor(day d: Int) -> [UClass] {
        let day = representation.data[d] as! UDataElementStudyDay
        return day.classes
    }
    
    func classFor(day d: Int, index n: Int) -> UClass {
        let day = representation.data[d] as! UDataElementStudyDay
        return day.classes[n]
    }
    
    func classFor(_ indexPath: IndexPath) -> UClass {
        return classFor(day: indexPath.section, index: indexPath.row)
    }
    
    func scrollToActualDay() {
        if let indexPath = self.actualDayIndexPath {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    var actualDayIndexPath: IndexPath? {
        guard !representation.data.isEmpty else {
            return nil
        }
        
        for (index, day) in representation.data.enumerated() {
            if (day as! UDataElementStudyDay).notEnded {
                return IndexPath(row: 0, section: index)
            }
        }
        return IndexPath(row:0, section: representation.data.count - 1)
    }

}




