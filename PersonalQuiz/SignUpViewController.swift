//
//  SignUpViewController.swift
//  PersonalQuiz
//
//  Created by admin on 6/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtSignUpUsername: UITextField!
    @IBOutlet weak var txtSignUpPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSignUpUsername.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUpNowClick(_ sender: Any) {
        handleSignUpSession()
    }
    
    func handleSignUpSession(){
        let username = txtSignUpUsername.text
        let password = txtSignUpPassword.text
        var currentId = 0
        var countusername = 0
        
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
            
            //Get id
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            //Thuc hien fetch cai fetchRequest vua tao
            do {
                let result = try managedContext.fetch(fetchRequest)
                for _ in result as! [NSManagedObject] {
                    currentId += 1
                }
            } catch {
                print("Failed")
            }
            
            //Check trung username
            do {
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    let dbusername = data.value(forKey: "username") as! String
                    if dbusername == username {
                        countusername += 1
                    }
                }
            } catch {
                print("Failed")
            }
            
            if countusername == 0 {
                //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
                // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
                let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
                //Insert du lieu
                let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
                user.setValue(currentId, forKey: "id")
                user.setValue(username, forKey: "username")
                user.setValue(0, forKey: "highscore")
                user.setValue(password, forKey: "password")
                //Khoi tao data score trong bang HighScore cho tung category
                createDataHighScoreForuser(id: currentId)
                
                //Kiem tra
                do {
                    try managedContext.save()
                    print("SignUp Success!")
                    usernameGlobal = username!
                    performSegue(withIdentifier: "successSegue", sender: nil)
                } catch let error as NSError {
                    print("Could not save: \(error)")
                }
            } else {
                //Thong bao trung username
                showAlertDialogSameUsername(titleAL: "Username has already exits!", messageAL: "Please choose another name!", btnLeft: "Confirm")
            }
            
        }
        
        
       
    }
    
    func createDataHighScoreForuser(id: Int){
        let arrCate = [0,1,2,3]
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let userEntity = NSEntityDescription.entity(forEntityName: "HighScores", in: managedContext)!
        
        //Insert du lieu
        for cate in arrCate {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(id, forKey: "iduser")
            user.setValue(cate, forKey: "idcategory")
            user.setValue(0, forKey: "score")
        }
        
        //Kiem tra
        do {
            try managedContext.save()
            print("data saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
        
    }
    
    func showAlertDialogSameUsername(titleAL: String?, messageAL: String?, btnLeft: String?){
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
