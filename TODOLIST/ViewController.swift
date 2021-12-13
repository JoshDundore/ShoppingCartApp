//
//  ContentView.swift
//  
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    //array of item names
    var items = [String]()
    //array of item calories
    var itemCal = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for testing purposes, resets userDefaults data
        //let defaults = UserDefaults.standard
        //let dictionary = defaults.dictionaryRepresentation()
        //dictionary.keys.forEach { key in defaults.removeObject(forKey: key)}
        
        
        self.title = "Items"
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        //Get all current saved tasks
        updateTasks()
    }
    
    func updateTasks() {
        
        items.removeAll()
        itemCal.removeAll()
        
        //retrieve current count
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        //assign existing items
        for x in 0...count {
            
            if let task = UserDefaults().value(forKey: "item_\(x + 1)") as? String {
                items.append(task)
                
            }
            if let cal = UserDefaults().value(forKey: "cal_\(x + 1)") as? String { itemCal.append(cal)}
            
        }
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Item"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
            
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        //pass values to task when row clicked
        let vc = storyboard?.instantiateViewController(identifier: "tasks") as! TaskViewController
        vc.title = "New Item"
        vc.item = items[indexPath.row]
        vc.cal = itemCal[indexPath.row]
        vc.currentLocation = indexPath.row
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        //remove row
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                tableView.beginUpdates()
                //remove from array and tblvw
                items.remove(at: indexPath.row)
                itemCal.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
                //retrieve count
                guard let count = UserDefaults().value(forKey: "count") as? Int else{
                    return
                }
                
                let newCount = count - 1
                //remove userdefault data
                UserDefaults().setValue(newCount, forKey: "count")
                UserDefaults().removeObject(forKey: "task_\(indexPath.row)")
                UserDefaults().removeObject(forKey: "cal_\(indexPath.row)")
                
            }
        }
    

}
