//
//  TodoListTableViewController.swift
//  TodoList2
//
//  Created by Maria Stezhko on 3/20/18.
//  Copyright © 2018 Maria Stezhko. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [TodoListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addBarButtonPressed(_ sender:
        UIBarButtonItem) {
        performSegue(withIdentifier: "AddItemSegue", sender: sender)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
    
    //var nums = [1, 90, 32, 23, 9, 12]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        print("Hi")
        cell.titleLabel.text = items[indexPath.row].title!
        //cell.titleLabel.text = "yyyyy"
        cell.notesLabel.text = items[indexPath.row].notes!
        cell.dateLabel.text = items[indexPath.row].date!
        //cell.rightLabel.text = "\(nums[indexPath.row])"
        //if nums[indexPath.row] > 24 {
           // cell.leftButton.backgroundColor = UIColor.green()
        //} else {
          //  cell.leftButton.backgroundColor = UIColor.red()
        //}
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            //let navigationController = segue.destination as! UINavigationController
            let addItemViewController = segue.destination as! AddItemViewController
            addItemViewController.delegate = self
            
            if (sender as? NSIndexPath) != nil {
                let indexPath = sender as! NSIndexPath
                let item = items[indexPath.row]
                addItemViewController.editTitle = item.title!
                addItemViewController.editNotes = item.notes!
                addItemViewController.editDate = item.date!
                addItemViewController.indexPath = indexPath
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [TodoListItem]
        } catch {
            print(error)
        }
    }
    
    func itemSaved(by controller: AddItemViewController, title: String, notes: String, date: String, at indexPath: NSIndexPath?) {
        
        if let index = indexPath {
            items[index.row].title = title
            items[index.row].notes = notes
        } else {
        
            print("text \(title), \(notes), \(date)")
            let item = NSEntityDescription.insertNewObject(forEntityName: "TodoListItem", into: managedObjectContext) as! TodoListItem
            item.title = title
            item.notes = notes
            item.date = date
            items.append(item)
            print(items)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
            }
        }
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let item = items[indexPath.row]
//        managedObjectContext.delete(item)
//
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print(error)
//        }
//        items.remove(at: indexPath.row)
//        tableView.reloadData()
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let item = self.items[indexPath.row]
            self.managedObjectContext.delete(item)
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // edit item at indexPath
            self.performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
