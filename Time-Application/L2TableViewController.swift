//
//  L2TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit
import SwiftyJSON

class L2TableViewController: UITableViewController {

    let representation = URepresentation()
    var jsonURI: String!
    
    var dataFromLastLevel: [UDataElement]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        if dataFromLastLevel == nil { // otherwise dataFromLasrLevel would be used
            let target = UService.getData(path: jsonURI, onLevel: .l2)
            representation.loadDataWith(target, rawData: true) { result in
                self.reloadDataDependingOn(result)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // in case of using dataFromLastLevel table should be filled with it
        if let data = dataFromLastLevel {
            return data.count
        } else {
            return representation.data.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l2Cell", for: indexPath) as! SimpleTableViewCell
        cell.setBackgroundColor()


        // in case of using dataFromLastLevel table should be filled with it
        let sourceData = checkSourceData()
        let dataElement = sourceData[indexPath.row]
        
        cell.title.text = dataElement.title
        cell.title.textColor = UColor.greyContentColor
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        if identifier == "showL2.1" {
            let destination = segue.destination as! L2TableViewController
            
            let sourceData = checkSourceData()
            
            // get from source by indexPath.row Array<JSON> and instance UDataElement from ∀ JSON in this array
            let performedData = sourceData[indexPath.row].rawData!.map { UDataElement(from: $0, withRawData: true)}
            
            destination.dataFromLastLevel = performedData
        } else if identifier == "showL3" {
            let destination = segue.destination as! L3TableViewController
            
            // only dataFromLastLevel can be used when showL3 segue performed in case of data from the server archtecture
            destination.jsonURI = dataFromLastLevel![indexPath.row].JSON_URI!
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainRowHeight
    }

    func checkSourceData() -> [UDataElement] {
        
        // if dataFromLastLevel is not used then return representation.data
        if let dataFromLastLevel = dataFromLastLevel {
            return dataFromLastLevel
        } else {
            return representation.data.map {$0 as! UDataElement}
        }
    }

}
