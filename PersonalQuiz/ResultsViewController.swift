//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by admin on 5/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData


var usernameGlobal = ""
var questionNum = 0
var exactQuestionNum = 0

class ResultsViewController: UIViewController {
    
    var responses: [Answer]!
    var apptype: String!
    var yourScore = 0
    var arrHighScore: [Int] = []
    var highestScore = 0
    var idUserHighScoreFCategorys = 0
    var idCate = 0
    var idUser = 0
    
    @IBOutlet var nameCateHighestScoreLabel: UILabel!
    @IBOutlet var nameCateYourScoreLabel: UILabel!
    
    @IBOutlet weak var highestScoreLabel: UIButton!
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var userHighestScore: UIButton!
    
    @IBOutlet weak var htmlScoreLabel: UILabel!
    @IBOutlet weak var cssScoreLabel: UILabel!
    @IBOutlet weak var pythonScoreLabel: UILabel!
    @IBOutlet weak var javaScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIdUserAndIdCate()
        userHighestScore.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        highestScoreLabel.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculatePersonalityResult() {
        if(apptype=="new"){
            //            var frequencyOfAnswers: [AnimalType: Int] = [:]
            //            let responseTypes = responses.map { $0.type }
            let responseProps = responses.map { $0.prop }
            
            //Handle original results
            
            //Handle Score
            for prop in responseProps {
                if prop == 1 {
                    yourScore += 100
                    exactQuestionNum += 1
                }
            }
            
            //Hien thi so cau dung
            showNumberOfExactQuestion()
            
            //Lay iduser tu usernameGlobal -> Cap nhat diem theo iduser va idcate trong HighScore table
            updateScore()
            
            //Lay mang diem trong HighScore table voi cung category hien tai -> so sanh tim max roi cap nhat lai vao highscore column in Categorys table
            findMaxScoreAndUpdateToCategorys()
            
            //Lay diem tu cot highscore trong Categorys tableb -> gan cho bien highestScore
            getHighScoreFromCategorys()
            
            //Kiem tra highestScore va yourScore -> tim ra highestScore -> cap nhat vao cot highscore trong Categorys table
            compareYourScoreAndHighestScore()
            
            //Tim iduser co diem cao nhat trong Cate hien tai theo highestScore va idCate -> tim username tuong ung va gan vao result screen
            findHighestScoreUserWithHighestScoreAndIdCate()
            
            //Gan diem cho tung category cua user
            setScoreForEachCategory()
            
            highestScoreLabel.setTitle(String(highestScore), for: .normal)
            yourScoreLabel.text = String(yourScore)
            nameCateHighestScoreLabel.text = "Highest Score In " + categoryType
            nameCateYourScoreLabel.text = "Your Score In " + categoryType
            
        }else{
            return
        }
        
    }
    
    //Hien thi so cau dung
    func showNumberOfExactQuestion(){
        navigationItem.title = "Results: " + String(exactQuestionNum) + "/" + String(questionNum)
        questionNum = 0
        exactQuestionNum = 0
    }
    
    //Lay mang diem trong HighScore table voi cung category hien tai -> so sanh tim max roi cap nhat lai vao highscore column in Categorys table
    func findMaxScoreAndUpdateToCategorys(){
        var arrHighScoreRaw = [HighScore]()
        var arrScore = [Int]()
        var maxScore = 0
        
        //Lay mang diem
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestHighScoreArray = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
     
        do {
            let result = try managedContext.fetch(fetchRequestHighScoreArray)
            for data in result as! [NSManagedObject] {
                let score = data.value(forKey: "score") as! Int
                let iduser = data.value(forKey: "iduser") as! Int
                let idcategory = data.value(forKey: "idcategory") as! Int
                let objHighScore = HighScore(iduser: iduser, idcategory: idcategory, score: score)
                arrHighScoreRaw.append(objHighScore)
            }
        } catch {
            print("Get array score Failed")
        }
        
        //Filter diem trong category hien tai
        for item in arrHighScoreRaw {
            if item.idcategory == idCate {
                arrScore.append(item.score)
            }
        }
        
        //Tim max score
        for score in arrScore {
            if score > maxScore {
                maxScore = score
            }
        }
        print("Result Screen",idCate)
        //Cap nhat vao Categorys table
        let fetchRequestMaxScore:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Categorys")
        
        fetchRequestMaxScore.predicate = NSPredicate(format: "name = %@", categoryType)
        
        do {
            let result = try managedContext.fetch(fetchRequestMaxScore)
            for data in result as! [NSManagedObject] {
                data.setValue(maxScore, forKey: "highscore")
            }
            do {
                try managedContext.save()
                print("Update Categorys Score successful !!")
            } catch {
                print("Failed !! Cannot update data")
            }
            
        } catch {
            print("Failed")
        }
    }
    
    //Tim iduser co diem cao nhat trong Cate hien tai theo highestScore va idCate -> tim username tuong ung va gan vao result screen
    func findHighestScoreUserWithHighestScoreAndIdCate(){
        //Vars
        var iduserlocal = 0
        
        //General declares
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("qq",highestScore)
        print("qq",idCate)
        //Find iduser with highestscore and idcate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
        fetchRequest.predicate = NSPredicate(format: "score = %ld AND idcategory = %ld", highestScore, idCate)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                iduserlocal = data.value(forKey: "iduser") as! Int
            }
          
        } catch {
            print(" Find Iduser Failed")
        }
        
        print(iduserlocal)
        //Find user with iduser
        let fetchRequestUser:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequestUser.predicate = NSPredicate(format: "id = %ld", iduserlocal)
        do {
            let result = try managedContext.fetch(fetchRequestUser)
            for data in result as! [NSManagedObject] {
                let dbusername = data.value(forKey: "username") as! String
                userHighestScore.setTitle(dbusername, for: .normal)
            }
           
        } catch {
            print("Find User Failed")
        }
        
    }
    
    //Gan id cua User global va Category hien tai
    func setIdUserAndIdCate(){
        switch categoryType {
        case "html":
            idCate = 0
        case "css":
            idCate = 1
        case "python":
            idCate = 2
        case "java":
            idCate = 3
        default:
            idCate = 0
        }
        
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Khai bao fetchRequest
        let fetchRequestUser:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        //Khai bao Predicate
        fetchRequestUser.predicate = NSPredicate(format: "username = %@", usernameGlobal)
        //Lay IdUser
        do {
            let result = try managedContext.fetch(fetchRequestUser)
            for data in result as! [NSManagedObject] {
                idUser = data.value(forKey: "id") as! Int
            }
        } catch {
            print("Get IdUser Failed")
        }
        
        print(idUser)
        print(idCate)
    }
    
    //Lay diem tu cot highscore trong Categorys tableb -> gan cho bien highestScore
    func getHighScoreFromCategorys(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Categorys")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", categoryType)
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let score = data.value(forKey: "highscore") as! Int
                
                highestScore = score
                
            }
        } catch {
            print("Get HighScore From Categorys Failed")
        }
    }
    
    //Kiem tra highestScore va yourScore -> tim ra highestScore -> cap nhat vao cot highscore trong Categorys table
    func compareYourScoreAndHighestScore(){
        if yourScore > highestScore {
            highestScore = yourScore
            
            //Cap nhat highscore vao Categorys
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            //Lay context chua du lieu coredata
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Tao mot cai fetchRequest
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Categorys")
            
            fetchRequest.predicate = NSPredicate(format: "name = %@", categoryType)
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(highestScore, forKey: "highscore")
                
                do {
                    try managedContext.save()
                    print("Update successful !!")
                } catch {
                    print("Failed !! Cannot update data")
                }
                
            } catch {
                print("Failed")
            }
        }
    }
    
    //Lay iduser tu usernameGlobal -> Cap nhat diem theo iduser va idcate trong HighScore table
    func updateScore(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Khai bao fetchRequest
        let fetchRequestUser:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        let fetchRequestHighScore:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
        
        //Khai bao Predicate
        fetchRequestUser.predicate = NSPredicate(format: "username = %@", usernameGlobal)
        //Lay IdUser
        do {
            let result = try managedContext.fetch(fetchRequestUser)
            for data in result as! [NSManagedObject] {
                idUser = data.value(forKey: "id") as! Int
            }
        } catch {
            print("Get IdUser Failed")
        }
        
        
        //Predicate for multi format
        fetchRequestHighScore.predicate = NSPredicate(format: "iduser = %ld AND idcategory = %ld", idUser, idCate)
        
        
        //Cap nhat data vao bang HighScore
        do {
            let result = try managedContext.fetch(fetchRequestHighScore)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(yourScore, forKey: "score")
            
            do {
                try managedContext.save()
                print("Update successful !!")
            } catch {
                print("Failed !! Cannot update data")
            }
            
        } catch {
            print("Failed")
        }
        
        
        //Cap nhat diem cho user vao bang User
        //        do {
        //            let result = try managedContext.fetch(fetchRequestUser)
        //            let objectUpdate = result[0] as! NSManagedObject
        //            objectUpdate.setValue(yourScore, forKey: "highscore")
        //
        //            do {
        //                try managedContext.save()
        //                print("Update score successful !!")
        //            } catch {
        //                print("Failed !! Cannot update data")
        //            }
        //
        //        } catch {
        //            print("Failed")
        //        }
    }
    
    //Gan diem tung category cho result screen
    func setScoreForEachCategory(){
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("qq",highestScore)
        print("qq",idCate)
        //Find iduser with highestscore and idcate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "HighScores")
        fetchRequest.predicate = NSPredicate(format: "iduser = %ld", idUser)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let idcate = data.value(forKey: "idcategory") as! Int
                let score = data.value(forKey: "score") as! Int
                switch idcate {
                case 0:
                    htmlScoreLabel.text = String(score)
                case 1:
                    cssScoreLabel.text = String(score)
                case 2:
                    pythonScoreLabel.text = String(score)
                case 3:
                    javaScoreLabel.text = String(score)
                default:
                    return
                }
            }
            
        } catch {
            print(" Find Iduser Failed")
        }
    }
    
    //Xem diem nhung ko con duoc su dung nua
    func viewScore(){
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        //  fetchRequest.predicate = NSPredicate(format: "username = %@", usernameGlobal)
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! Int)
                print(data.value(forKey: "username") as! String)
                print(data.value(forKey: "password") as! String)
                print(data.value(forKey: "highscore") as! Int)
            }
        } catch {
            print("Failed")
        }
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
