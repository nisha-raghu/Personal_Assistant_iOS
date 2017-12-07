//
//  PersonalDiaryVC.swift
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit

class PersonalDiaryVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
    @IBOutlet weak var tabel: UITableView!
    var data:[String] = []
    var selectedRow:Int = -1
    var newRowText:String = ""
    var file:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Personal Diary"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        tabel.reloadData()
        save()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tabel.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tabel.deleteRows(at: [indexPath], with: .fade)
        save()
        //  saveInFile()
    }
    
    //delegate function to handle interactivity on click of the row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "detail", sender: nil)
        // print("\(data[indexPath.row])")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:HealthDashboardDetailVC = segue.destination as! HealthDashboardDetailVC
        selectedRow = tabel.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: data[selectedRow])
    }
    
    //saving in persistent storage
    // Archieve logic
    
    func save(){
        let fileName = "SaveToArchives"
        
        UserDefaults.standard.set(data, forKey: "notes")
        
        // useful incase of a crash, the data is synchronized immediately to the persistent storage
        
        UserDefaults.standard.synchronize()
      
        //archived
        
        // Save data to file
     
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        //filepath
        
        print("Saving..")
        
        print("Saved to Archives!!")
        
        print("Path of Archives: \(fileURL.path)")

        // write to file
        
        NSKeyedArchiver.archiveRootObject(data, toFile: fileURL.path)
   
        // read from file
        
        let dict2 = String(describing: NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path))
        
        print("Contents of Archived File:\n"+dict2)
        
    }
    
    func load(){
        //load from file..
        //if let loadedData = NSArray(contentsOfFile:file) as? [String]{
        if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String] {
            data = loadedData
            tabel.reloadData()
        }
    }
    // add note
    @objc func addNote(){
        if(tabel.isEditing){
            return
        }
        let name:String = ""//"Row \(data.count+1)"
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        tabel.insertRows(at: [indexPath], with: .automatic)
        tabel.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
}

