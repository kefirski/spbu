//
//  L1TableViewController.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit
import Result

class L1TableViewController: UITableViewController {

    let representation = URepresentation()
    
    let target = UService.getData(path: "root.json", onLevel: .l1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI {
            setupNavigationBar()
        }
        
        update()
    }
    
    func update() {
        representation.loadDataWith(target) { result in
            self.reloadDataDependingOn(result)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "l1Cell", for: indexPath) as! SimpleTableViewCell
        cell.setBackgroundColor()

        let faculty = representation.data[indexPath.row] as! UDataElement
            
        cell.title.text = faculty.title
        cell.title.textColor = UColor.greyContentColor

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainRowHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! L2TableViewController
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let faculty = representation.data[indexPath.row] as! UDataElement
        
        destination.jsonURI = faculty.JSON_URI!
    }

    @IBAction func unwindToRoot(segue: UIStoryboardSegue) {
        scrollToTop()
    }
}



