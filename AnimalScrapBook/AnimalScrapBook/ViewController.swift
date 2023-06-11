//
//  ViewController.swift
//  AnimalScrapBook
//
//  Created by Jimi Michael on 4/14/23.
//

// Jaisal Mehta jkmehta@iu.edu
// Jimi Michael jimimich@iu.edu
// Submission Date: 04/30/2023
// App Name: Animal Scrapbook


import UIKit

class ViewController: UIViewController {
    
    var appDelegate: AppDelegate?
    var myModelRef: ScrapBookModel?
    @IBOutlet weak var deleteField: UITextField!
    
//    func updateDictionaryLabel() {
//        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
//        self.myModelRef = self.appDelegate?.scrapBookModel
//
//        var tempString = ""
//        for (key, value) in myModelRef!.animals {
//            let returnStr = key + " : " + String(value)
//            tempString += returnStr + ", "
//        }
//        textLabel.text = tempString
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func deleteData(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set([:], forKey: "dict")
        myModelRef?.animals = [:]
    }
    
    @IBAction func deleteCertainData(_ sender: Any){
        
        let userDefaults = UserDefaults.standard
        var dict = userDefaults.dictionary(forKey: "dict") ?? Dictionary<String, Int>()
        //Removing from the tableview what the user inuts
        dict.removeValue(forKey: deleteField.text!)
        deleteField.resignFirstResponder()
        deleteField.text! = ""
        userDefaults.set(dict, forKey: "dict")
        //print(dict)
        //Update the list after changes
        let keys = Array(dict.keys)
        let values = Array(dict.values)
        for(index, key) in keys.enumerated(){
            myModelRef?.animals[key] = values[index] as? Int
        }
    }
    
    @IBAction func showScrapBook(_ sender: Any) {
        performSegue(withIdentifier: "showScrapBook", sender: self)
       //        updateDictionaryLabel()
        
        //Place to update the list
        let userDefaults = UserDefaults.standard
        let dict = userDefaults.dictionary(forKey: "dict") ?? Dictionary<String, Int>()
        let keys = Array(dict.keys)
        let values = Array(dict.values)
        for(index, key) in keys.enumerated(){
            myModelRef?.animals[key] = values[index] as? Int
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScrapBook" {
            if segue.destination is ScrapBookViewController {
            }
        }
    }
    
/*
 STUB CODE:
 Here we will implement persistent storage to be able to keep track of one high score, as well as a total score for each letter that goes to the table view controller.
 
 One more thing needed to be added is the QuizModel class, which will be fairly simple, containing the current score, and a 2D array for the score of each letter.
 */

}

