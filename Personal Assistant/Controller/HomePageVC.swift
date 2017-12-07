//
//  ViewController.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/24/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit
import LocalAuthentication

class HomePageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var assistanceTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        assistanceTable.dataSource = self
        assistanceTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getAssistance().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AssistanceCell") as? AssistanceCell {
            let assistance = DataService.instance.getAssistance()[indexPath.row]
            cell.updateViews(assistance: assistance)
            return cell
        } else {
            return AssistanceCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0  :
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [unowned self] success, authenticationError in
                    
                    DispatchQueue.main.async {
                        if success {
                            self.performSegue(withIdentifier: "PersonalDiarySegue", sender: nil)
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            
            break;
        case 1  :
            performSegue(withIdentifier: "LocateFriendsSegue", sender: nil)
            break;
        case 2  :
            performSegue(withIdentifier: "HealthDashboardSegue", sender: nil)
            break;
        case 3  :
            performSegue(withIdentifier: "FallDetectionSegue", sender: nil)
            break;
        case 4  :
            performSegue(withIdentifier: "ImageRecognitionSegue", sender: nil)
            break;
        default :
            print("Inside default statement")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let barBtn = UIBarButtonItem()
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn
    }


}

