//
//  ViewController.swift
//  NotesTakingApp
//
//  Created by Brijesh Nayak on 2/27/17.
//  Copyright © 2017 Brijesh Nayak. All rights reserved.
//

import UIKit

// UITableViewDataSource is a protocol/interface
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var data:[String] = []
    var selectedRow:Int = -1
    var newRowText:String = ""
    
    var file:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Give title to the tableView navigation bar
        self.title = "Notes"
        
        // Here we are creating instance of the UIBarButtonItem by calling initializer/construcor of the UIBarButtonItem class
        // So addButton now holds the reference to the UIBarButtonItem
        // Also here we are saying that when this button is pressed call the addNote function
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        // Here we are actually adding the barbutton, since we said target is "self" it will add button to this views navaigation bar on the right
        self.navigationItem.rightBarButtonItem = addButton
        
        // Here we are adding default ediButton directy with out assigning the action
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        // search for "Document Directory in all the files on the iPhone
        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        
        // Here after we get the path of the documentDirectory we are creating/adding textfile to it
        // Think of this as creating new folder and then adding new file to it, actually we are not creating new folder.
        // we are just getting the path of the folder that already exists, and  creating new file to it
        file = docsDir[0].appending("notes.txt")
        
        // Calling load function
        load()
    }
    
    // when this view is going to appear 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedRow == -1 {
            return
        }
        
        // Get the last added text of the table
        data[selectedRow] = newRowText
        
        // If the last added note contains empty string remove the entry
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        
        // After you remove the entry update the table to reflect new changes
        table.reloadData()
        
        // Caling save function
        save()
    }
    
    // When user taps on the "+" button do the following
    func addNote() {
        
        // don't allow editing rows when in deleting mode
        // This calls the "setEditing" function
        if(table.isEditing){
            return
        }
        
        let name:String = ""
        
        // Add empty string at index 0 in the data array
        data.insert(name, at: 0)
        
        // Get the path of the table starting from row 0 in section 0
        // Now indexPath variable hold path to the rows in the table
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        
        // Add rows in the table
        table.insertRows(at: [indexPath], with: .automatic)
        
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
        // Go to DetaildViewController
         self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    // This is the method that is being called when editiing button is pressed
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        
        save()
    }
    
//------------------------------------------------------------------------------------------------------
    // For delegate
    
    // This method is called when user selects a particular row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("\(data[indexPath.row])")
        
        self.performSegue(withIdentifier: "detail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: data[selectedRow])
    }
    
    
    
    
//------------------------------------------------------------------------------------------------------
    // For Data Source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // have to return int
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell:UITableViewCell = UITableViewCell()
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
        
    }
//------------------------------------------------------------------------------------------------------
    
    // save the data when data is added
    func save () {
//        // Saves data to local device, but time it saves is up to OS
//        UserDefaults.standard.set(data, forKey: "notes")
//        // But if you use synchronize, it will save data right away
//        UserDefaults.standard.synchronize()
        
        // creates NSArray object using array
        let newData:NSArray = NSArray(array: data)
        newData.write(toFile: file, atomically: true)
        
    }
    
    // load the data
    func load() {
        // if we can get this data and it is a array of string assign it to loadedData
//        if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String] {
//            data = loadedData
//            
//            // this will call tableView protocol mathod
//            table.reloadData()
//        }
        
        // Using files to store data
        if let loadedData = NSArray(contentsOfFile:file) as? [String] {
            data = loadedData
            
            // this will call tableView protocol mathod
            table.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

