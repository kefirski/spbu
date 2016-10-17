//
//  L5TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit
import QuartzCore

class L5TableViewController: UITableViewController, UIActionSheetDelegate {

    var jsonURI: String!
    let representation = URepresentation()
    
    var isInitial: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI {
            tableView.estimatedRowHeight = 85.0
            tableView.rowHeight = UITableViewAutomaticDimension
            
            setupNavigationBar()
        }
        
        let target = UService.getData(path: jsonURI, onLevel: .l5)
        representation.loadDataWith(target) { result in
            switch result {
            case .success():
                // if everything is ok then it is necessary to save jsonURI because this schedule have become default
                Defaults.saveUserSchedule(URI: self.jsonURI)
                
                self.tableView.reloadData()
                self.scrollToActualDay()
                
            case .failure(let error):
                switch error {
                case .dataError: Defaults.deleteUserSchedule()
                default: break
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Interacting
    
    @IBAction func backToRootButtonPressed(_ sender: AnyObject) {
        Defaults.deleteUserSchedule()
        if self.isInitial {
            performSegue(withIdentifier: "backToRoot", sender: sender)
        } else {
            performSegue(withIdentifier: "unwindToRoot", sender: sender)
        }
    }
    
    @IBAction func prevButtonPressed(_ sender: AnyObject) {
        if let metadata = representation.metadata {
            let uri = metadata.prevWeek!
            let target = UService.getData(path: uri, onLevel: .l5)
            
            updateForOtherWeek(with: target)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        if let metadata = representation.metadata {
            let uri = metadata.nextWeek!
            let target = UService.getData(path: uri, onLevel: .l5)
            
            updateForOtherWeek(with: target)
        }
    }
    
    func updateForOtherWeek(with target: UService) {
        representation.loadDataWith(target) { result in
            switch result {
            case .success():
                self.tableView.reloadData()
                self.scrollToTop()
                
            case .failure(_): print("error")
            }
        }
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
        if let location = uClass.mainDescription {
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
        
        if uClass.lunapark.isEmpty {
            cell.accessoryType = .none
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let uClass = classFor(indexPath)    
        if !uClass.lunapark.isEmpty {
            showActionSheet(uClass.lunapark)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func showActionSheet(_ locations: [ULocation]) {
        let actionSheet = UIAlertController(title: "Показать на карте", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Отмена", style: .cancel)
        actionSheet.addAction(cancelActionButton)
        
        for location in locations {
            let saveActionButton = UIAlertAction(title: location.title, style: .default) { action in
                Open.map(on: location)
            }
            actionSheet.addAction(saveActionButton)
        }
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Scrolling
    
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
    
    // MARK: - Other
    
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

}




