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
    
    lazy var data = NSMutableData()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        startConnection()
        
        
       
        
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
    
    //: MARK JSON from URL
    

    func startConnection() {
        let urlPath: String = "http://www.mocky.io/v2/560920cc9665b96e1e69bb46"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        
        do {
        let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        print(jsonResult)

            
        } catch{
            print("error")
        }
        
    }
   
    
    
    
    
    
}
