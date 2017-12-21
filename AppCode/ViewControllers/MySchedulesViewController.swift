//
//  MySchedulesViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/7/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData


class MySchedulesViewController: UITableViewController {

    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
    
    var schedules = [Schedule]()
    var noDataLabel = UILabel()
    var scheduleNameText = String()
    var clickedCell = IndexPath()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(schedules.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        
        if let theCell = cell as? ScheduleTableViewCell {
            
            theCell.scheduleDate.text = schedules[indexPath.row].scheduleDate
            theCell.scheduleName.text = schedules[indexPath.row].scheduleName
            
            theCell.scheduleDate.textColor = UIColor.white
            theCell.scheduleName.textColor = UIColor.white

        }

        cell.backgroundColor = UniversityDarkBlue
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        do
        {
            let schedules = try context.fetch(fetchRequest)
            self.schedules = schedules
            self.tableView.reloadData()
            print("Fetched Schedules From CoreData")
        }
        catch
        {
            print("Error in Retrieving Schedules")
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if let navController = self.navigationController {
            let viewControllers: [UIViewController] = navController.viewControllers as [UIViewController]
            if viewControllers[viewControllers.count - 2].isKind(of: CreateScheduleViewController.self) {
                navController.viewControllers.remove(at: viewControllers.count - 2)
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        do
        {
            let schedules = try context.fetch(fetchRequest)
            self.schedules = schedules
            self.tableView.reloadData()
            print("Fetched Schedules From CoreData")
        }
        catch
        {
            print("Error in Retrieving Schedules")
        }
        
        if schedules.count == 0 {
            
            noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No Schedules Created"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        else {
            noDataLabel.isHidden = true
            tableView.separatorStyle = .singleLine
        }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // depending on the cell clicked, return the proper schedule
        guard segue.identifier == "SchedulesToDetailed" else {return}
        
        clickedCell = self.tableView.indexPathForSelectedRow!
        let selectedRow = clickedCell.row
        
        print(selectedRow)
        
        let destinationVC : MySchedulesDetailedViewController = segue.destination as! MySchedulesDetailedViewController
        destinationVC.title = self.schedules[selectedRow].scheduleName
        destinationVC.terms = Array(self.schedules[selectedRow].terms!) as! [Term]
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.clickedCell = indexPath
        print(clickedCell)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            context.delete(schedules[indexPath.row])
            
            do
            {
                try context.save()
                print("Deleted Schedule")
            }
            catch
            {
                // error
            }
            
            self.schedules.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
