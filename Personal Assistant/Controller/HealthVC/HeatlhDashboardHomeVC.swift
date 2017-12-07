//
//  SCHomeViewController.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit
import CoreMotion

class HeatlhDashboardHomeVC: UITableViewController {

    @IBOutlet var homeTableView: UITableView!
    static let calendar = NSCalendar.current
    static let activityManager = CMMotionActivityManager()
    static let pedoMeter = CMPedometer()
    var selectedDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.separatorStyle = .none
        navigationItem.title = "Health Dashboard"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailViewSegue" {
            if segue.destination is HealthDashboardListVC {
                let detailVC = segue.destination as! HealthDashboardListVC
                if let cell = sender as? HDHomeTableViewCell {
                    let pointInTable: CGPoint = cell.convert(cell.bounds.origin, to: self.tableView)
                    let cellIndexPath = self.tableView.indexPathForRow(at: pointInTable)
                    detailVC.selectedDay = (cellIndexPath?.row)!
                }
                let backItem = UIBarButtonItem()
                backItem.title = "Back"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
 

}

extension HeatlhDashboardHomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Utility.numberOfDays
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCounterTableViewCell", for: indexPath) as! HDHomeTableViewCell
        let day = indexPath.row
        let fromDate = Date.init(timeInterval: TimeInterval(-86400 * day), since: Date())
        let fromDateMidnight = Utility.getMidnightDateTime(date: fromDate)
        let toDate = Date.init(timeInterval: 86400, since: fromDate)
        let toDateMidnight = Utility.getMidnightDateTime(date: toDate)
        if(CMPedometer.isStepCountingAvailable()){
            HeatlhDashboardHomeVC.pedoMeter.queryPedometerData(from: fromDateMidnight, to: toDateMidnight) { (data : CMPedometerData!, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        cell.numberOfSteps.text = String(describing: data.numberOfSteps)
                    }
                })
                
            }
        }
        cell.dateLabel.text = day == 0 ? "Today" : Utility.getFormattedDate(date: fromDate)
        return cell
    }
    
}
