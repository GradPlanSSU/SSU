//
//  MySchedulesDetailedViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/8/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class MySchedulesDetailedViewController: UITableViewController {


    var terms = [Term]()
    var tableSections = [Section]()
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSections()
        
     // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    
    }
    
    func addSections() {
        if terms.count > 0 {
            for i in 0...terms.count - 1 {
                if terms[i].classes!.count > 0 {
                    for j in 0...terms[i].classes!.count - 1 {
                        var array = Array(terms[i].classes!) as! [Class]
                        var item = Item(name: array[j].class_Name!, detail: "")
                        itemArray.append(item)
                    }
                }
                var section = Section(name: terms[i].termName!, items: itemArray, collapsed: true)
                tableSections.append(section)
                itemArray.removeAll()
            }
        }
    }
    
}

    

//
// MARK: - View Controller DataSource and Delegate
//
extension MySchedulesDetailedViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].items.count
   
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        let classes = Array(self.terms[indexPath.section].classes!) as! [Class]
        
        cell.nameLabel.text = classes[indexPath.row].class_Name
        cell.detailLabel.text = classes[indexPath.row].class_Units! + " units"
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = terms[section].termName
        header.setCollapsed(tableSections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}

//
// MARK: - Section Header Delegate
//
extension MySchedulesDetailedViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
       
        
        let collapsed = !tableSections[section].collapsed
        // Toggle collapse
        tableSections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

