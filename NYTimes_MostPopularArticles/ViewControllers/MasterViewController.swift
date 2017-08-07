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
    var mostViewedItemsList : [MostViewedResults]? = Array<MostViewedResults>()
    var filteredSearchResultList : [MostViewedResults]? = nil
    var currentOffset = 0
    var totalResults = 0
    
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
        
        // Configure Split Controller
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // Configure Search Bar
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        // Configure Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(MasterViewController.refresh), for: UIControlEvents.valueChanged)
        
        refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        
        // Configure Table View
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        // Load Web Service Items
        self.loadLatestItems()
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
    func loadLatestItems() {
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show(self.getFetchingMessage())
        
        operationsManager.getMostViewed(
            section: self.defaultSection,
            timePeriod: self.defaultTimePeriod,
            offset: self.currentOffset) { (responseModel, error) in
            
                self.totalResults = (responseModel?.num_results)!
                
            self.mostViewedItemsList?.append(contentsOf: (responseModel?.results)!)
                
            self.tableView.reloadData()
                
            self.tableView.scrollToRow(at: IndexPath(row: self.currentOffset, section: 0), at: .bottom, animated: false)
                
            self.loadSectionsList()
        }
    }
    
    func loadSectionsList() {
    
        if self.sections != nil {
            SwiftSpinner.hide()
        } else {
        
            operationsManager.getSectionsList(completionHandler: { (array, error) in
                
                self.sections = array
                SwiftSpinner.hide()
            
                let sectionNamesArray = self.sections?.map({ (section: SectionsResults) -> String in
                        section.name!
                })

                self.menu = AZDropdownMenu(titles: sectionNamesArray!)
                self.menu?.cellTapHandler = { indexPath in

                    self.defaultSection = (sectionNamesArray?[indexPath.row])!
                    self.loadLatestItems()
                }

            })
            
        }
    }
    
    func refresh(sender:AnyObject) {
        
        self.currentOffset = 0
        
        // Code to refresh table view
        operationsManager.getMostViewed(section: "all-sections", timePeriod: self.defaultTimePeriod, offset: 0) { (responseModel, error) in
            
            self.mostViewedItemsList = responseModel?.results
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func showTimePeriodFilters() {
        
        let alert = UIAlertController(title: "See most popular items for",
                                      message: nil,
                                      preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for timePeriod in EnumUtils.iterateEnum(TimePeriod.self) {
            
            
            let timePeriodAction = UIAlertAction(title: self.getDisplayNameForTimePeriod(timePeriod: timePeriod),
                                                 style: .default, handler: { action in
                                                    
                                                    self.defaultTimePeriod = timePeriod
                                                    self.loadLatestItems()
                                                    
            })
            
            alert.addAction(timePeriodAction)
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func getDisplayNameForTimePeriod(timePeriod: TimePeriod) -> String {
    
        var displayName = timePeriod.getDisplayName()
        
        if self.defaultTimePeriod == timePeriod {
            displayName = "✓ " + displayName
        }

        return displayName
    }
    
    private func getFetchingMessage() -> String {
        
        return "Fetching this \(self.defaultTimePeriod.getDisplayName())'s most viewed in \(self.defaultSection)"
    }
    
    
    // MARK: - Button Actions
    
    
    @IBAction func didTapLeftButtonItem(_ sender: Any) {
        
        if (self.menu?.isDescendant(of: self.view) == true) {
            self.menu?.hideMenu()
        } else {
            self.menu?.showMenuFromView(self.view)
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
        self.filteredSearchResultList = self.mostViewedItemsList
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
        
        self.filteredSearchResultList = BusinessLogicHelper.filterBySearchKeywords(searchKeyword: searchText, resultsArray: self.mostViewedItemsList!)
        
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
                let object = self.mostViewedItemsList?[(tableView.indexPathForSelectedRow?.row)!]
                controller.detailItem = object
            } else if (self.mostViewedItemsList?.count)! > 0 {
                //The first news shows by default no item selected and orientation is landscape.
                controller.detailItem = self.mostViewedItemsList?.first
            }
            
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchMode && self.filteredSearchResultList != nil {
            return (self.filteredSearchResultList?.count)!
        }

        if self.searchMode == false && self.mostViewedItemsList != nil {
            return (self.mostViewedItemsList?.count)!
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MasterViewController.SummaryCellIdentifier, for: indexPath) as!  MasterSummaryTableViewCell
        
        let object = self.searchMode ? self.filteredSearchResultList?[indexPath.row] : self.mostViewedItemsList?[indexPath.row]
        cell.titleLabel!.text = object?.title
        cell.byLineLabel.text = object?.byline
        cell.publishDateLabel.text = "🗓 "+(object?.published_date!)!
        cell.thumbnailView?.image = UIImage(named: Constants.MasterViewController.PlaceholderImageName)
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let offsetNumber = indexPath.row + 1;
        if (offsetNumber % 20 == 0 && offsetNumber > self.currentOffset && (self.mostViewedItemsList?.count)! <= self.totalResults) {
                self.currentOffset = offsetNumber
                self.loadLatestItems()
        }
    }

    
}

