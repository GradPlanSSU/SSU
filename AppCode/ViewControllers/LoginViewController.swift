//
//  ViewController.swift
//  SSUSchedulePlanner
//
//  Created by Ivan Lim on 11/6/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    var token = String()
    
    @IBAction func didTapLogInButton(_ sender: UIButton) {
        
        let username = usernameInput.text
        let password = passwordInput.text

        if (username?.characters.count)! < 4 || (password?.characters.count)! < 6 {

            print("Invalid Username and/or Password")
            let alertController = UIAlertController(title: "Invalid Username/Password", message: "", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            print("Attempting to login")
            let login = NetRequestHandler(withURLString: "http://blue.cs.sonoma.edu:8000/authenticate/login").usePostString(postString: "fullname=" + username! + "&student_id=" + password!)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            login.post_request_callback() { data in
                do {
                    let student: Student? = try JSONDecoder().decode(Student.self, from: data!)
                    if student != nil {
                        AuthToken.token = student!.token
                        print(AuthToken.token)
                    }
                    
                    let newToken = Token(context: context)
                    
                    newToken.token = AuthToken.token
                    
                    do
                    {
                        try context.save()
                        print("Saved Token To Core Data")
                    }
                    catch
                    {
                        // error
                    }
                    
                    OperationQueue.main.addOperation {
                        self.performSegue(withIdentifier: "LoginToMainMenu", sender: self)
                    }
                } catch {
                
                }
            }
            
        }
      
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Token> = Token.fetchRequest()
        do
        {
            let token: [Token] = try context.fetch(fetchRequest)
            if token.count > 0 {
                print("Token count: \(token.count)")
                print("Token count is greater than 0")
                let tokenString = token[0].token as String?
                if tokenString != nil {
                    AuthToken.token = tokenString!
                    let login = NetRequestHandler(withURLString: "http://blue.cs.sonoma.edu:8000/authenticate/tokenlogin").useParams().useToken()
                    print("Got login object")
                    login.post_request_callback() { data in
                        do {
                            print("Trying to decode student json")
                            let student: Student? = try JSONDecoder().decode(Student.self, from: data!)
                            print("Decoded student JSON")
                            if student != nil {
                                print(AuthToken.token)
                            }
                            
                            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Token")
                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                            
                            do {
                                try context.execute(deleteRequest)
                                try context.save()
                            } catch {
                                print ("There was an error")
                            }
                            
                            let newToken = Token(context: context)
                            
                            AuthToken.token = (student?.token)!
                            newToken.token = AuthToken.token
                            
                            do
                            {
                                try context.save()
                                print("Saved Token To Core Data")
                            }
                            catch
                            {
                                // error
                            }
                            
                            
                            OperationQueue.main.addOperation {
                                self.performSegue(withIdentifier: "LoginToMainMenu", sender: self)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
        }
        catch
        {
            print("Error in Retrieving Token")
        }
        
        self.view.backgroundColor = UniversityDarkBlue
        
        logo.image = UIImage(named: "ssuLogo.jpg")
        
        usernameInput.placeholder = "SSU Username"
        usernameInput.autocorrectionType = UITextAutocorrectionType.no
        
        passwordInput.placeholder = "Password"
        passwordInput.isSecureTextEntry = true
        
        loginButton.backgroundColor = UIColor.white
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 0
        loginButton.layer.cornerRadius = 5
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameInput.text = ""
        passwordInput.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

