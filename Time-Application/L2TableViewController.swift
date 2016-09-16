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
    
    var dataWorkaround: [UDataElement]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if dataWorkaround.isNil {
            let target = UService.getData(path: jsonURI, onLevel: .l2)
            
            representation.loadDataWith(target, useRawData: true) { result in
                switch result {
                case .success():
                    self.tableView.reloadData()
                case .failure(_ ):
                    print("error")
                }
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
        if let data = dataWorkaround {
            return data.count
        } else {
            return representation.data.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l2Cell", for: indexPath)

        let sourceData = dataWorkaround.isNil ? representation.data.map {$0 as! UDataElement} : dataWorkaround
        let faculty = sourceData![indexPath.row]
        
        cell.textLabel?.text = faculty.title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showL2.1" {
            let destination = segue.destination as! L2TableViewController
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            // if workaround is not used then destination should be embed with representation.data
            let sourceData = dataWorkaround.isNil ? representation.data.map {$0 as! UDataElement} : dataWorkaround
            let performedData = sourceData![indexPath.row].rawData!.map { UDataElement(from: $0, withRawData: true)}
            
            destination.dataWorkaround = performedData
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }


}
