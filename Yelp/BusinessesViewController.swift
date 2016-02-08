//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var businesses: [Business]!
    var filteredData: [Business]!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchBar.backgroundColor = UIColor.redColor()
//        UIBarButtonItem.appearance()
        
        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.filteredData = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = filteredData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredData != nil {
            return filteredData.count
        } else {
            return 0
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true

            }
        }
        
    }
    
//    func loadMoreData() {
//        Business.searchWithTerm("Thai", offset: loadMoreOffset, sort: nil, categories: selectedCategories, deals: nil, completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses.appendContentsOf(businesses)
//            self.tableView.reloadData()
//            self.isMoreDataLoading = false
//        })
//        self.tableView.reloadData()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        if let searchText = searchBar.text {

            filteredData = searchText.isEmpty ? businesses : businesses?.filter({(business:Business) -> Bool in business.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            });
        }
             tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailsSegue" {
            let cell = sender as? BusinessCell
            let indexPath = self.tableView.indexPathForCell(cell!)!.row
            let vc = segue.destinationViewController as! DetailsViewController
            vc.business = filteredData[indexPath]
        } else {
            let navigationController = segue.destinationViewController as! UINavigationController
            let filtersViewController = navigationController.topViewController as! FiltersViewController
            filtersViewController.delegate = self
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        
        Business.searchWithTerm("Restaurants", sort: nil, categories: categories, deals: nil) {
            
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
            
        }
    }
    
}
