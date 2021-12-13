//
//  TaskViewController.swift
//
//

import UIKit

class TaskViewController: UIViewController {
    
    
    
    @IBOutlet weak var CalCount: UILabel!
    
    @IBOutlet weak var CalLabel: UILabel!
    
    @IBOutlet var label: UILabel!
    
    var item: String!
    
    var cal: String!
    
    var currentLocation: Int!
    
    
    //assign labels from passed data
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = item
        CalCount.text = cal
        
    }
    
    
    


}
