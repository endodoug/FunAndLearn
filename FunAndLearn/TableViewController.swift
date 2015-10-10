//
//  TableViewController.swift
//  FunAndLearn
//
//  Created by doug harper on 9/16/15.
//  Copyright © 2015 Doug Harper. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSURLConnectionDelegate, UISearchDisplayDelegate, UISearchBarDelegate {
    
    var dataTitle = [String]()
    var dataDescription = [String]()
    
    lazy var data = NSMutableData()
   
    // search variables
    
    var dataTitleList = [String]()
    var dataTitleFilteredList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startConnection()
        
    }
    
    // MARK: - TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.dataTitleFilteredList.count
        } else {
            return self.dataTitle.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var searchName : String!
        if tableView == self.searchDisplayController!.searchResultsTableView {
            searchName = dataTitleFilteredList[indexPath.row]
        } else {
            searchName = dataTitle[indexPath.row]
        }
        
        cell.textLabel?.text = searchName
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
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        do {
        let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        
            for dict in jsonResult {
                dataTitle.append(dict.objectForKey("title") as! String)
                dataDescription.append(dict.objectForKey("description") as! String)
                self.tableView.reloadData()
            }
            
        } catch{
            print("error")
        }
    }
    
    // MARK: Search Results
    
    func filterTableViewForEnterText(searchText: String)
    {
        self.dataTitleFilteredList = self.dataTitle.filter({( strCountry : String) -> Bool in
            var stringForSearch = strCountry.rangeOfString(searchText)
            return (stringForSearch != nil)
        })
    }
    
    // MARK: UISearch Delegate Methods
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterTableViewForEnterText(searchString!)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController,
        shouldReloadTableForSearchScope searchOption: Int) -> Bool {
            self.filterTableViewForEnterText(self.searchDisplayController!.searchBar.text!)
            return true
    }
  
}
