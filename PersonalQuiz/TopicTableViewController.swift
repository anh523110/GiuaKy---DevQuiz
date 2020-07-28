//
//  TopicTableViewController.swift
//  PersonalQuiz
//
//  Created by admin on 7/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData


var arrDataListTopic: [ParentCategory] = []
class TopicTableViewController: UITableViewController {
    
    var userid: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindToQuizTopic(segue:
        UIStoryboardSegue) {
        
    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let context = UIContextualAction(style: .destructive, title: "Reset") {_,_,_ in
//            print("Hello")
//        }
//        let swipeAction = UISwipeActionsConfiguration(actions: [context])
//        return swipeAction
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromParentCategorysAndCategorysTable()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let category = arrDataListTopic[indexPath.section].categories[indexPath.row]
            
            categoryGB = category
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrDataListTopic.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrDataListTopic[section].categories.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrDataListTopic[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TopicTableViewCell
        let category:Category = arrDataListTopic[indexPath.section].categories[indexPath.row]
        cell.imageViewTopic?.image = UIImage(named: category.imgname)
        cell.lblTopicName?.text = category.name
        cell.lblPoint?.text = String(category.highscore)
        return cell
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        //Khai bao config CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
        
        
        fetchRequest.predicate = NSPredicate(format: "iduser = %ld", userid)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                 data.setValue(0, forKey: "score")
            }
            
            
            do {
                try managedContext.save()
                print("Update successful !!")
            } catch {
                print("Failed !! Cannot update data")
            }
            
        } catch {
            print("Failed")
        }
        self.getDataFromParentCategorysAndCategorysTable()
        tableView.reloadData()
    }
    
    var state = 1
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let refresh = UITableViewRowAction(style: .destructive, title: "Refresh") { (action, indexPath) in
            let objscore = arrDataListTopic[indexPath.section].categories[indexPath.row]
            
            
            //Khai bao config CoreData
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Tao mot cai fetchRequest
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
            
            
            fetchRequest.predicate = NSPredicate(format: "iduser = %ld AND idcategory = %ld", self.userid, objscore.id)
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(0, forKey: "score")
              
                
                do {
                    try managedContext.save()
                    print("Update successful !!")
                } catch {
                    print("Failed !! Cannot update data")
                }
                
            } catch {
                print("Failed")
            }
            
            self.getDataFromParentCategorysAndCategorysTable()
            tableView.reloadData()
        }
        
        let mode = UITableViewRowAction(style: .destructive, title: "Mode") { (action, indexPath) in
            
        }
        mode.backgroundColor = UIColor.green
        refresh.backgroundColor = UIColor.blue
        
        
        return [refresh]
    }
    
    func getDataFromParentCategorysAndCategorysTable(){
        //Vars
        var arrCategory: [Category] = []
        var arrCategoryWeb: [Category] = []
        var arrCategoryMobile: [Category] = []
        var arrParentCategory: [ParentCategory] = []
        let emptyArrQuestion: [Question] = []
        
        
        //Khai bao config coredata
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "ParentCategorys")
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        
        
        //lay mang highscore (object type: Category) roi gan vao mang parentcategory
        do {
            //Fetching Conditions
            fetchRequest2.predicate = NSPredicate(format: "username = %@", usernameGlobal )
            
            //Lay userid tu usernameGlobal
            let result = try managedContext.fetch(fetchRequest2)
            let objResult = result[0] as! NSManagedObject
            userid = objResult.value(forKey: "id") as? Int
            
            //Fetching Conditions
            fetchRequest.predicate = NSPredicate(format: "iduser = %ld", userid )
            
            //Tim ra diem cua tung category cua user dua vao userid -> tao mang Category
            let result1 = try managedContext.fetch(fetchRequest)
            for data in result1 as! [NSManagedObject] {
                let id = data.value(forKey: "idcategory") as! Int
                var name = ""
                if id == 0 {
                    name = "html"
                } else {
                    if id == 1 {
                        name = "css"
                    } else {
                        if id == 2 {
                            name = "python"
                        } else {
                            name = "java"
                        }
                    }
                }
                
                let highscore = data.value(forKey: "score") as! Int
                var idparent = 0
                if id == 0 {
                    idparent = 0
                } else {
                    if id == 1 {
                        idparent = 0
                    } else {
                        if id == 2 {
                            idparent = 1
                        } else {
                            idparent = 1
                        }
                    }
                }
                
                let objCate = Category(id: id, name: name, questions: emptyArrQuestion, highscore: highscore, idparent: idparent, imgname: name)
                arrCategory.append(objCate)
            }
            
            //loc category theo parentcategory
            for data in arrCategory {
                if data.idparent == 0 {
                    arrCategoryWeb.append(data)
                } else {
                    arrCategoryMobile.append(data)
                }
            }
            
            
            //Gan mang Category tuong ung vao parentcategory
            let result2 = try managedContext.fetch(fetchRequest1)
            for data in result2 as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! Int
                let name = data.value(forKey: "name") as! String
                
                if id == 0 {
                    let objParentCate = ParentCategory(id: id, name: name, categories: arrCategoryWeb)
                    arrParentCategory.append(objParentCate)
                } else {
                    let objParentCate = ParentCategory(id: id, name: name, categories: arrCategoryMobile)
                    arrParentCategory.append(objParentCate)
                }
                
            }
            
            
            
            arrDataListTopic = arrParentCategory
        } catch {
            print("Failed")
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
