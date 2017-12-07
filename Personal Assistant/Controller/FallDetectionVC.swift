//
//  FallDetectionVC.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit
import CoreMotion
import Darwin

class FallDetectionVC: UIViewController {

    @IBOutlet var detectText: UILabel!
    
    var motionManager = CMMotionManager()
    var detected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fall Detection"
        self.detectAccel()
    }
   
    func detectAccel() {
        self.detectText.text = "Detecting..."
        motionManager.startAccelerometerUpdates(to: OperationQueue()) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            let acceleration = accelerometerData!.acceleration
            let a = pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2)
            print(a)
            //By theory, if a drop to 0, mean phone is dropping
            DispatchQueue.main.async(execute: { () -> Void in
                if (a < 0.1) {
                    self.detectText.text = "Detected Fall"
                    print("Detect phone fall...")
                    let alert = UIAlertController(title: "SOS", message: "You Fell. LOL!", preferredStyle: UIAlertControllerStyle.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    self.motionManager.stopAccelerometerUpdates()
                } else {
                    //phone not drop
                }
            })
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }

    @IBAction func startBtn(_ sender: UIButton) {
        self.detectAccel()
    }


    @IBAction func stopBtn(_ sender: UIButton) {
        detectText.text = "No Fall Detected"
        motionManager.stopAccelerometerUpdates() //Stop update
    }

}
