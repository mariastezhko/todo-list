//
//  AddItemViewController.swift
//  TodoList2
//
//  Created by Maria Stezhko on 3/20/18.
//  Copyright © 2018 Maria Stezhko. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    var dateFormatter = DateFormatter()
    weak var delegate: AddItemViewControllerDelegate?
    var editTitle: String?
    var editNotes: String?
    var editDate: String?
    
    var indexPath: NSIndexPath?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        datePicker.datePickerMode = UIDatePickerMode.date
        dateFormatter.dateFormat = "MM/dd/yy"
        var selectedDate = dateFormatter.string(from: datePicker.date)
        let title = titleTextField.text!
        let notes = notesTextField.text!
        let date = selectedDate
        delegate?.itemSaved(by: self, title: title, notes: notes, date: date, at: indexPath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = editTitle
        notesTextField.text = editNotes
        
        dateFormatter.dateFormat = "MM/dd/yy"
        let date = dateFormatter.date(from: editDate!)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: date!)
        let finalDate = calendar.date(from: components)
        datePicker.date = finalDate!
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

