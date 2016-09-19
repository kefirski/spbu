//
//  L3TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class L3TableViewController: UITableViewController {

    var jsonURI: String!
    let representation = URepresentation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI{}
        
        let target = UService.getData(path: jsonURI, onLevel: .l3)
        representation.loadDataWith(target) { result in
            self.reloadDataDependingOn(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return representation.data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = representation.data[section] as! GroupedUDataElement
        return group.form
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = representation.data[section] as! GroupedUDataElement
        return group.groupedElements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l3Cell", for: indexPath) as! SimpleTableViewCell
        cell.setBackgroundColor()
        
        let dataElement = getDataElement(for: indexPath)
        
        cell.title.text = dataElement.title
        cell.title.textColor = UColor.greyContentColor


        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainRowHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! L4TableViewController
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let dataElement = getDataElement(for: indexPath)
        
        destination.jsonURI = dataElement.JSON_URI!
        
    }
    
    func getDataElement(for indexPath: IndexPath) -> UDataElementWithForm {
        let group = representation.data[indexPath.section] as! GroupedUDataElement
        let dataElement = group.groupedElements[indexPath.row]
        
        return dataElement
    }

}





