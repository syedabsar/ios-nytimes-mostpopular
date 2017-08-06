//
//  MasterViewController.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit
import AZDropdownMenu
import SwiftSpinner

class MasterViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var objects : [MostViewedResults]? = nil
    var filteredObjects : [MostViewedResults]? = nil
    
    var searchMode = false
    
    let operationsManager = OperationsManager()
    let searchBar = UISearchBar()
    var menu : AZDropdownMenu?
    
    var sections : [SectionsResults]? = nil
    var defaultSection = "all-sections"

    var defaultTimePeriod = TimePeriod.Week { didSet {
        refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        
        } }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh), for: UIControlEvents.valueChanged)
        
        refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        
        self.loadLatest()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ViewController Methods
    func loadLatest() {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(self.getFetchingMessage())
        operationsManager.getMostViewed(section: self.defaultSection, timePeriod: self.defaultTimePeriod) { (array, error) in
            
            self.objects = array as? [MostViewedResults]
            self.tableView.reloadData()
            self.loadSections()
        }
    }
    
    func loadSections() {
    
        if self.sections != nil {
            SwiftSpinner.hide()
        } else {
        
            operationsManager.getSectionsList(completionHandler: { (array, error) in
                
                self.sections = array as? [SectionsResults]
                SwiftSpinner.hide()
            
                let sectionNamesArray = self.sections?.map({ (section: SectionsResults) -> String in
                        section.name!
                })

                self.menu = AZDropdownMenu(titles: sectionNamesArray!)
                self.menu?.cellTapHandler = { indexPath in

                    self.defaultSection = (sectionNamesArray?[indexPath.row])!
                    self.loadLatest()
                }

            })
            
        }
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        operationsManager.getMostViewed(section: "all-sections", timePeriod: self.defaultTimePeriod) { (array, error) in
            
            self.objects = array as? [MostViewedResults]
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func showTimePeriodFilters() {
        
        let alert = UIAlertController(title: "See most popular items for",
                                      message: nil,
                                      preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for timePeriod in EnumUtils.iterateEnum(TimePeriod.self) {
            
            var displayName = timePeriod.getDisplayName()
            
            if self.defaultTimePeriod == timePeriod {
                displayName = "✓ " + displayName
            }
            
            let timePeriodAction = UIAlertAction(title: displayName,
                                                 style: .default, handler: { action in
                                                    
                                                    self.defaultTimePeriod = timePeriod
                                                    self.loadLatest()
                                                    
            })
            
            alert.addAction(timePeriodAction)
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func getFetchingMessage() -> String {
        
        return "Fetching this \(self.defaultTimePeriod.getDisplayName())'s most viewed"
    }
    
    
    // MARK: - Button Actions
    
    
    @IBAction func didTapLeftButtonItem(_ sender: Any) {
        
        if (self.menu?.isDescendant(of: (self.navigationController?.view)!) == true) {
            self.menu?.hideMenu()
        } else {
            self.menu?.showMenuFromView((self.navigationController?.view)!)
        }

    }
    
    @IBAction func didTapMoreButtonItem(_ sender: Any) {
        
        self.showTimePeriodFilters()
    }
    
    @IBAction func didTapSearchButtonItem(_ sender: Any) {
        
        if self.searchMode == true {
            searchBarCancelButtonClicked(self.searchBar)
            return
        }
        self.filteredObjects = self.objects
        self.searchMode = true
        self.tableView.tableHeaderView = searchBar
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Search Bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchMode = false
        searchBar.resignFirstResponder()
        self.tableView.tableHeaderView = nil
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredObjects = BusinessLogicHelper.filterBySearchKeywords(searchKeyword: searchText, resultsArray: self.objects!)
        
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            
            if tableView.indexPathForSelectedRow != nil {
                let object = objects?[(tableView.indexPathForSelectedRow?.row)!]
                controller.detailItem = object
            } else if (objects?.count)! > 0 {
                //The first news shows by default no item selected and orientation is landscape.
                controller.detailItem = objects?.first
            }
            
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchMode && self.filteredObjects != nil {
            return (self.filteredObjects?.count)!
        }

        if self.searchMode == false && self.objects != nil {
            return (self.objects?.count)!
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as!  MasterSummaryTableViewCell
        
        let object = self.searchMode ? filteredObjects?[indexPath.row] : objects?[indexPath.row]
        cell.titleLabel!.text = object?.title
        cell.byLineLabel.text = object?.byline
        cell.publishDateLabel.text = "🗓 "+(object?.published_date!)!
        cell.thumbnailView?.image = UIImage(named: "Placeholder")
        cell.thumbnailView?.layer.cornerRadius = 20
        
        
        if let media = object?.media?.first {
            
            if  let metadata = media.media_metadata?.first {
                
                operationsManager.downloadImage(urlString: (metadata.url)!) { (image, error) in
                    
                    DispatchQueue.main.async() { () -> Void in
                        cell.thumbnailView?.image = image
                    }
                    
                }
            }
        }
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
}

