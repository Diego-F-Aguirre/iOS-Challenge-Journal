//
//  EntryListViewController.swift
//  Journal_Challenge
//
//  Created by Diego Aguirre on 4/8/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension EntryListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.entryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        let entry = EntryController.sharedInstance.entryArray[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = String(entry.date)
        
        return cell
    }
}

extension EntryListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = EntryController.sharedInstance.entryArray[indexPath.row]
            EntryController.sharedInstance.removeEntry(entry)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension EntryListViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditEntry" {
            
            guard let destinationVC = segue.destinationViewController as? EntryDetailViewController,
                indexPath = tableView.indexPathForSelectedRow else { return }
            
            let entry = EntryController.sharedInstance.entryArray[indexPath.row]
            destinationVC.entry = entry
        }
    }
}














