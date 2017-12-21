//
//  MainMenuViewController.swift
//  SSUSchedulePlanner
//
//  Created by Ivan Lim on 11/6/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData
import CollapsibleTableSectionViewController

class MainMenuViewController: UIViewController {
    
    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)

    @IBOutlet weak var CreateScheduleButton: UIButton!
    @IBOutlet weak var MySchedulesButton: UIButton!
    @IBOutlet weak var ARRButton: UIButton!
    @IBOutlet weak var banner: UILabel!
    
    // actions to help me debug and trace my code
    @IBAction func didTapCreateScheduleButton(_ sender: UIButton) {
        print("Clicked Create Schedule")
    }
    @IBAction func didTapMySchedulesButton(_ sender: UIButton) {
        print("Clicked My Schedules")
    }
    @IBAction func didTapARRButton(_ sender: UIButton) {
        print("Clicked Academic Requirements Report")
    }
    
    // deletes the token saved inside Core Data to disallow automatic login
    // on the next launch
    @IBAction func didTapLogoutButton(_ sender: UIBarButtonItem) {
        print("Clicked Logout Button")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Token")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        
        presentingViewController?.dismiss(animated: true, completion: nil )
    }
    
    // presents the view and downloads a list of courses from a remote API
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        banner.textColor = UIColor.white
        banner.backgroundColor = UniversityDarkBlue
        
        ARRButton.backgroundColor = UniversityDarkBlue
        ARRButton.setTitleColor(UIColor.white, for: .normal)
        ARRButton.layer.borderColor = UIColor.white.cgColor
        ARRButton.layer.borderWidth = 0
        ARRButton.layer.cornerRadius = 9

        MySchedulesButton.backgroundColor = UniversityDarkBlue
        MySchedulesButton.layer.borderColor = UIColor.white.cgColor
        MySchedulesButton.setTitleColor(UIColor.white, for: .normal)
        MySchedulesButton.layer.borderWidth = 0
        MySchedulesButton.layer.cornerRadius = 9
        
        CreateScheduleButton.backgroundColor = UniversityDarkBlue
        CreateScheduleButton.layer.borderColor = UIColor.white.cgColor
        CreateScheduleButton.setTitleColor(UIColor.white, for: .normal)
        CreateScheduleButton.layer.borderWidth = 0
        CreateScheduleButton.layer.cornerRadius = 9
        
        let download = NetRequestHandler(withURLString: "http://blue.cs.sonoma.edu:8000/courses/catalog").useParams().useToken()
        CourseList.courses = download.download_request()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
