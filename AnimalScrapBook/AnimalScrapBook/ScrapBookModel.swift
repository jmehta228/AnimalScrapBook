//
//  ScrapBookModel.swift
//  AnimalScrapBook
//
//  Created by Jaisal Mehta on 4/20/23.
//

// Jaisal Mehta jkmehta@iu.edu
// Jimi Michael jimimich@iu.edu
// Submission Date: 04/30/2023
// App Name: Animal Scrapbook

import UIKit

class ScrapBookModel {
    
    init() {
        
    }
    
    var animals = Dictionary<String, Int>()
    
    func getAnimals() -> Dictionary<String, Int> {
        return self.animals
    }
    
    func updateData(){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(getAnimals(), forKey: "dict")
        
    }
    
}
