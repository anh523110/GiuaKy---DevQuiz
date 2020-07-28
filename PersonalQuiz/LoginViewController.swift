//
//  LoginViewController.swift
//  PersonalQuiz
//
//  Created by admin on 6/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtLoginUsername: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Show HighScore")
//        showHighScores()
        
        // MARK: == nho cmt khi da load lan dau ==
//        addDatatoParentCategoryTable()
//        updateCategoryTable()
        
        print("Show ParentCategorys")
        showParentCategorys()
        //deleteAlluser()
        //deleteHighScoretable()
        self.txtLoginUsername.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDatatoParentCategoryTable(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let userEntity = NSEntityDescription.entity(forEntityName: "ParentCategorys", in: managedContext)!
        
        //Insert du lieu
        for i in 0...1 {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(i, forKey: "id")
            if i == 0 {
                user.setValue("web", forKey: "name")
            } else {
                user.setValue("mobile", forKey: "name")
            }
            
        }
        
        
        //Kiem tra
        do {
            try managedContext.save()
            print("data parent cate saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    func updateCategoryTable(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Categorys")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let name = data.value(forKey: "name") as! String
                if name == "html" {
                    data.setValue(0, forKey: "idparent")
                    data.setValue("html", forKey: "imgname")
                }
                if name == "css" {
                    data.setValue(0, forKey: "idparent")
                    data.setValue("css", forKey: "imgname")
                }
                if name == "java" {
                    data.setValue(1, forKey: "idparent")
                    data.setValue("java", forKey: "imgname")
                }
                if name == "python" {
                    data.setValue(1, forKey: "idparent")
                    data.setValue("python", forKey: "imgname")
                }
            }
            
            
            do {
                try managedContext.save()
                print("Update category successful !!")
            } catch {
                print("Failed !! Cannot update data")
            }
            
        } catch {
            print("Failed")
        }
    }
    
    //Ham kiem tra bang Categorys
    func showParentCategorys(){
//        //Khai bao bien appDelegate theo kieu AppDelegate
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        //Lay context chua du lieu coredata
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        //Tao mot cai fetchRequest
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ParentCategorys")
//
//        //Thuc hien fetch cai fetchRequest vua tao
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "id") as! Int)
//                print(data.value(forKey: "name") as! String)
//                print("------------------")
//            }
//        } catch {
//            print("Failed")
//        }
//    ---------------------------------------------------------
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext

        //Tao mot cai fetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categorys")

        //Thuc hien fetch cai fetchRequest vua tao
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! Int)
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "highscore") as! Int)
                print(data.value(forKey: "idparent") as! Int)
                print(data.value(forKey: "imgname") as! String)
                print("------------------")
            }
        } catch {
            print("Failed")
        }
    }
    
    //Ham kiem tra bang HighScore
    func showHighScores(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "iduser") as! Int)
                print(data.value(forKey: "idcategory") as! Int)
                print(data.value(forKey: "score") as! Int)
                print("------------------")
            }
        } catch {
            print("Failed")
        }
    }
    
    func deleteCategorys(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Categorys")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for score in result as! [NSManagedObject] {
                managedContext.delete(score)
            }
            try managedContext.save()
            print("Deleted Categorys successful !!")
            
        } catch {
            print("Failed !! Cannot delete data")
        }
    }
    
    func deleteHighScoretable(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for score in result as! [NSManagedObject] {
                managedContext.delete(score)
            }
            try managedContext.save()
            print("Deleted highscore successful !!")
            
        } catch {
            print("Failed !! Cannot delete data")
        }
    }
    
    
    func deleteAlluser(){
        var usernumber = [Int]()
        
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequestDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            let result = try managedContext.fetch(fetchRequestDelete)
            for data in result as! [NSManagedObject] {
                let iduser = data.value(forKey: "id") as! Int
                usernumber .append(iduser)
            }
        } catch {
            print("Failed")
        }
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for id in usernumber {
                let deletedObject = result[id] as! NSManagedObject
                managedContext.delete(deletedObject)
                
            }
            try managedContext.save()
            print("Deleted successful !!")
            
        } catch {
            print("Failed !! Cannot delete data")
        }
    }
    
    func createData(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        //Insert du lieu
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(0, forKey: "id")
        user.setValue("loc", forKey: "username")
        user.setValue(900, forKey: "highscore")
        user.setValue("123", forKey: "password")
        
        
        //Kiem tra luu data
        do {
            //Luu du lieu
            try managedContext.save()
            print("data saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    @IBAction func btnLoginPlayNow(_ sender: Any) {
        handleLoginSession()
        
    }
    
    func handleLoginSession(){
        //Vars
        let username = txtLoginUsername.text
        let password = txtLoginPassword.text
        
        //Check null
        if username == "" || password == "" {
            showAlertDialogPassword(titleAL: "Non letter be found!", messageAL: "Maybe you're forgetting type your username or password! Dont lets them null!", btnLeft: "Confirm")
        } else {
            //Khai bao bien appDelegate theo kieu AppDelegate
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            //Lay context chua du lieu coredata
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Tao mot cai fetchRequest
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
            
            //Them dieu kien
            fetchRequest.predicate = NSPredicate(format: "username = %@", username!)
            
            //Thuc hien fetch cai fetchRequest vua tao
            do {
                let result = try managedContext.fetch(fetchRequest)
                var count = 0
                
                for data in result as! [NSManagedObject] {
                    let dbusername = data.value(forKey: "username") as! String
                    if dbusername == username {
                        count += 1
                    } else {
                        return
                    }
                }
                
                if count == 1 {
                    for data in result as! [NSManagedObject] {
                        print(data.value(forKey: "username") as! String)
                        print(data.value(forKey: "password") as! String)
                        let dbusername = data.value(forKey: "username") as! String
                        let dbpassword = data.value(forKey: "password") as! String
                        if dbusername == username && dbpassword == password {
                            usernameGlobal = username!
                            performSegue(withIdentifier: "loginSegue", sender: nil)
                        } else {
                            //Thong bao sai matkhau
                            showAlertDialogPassword(titleAL: "Password Invalid!", messageAL: "Your password's invalid! Please, type again", btnLeft: "Confirm")
                            
                        }
                    }
                } else {
                    //Thong bao chua co username nay, vui long signup
                    showAlertDialogSignUp(titleAL: "User's not exits", messageAL: "Your username's not already exits! Signup Now !", btnLeft: "SignUp")
                }
                
                
            } catch {
                print("Failed")
            }
        }
        
    }
    
    
    func showAlertDialogPassword(titleAL: String?, messageAL: String?, btnLeft: String?){
        
        //Dialogs
        let acExit = UIAlertController(title: titleAL, message: messageAL, preferredStyle: UIAlertControllerStyle.alert)
        
        //Xu ly khi chon dong y
        acExit.addAction(UIAlertAction(title: btnLeft, style: .default, handler: { (action: UIAlertAction!) in
            //print("Confirm wrong password")
            //self.txtLoginPassword.becomeFirstResponder()
        }))
        
        //Xu ly khi chon dismiss
        acExit.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action: UIAlertAction!) in
            acExit.dismiss(animated: true, completion: nil)
        }))
        
        present(acExit, animated: true, completion: nil)
        
    }
    
    func showAlertDialogSignUp(titleAL: String?, messageAL: String?, btnLeft: String?){
        
        //Dialogs
        let acExit = UIAlertController(title: titleAL, message: messageAL, preferredStyle: UIAlertControllerStyle.alert)
        
        //Xu ly khi chon dong y
        acExit.addAction(UIAlertAction(title: btnLeft, style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "signupSegue", sender: nil)
        }))
        
        //Xu ly khi chon dismiss
        acExit.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action: UIAlertAction!) in
            acExit.dismiss(animated: true, completion: nil)
        }))
        
        present(acExit, animated: true, completion: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
