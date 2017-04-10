//
//  DetailViewController.swift
//  NotesTakingApp
//
//  Created by Brijesh Nayak on 2/27/17.
//  Copyright © 2017 Brijesh Nayak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Connecting textView to this class
    @IBOutlet weak var textView: UITextView!
    
    // Setting up default text for the textView
    var text:String = ""
    
    // Property / Instance variable, this will let you access the properties/instace variables of the ViewController class
    // Instance of the ViewController.swift class
    var masterView:ViewController! 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // When this view is loaded/ set the textView text to the default text which is "Empty String"
        textView.text = text
        
        // This autometically selts the textView instead of user having to select the textView when they are trying to modify or add notes to the table
        textView.becomeFirstResponder()
        
    }
    
    // When user clicks on the cell, load the text assign to that cell
    // Function to update default text to the text passed to this parameter
    func setText (t:String) {
        text = t
        
        // If view is loaded update the textView
        if isViewLoaded {
            
            textView.text = t

        }
    }
    
    // When this view is about to disappear update/add the cell text
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Get the text entered by the user, and assign it to newRowText
        masterView.newRowText = textView.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
