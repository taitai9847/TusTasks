//
//  SavedTaskViewController.swift
//  TusTasks
//
//  Created by 石川　太洋 on 2020/04/18.
//  Copyright © 2020 石川　太洋. All rights reserved.
//

import UIKit

class SavedTaskViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var savedTask: UITextView!
    
    var savedContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 10.0
        savedTask.text = savedContent
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
