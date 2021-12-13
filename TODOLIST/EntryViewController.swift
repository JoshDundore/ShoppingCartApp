//
//  EntryViewController.swift
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var CalorieField: UITextField!
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
    
    //save data
    @objc func saveTask() {
        //check for empty fields
        guard let text = field.text, !text.isEmpty else {
            return
        }
        //check for empty fields
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        //check for empty fields
        guard let Caltext = CalorieField.text,!Caltext.isEmpty else {
            return
        }
        //increase counter and store data
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "item_\(newCount)")
        UserDefaults().set(Caltext, forKey: "cal_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
