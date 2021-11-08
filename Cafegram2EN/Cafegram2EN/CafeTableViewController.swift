//
//  CafeTableViewController.swift
//  Cafegram2EN
//
//  Created by Farukh IQBAL on 16/05/2018.
//  Copyright © 2018 Farukh IQBAL. All rights reserved.
//

import UIKit

class CafeTableViewController: UITableViewController {
    
    var cafeNames = ["Berkeley Cafe", "Black Cafe", "Black Ring Coffee", "Camber Coffee", "Coffee Shop", "Friends Cafe", "Hard Rock Cafe", "Hop & Stork Cafe", "La Mo Cafe", "La Perla Cafe", "Mall Cafe", "Nuare Cafe", "Outpost Cafe", "Pink Lane Cafe", "Sheep Cafe", "The Good Life Cafe", "Think Coffee"]
    
    var cafeImages = ["berkeleyCafe", "blackCoffee", "blackRingCoffee", "camberCoffee", "coffeeShop", "friendsCafe", "hardRockCafe", "hopStorkCoffee", "laMoCafe", "laPerlaCafe", "mallCafe", "nuareCoffee", "outpostCoffee", "pinkLaneCoffee", "sheepCoffee", "theGoodLifeCoffee", "thinkCoffee"]
    
    var cafeLocations = ["Raleigh", "Kiev", "Long Beach", "Newcastle", "Alberta", "New York", "Paris", "Utrecht", "Turlock", "Caba", "Hong Kong", "Kiev", "Nottingham", "Newcastle", "Londres", "Moudon", "New York"]
    
    var cafeTypes = ["Cosy", "Classy", "Cool", "Cosy", "Classy", "Cool", "Cosy", "Classy", "Cool", "Cosy", "Classy", "Cool", "Cosy", "Classy", "Cool", "Cosy", "Classy"]
    
    var cafeIsVisited = Array(repeating: false, count: 17)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cafeNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CafeTableViewCell

        // Configure the cell...
        cell.nameLabel.text = cafeNames[indexPath.row]
        cell.locationLabel.text = cafeLocations[indexPath.row]
        cell.typeLabel.text = cafeTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: cafeImages[indexPath.row])
        
        cell.accessoryType = cafeIsVisited[indexPath.row] ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add Call action
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        
        optionMenu.addAction(callAction)
        optionMenu.addAction(cancelAction)
        
        let checkActionTitle = (cafeIsVisited[indexPath.row]) ? "Undo Check in" : "Check in"
        
        // Check-in action
        let checkInAction = UIAlertAction(title: checkActionTitle, style: .default) { (action: UIAlertAction!) in
            let cell = tableView.cellForRow(at: indexPath) as! CafeTableViewCell
            self.cafeIsVisited[indexPath.row] = (self.cafeIsVisited[indexPath.row]) ? false : true
            cell.accessoryType = (self.cafeIsVisited[indexPath.row]) ? .checkmark : .none
        }
        
        optionMenu.addAction(checkInAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data source
            self.cafeNames.remove(at: indexPath.row)
            self.cafeLocations.remove(at: indexPath.row)
            self.cafeIsVisited.remove(at: indexPath.row)
            self.cafeTypes.remove(at: indexPath.row)
            self.cafeImages.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.cafeNames[indexPath.row]
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.cafeImages[indexPath.row]) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! CafeTableViewCell
            self.cafeIsVisited[indexPath.row] = (self.cafeIsVisited[indexPath.row]) ? false : true
            cell.accessoryType = (self.cafeIsVisited[indexPath.row]) ? .checkmark : .none
            
            completionHandler(true)
        }
        
        // Customize the action button
        checkInAction.backgroundColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        checkInAction.image = self.cafeIsVisited[indexPath.row] ? UIImage(named: "undo") : UIImage(named: "tick")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        return swipeConfiguration
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
