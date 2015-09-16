//
//  TableViewController.swift
//  FunAndLearn
//
//  Created by doug harper on 9/16/15.
//  Copyright © 2015 Doug Harper. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var dataTitle = [String]()
    var dataDescription = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = NSBundle.mainBundle().pathForResource("data", ofType: "plist") {
            if let arrayOfDictionaries = NSArray(contentsOfFile: path) {
                for dict in arrayOfDictionaries {
                    dataTitle.append(dict.objectForKey("title") as! String)
                    dataDescription.append(dict.objectForKey("description") as! String)
                }
            }
        }
        
//        Check to see the data is available in console
//        print(dataTitle.description)
//        print(dataDescription.description)
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataTitle.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel!.text = dataTitle[indexPath.row]
        cell.detailTextLabel!.text = dataDescription[indexPath.row]

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
