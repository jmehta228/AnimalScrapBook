//
//  TableViewController.swift
//  AnimalScrapBook
//
//  Created by Jimi Michael on 4/14/23.
//


// Jaisal Mehta jkmehta@iu.edu
// Jimi Michael jimimich@iu.edu
// Submission Date: 04/30/2023
// App Name: Animal Scrapbook

import UIKit

class ScrapBookTableViewController: UITableViewController {
    
    var appDelegate: AppDelegate?
    var myModelRef: ScrapBookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModelRef = self.appDelegate?.scrapBookModel
        
        //Place to update the list
        let userDefaults = UserDefaults.standard
        let dict = userDefaults.dictionary(forKey: "dict") ?? Dictionary<String, Int>()
        let keys = Array(dict.keys)
        let values = Array(dict.values)
        for(index, key) in keys.enumerated(){
            myModelRef?.animals[key] = values[index] as? Int
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // 26
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 26 // 1
        if myModelRef?.animals != nil{
            return (myModelRef?.animals.count)!
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModelRef = self.appDelegate?.scrapBookModel
        
        //Place to update the list
        let userDefaults = UserDefaults.standard
        let dict = userDefaults.dictionary(forKey: "dict") ?? Dictionary<String, Int>()
        let keys = Array(dict.keys)
        let values = Array(dict.values)
        for(index, key) in keys.enumerated(){
            myModelRef?.animals[key] = values[index] as? Int
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AnimalTableViewCell
        let keys1: [String] = Array((myModelRef?.animals.keys)!)
        let values1: [Int] = Array((myModelRef?.animals.values)!)
        cell.nameLabel.text = keys1[indexPath[1]]
        cell.frequencyLabel.text = String(values1[indexPath[1]])
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let ScrapBookTableViewController = self.view as? UITableView {
            ScrapBookTableViewController.reloadData()
        }
    }

    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
