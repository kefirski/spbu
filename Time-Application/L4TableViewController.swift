//
//  L4TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

class L4TableViewController: UITableViewController {
    
    var jsonURI: String!
    let representation = URepresentation()

    override func viewDidLoad() {
        super.viewDidLoad()

        let target = UService.getData(path: jsonURI, onLevel: .l4)
        representation.loadDataWith(target) { result in
            self.tableView.reloadDataDependingOn(result)
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
        return representation.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "l4Cell", for: indexPath)

        let dataElement = representation.data[indexPath.row] as! UDataElement
        
        cell.textLabel?.text = dataElement.title

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
