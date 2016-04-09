//
//  EntryDetailViewController.swift
//  Journal_Challenge
//
//  Created by Diego Aguirre on 4/8/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entry = self.entry {
            self.updateEntry(entry)
        }
    }
}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return titleTextField.resignFirstResponder()
    }
}

extension EntryDetailViewController: UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            bodyTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension EntryDetailViewController {
    func updateEntry(entry: Entry) {
        if let entry = self.entry {
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
        }
    }
}

extension EntryDetailViewController {
    @IBAction func clearButtonPressed(sender: AnyObject) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        guard let title = titleTextField.text,
            body = bodyTextView.text else { return }
        
        if title != "" && body != "" {
            let entry = Entry(title: title, body: body, date: NSDate())
            EntryController.sharedInstance.updateEntry(entry, newTitle: title, newBody: body, newDate: NSDate())
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
