//
//  MasterViewController.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Results]()
    let operationsManager = OperationsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Fetching most viewed")
        refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh), for: UIControlEvents.valueChanged)
        
        
        SwiftSpinner.useContainerView(self.view)
        self.loadLatest()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        operationsManager.getMostViewed(section: "all-sections", timePeriod: TimePeriod.Day) { (array, error) in
            
            self.objects = array as! [Results]
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }

    }

    
    func loadLatest() {
        SwiftSpinner.show("Fetching most viewed")
        operationsManager.getMostViewed(section: "all-sections", timePeriod: TimePeriod.Day) { (array, error) in
            
            self.objects = array as! [Results]
            self.tableView.reloadData()
            SwiftSpinner.hide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if tableView.indexPathForSelectedRow != nil {
                let object = NSDate() //objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.accessoryType = .disclosureIndicator
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object.title
        
        cell.imageView?.image = UIImage(named: "Placeholder")
        cell.imageView?.layer.cornerRadius = 20
        
        cell.imageView?.clipsToBounds = true
        
        if let media = object.media?.first {
            
            if  let metadata = media.media_metadata?.first {
            
                operationsManager.downloadImage(urlString: (metadata.url)!) { (image, error) in
                    
                    DispatchQueue.main.async() { () -> Void in
                        cell.imageView?.image = image
                    }
                    
                }

            }

        }
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

