//
//  CreateScheduleViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/7/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData

class CreateScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {


    // University Light Blue
    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
     let lightGray = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    
    var termChoice = String()
    var yearString = String()
    var termName = String()
    
    var terms = [Term]()
    
    var years = [String]()
    var numberOfUnits = Float()
    
    var clickedCell = IndexPath()
    
    @IBOutlet weak var scheduleName: UILabel!
    @IBOutlet weak var editScheduleNameButton: UIButton!
    @IBOutlet weak var addTermButton: UIButton!
    @IBOutlet weak var saveScheduleButton: UIBarButtonItem!
    @IBOutlet weak var termTable: UITableView!
    
    @IBAction func editScheduleName(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Change Schedule Name", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as UITextField? {
                
                self.scheduleName.text = field.text
                
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Schedule Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addTerm(_ sender: Any) {
        
        print("Clicked Add Term Button")
        
        let alertController = UIAlertController(title: "Choose Term", message: "", preferredStyle: .alert)
        let fall = UIAlertAction(title: "Fall", style: .default, handler: {(alert: UIAlertAction!) in self.inputTermName(0)})
        let spring = UIAlertAction(title: "Spring", style: .default, handler: {(alert: UIAlertAction!) in self.inputTermName(1)})
        
        alertController.addAction(fall)
        alertController.addAction(spring)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addTermButton.backgroundColor = UniversityDarkBlue
        addTermButton.setTitleColor(UIColor.white, for: .normal)
        addTermButton.layer.cornerRadius = 5
        
        termTable.backgroundColor = lightGray
        
        termTable.layer.cornerRadius = 15

        editScheduleNameButton.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        
        termTable.delegate = self
        termTable.dataSource = self
        termTable.alpha = 0.90
        
        let date = Date()
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        
        if years.count == 0 {
            years.append("None")
            for _ in 0...5 {
                years.append(String(year))
                year += 1
            }
        }
        self.termTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.termTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        // issue if more than 2 segues
        
        guard segue.identifier == "saveScheduleSegue" else {
            print("Going Into A Specific Term")
            let AddTermDestinationVC : AddTermViewController = segue.destination as! AddTermViewController
            clickedCell = self.termTable.indexPathForSelectedRow!
            AddTermDestinationVC.title = self.terms[clickedCell.row].termName
            AddTermDestinationVC.termIndex = clickedCell.row
            AddTermDestinationVC.terms = self.terms
            return
        }
        let destinationVC : MySchedulesViewController = segue.destination as! MySchedulesViewController
        saveSchedule(destinationVC)
        
    }
    
    
    func saveSchedule(_ vc: MySchedulesViewController) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let schedule = Schedule(context: context)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        schedule.scheduleDate = myStringafd
        schedule.scheduleName = scheduleName.text
       
        if(terms.count != 0) {
            for index in 0...terms.count - 1 {
                print("Adding a term to schedule")
                schedule.addToTerms(terms[index])
            }
        }
        
        do
        {
            try context.save()
            print("Saved Schedule To Core Data")
        }
        catch
        {
            // error
        }
        
        vc.schedules.append(schedule)
        vc.tableView.reloadData()
        self.termTable.reloadData()
        print(terms.count)
        
        terms.removeAll()
        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "termTableViewCell", for: indexPath as IndexPath)
        
        if terms.count > 0 {
            if let theCell = cell as? TermTableViewCell {
                
                theCell.term.text = terms[indexPath.row].termName
                theCell.numberOfUnits.text = terms[indexPath.row].termUnits
                
                theCell.term.textColor = UIColor.white
                theCell.numberOfUnits.textColor = UIColor.white
                
            }
        }
       
        cell.backgroundColor = UniversityDarkBlue
        return(cell)
 
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.clickedCell = indexPath
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Attempting to Delete")
        if editingStyle == .delete {
            terms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.yearString = String(self.years[row])
        print(yearString)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let year = years[row]
        return year
    }

    func inputTermName(_ action: Int)
    {
        
        if action == 0 {
            termChoice = "Fall"
            print("Clicked Fall")
        }
        else {
            termChoice = "Spring"
            print("Clicked Spring")
        }
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Select Year", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(alert: UIAlertAction!) in self.updateTermName()}))
        
        self.present(editRadiusAlert, animated: true)
    }
    
    func updateTermName()
    {
        if yearString == "None" {
            termName = termChoice
        } else {
            termName = termChoice + " " + yearString
        }
        
        // add term to CoreData and reload TableView
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let term = Term(context: context)
        
        term.termName = self.termName
        term.termUnits = "0.0"
        
        terms.append(term)
        print("Count of terms: \(terms.count)")
        
        termTable.beginUpdates()
        termTable.insertRows(at: [
            NSIndexPath(row: terms.count-1, section: 0) as IndexPath
            ], with: .left)
        termTable.endUpdates()
        
     //   terms = terms.sorted { $0.termName! < $1.termName! }
        //  termTable.reloadData()
      
        
    }

}
