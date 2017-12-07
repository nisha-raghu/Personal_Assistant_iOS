//
//  DetailViewController.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit

class HealthDashboardDetailVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text: String = ""
    var masterView:PersonalDiaryVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }
    
    func setText(t:String){
        text = t
        if isViewLoaded{
            textView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
    }
}
