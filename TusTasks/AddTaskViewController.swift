//
//  AddTaskViewController.swift
//  TusTasks
//
//  Created by 石川　太洋 on 2020/04/06.
//  Copyright © 2020 石川　太洋. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content.delegate = self
        saveButton.layer.cornerRadius = 10.0
        backButton.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if (content.text != "") {
            let realm = try! Realm()
            let tasks = Tasks()
            tasks.content = content.text
            try! realm.write {
                realm.add(tasks)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
