//
//  BusLinesViewController.swift
//  MobiliteDynamique
//
//  Created by Pierre Bathellier on 18/10/2017.
//  Copyright © 2017 Pierre Bathellier. All rights reserved.
//

import UIKit



class BusLinesViewController: UITableViewController {
    
    // MARK: - Properties
    public var busLines = SampleData.generatePlayersData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.color(fromHexString: "#FFFFFF")]
    }
    
    
}

// MARK: - UITableViewDataSource
extension BusLinesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busLines.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusLineCell", for: indexPath)
        
        let busline = busLines[indexPath.row]
        cell.textLabel?.text = String(busline.number)
        //
        cell.detailTextLabel?.text = busline.departure+busline.arrival
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Use this to determine the selected index path. You can also store the selected index path in a variable using -didSelectRowAtIndexPath
        let cell = sender as! UITableViewCell
        //The bus line that the map has to show
        let busLine : String? =  cell.textLabel?.text
        
        // Create reference and pass it
        let busMapViewController = segue.destination as! BusMapViewController
        busMapViewController.lineNumber = busLine
    }
    
    
}






