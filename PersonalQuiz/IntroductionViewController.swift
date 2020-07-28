//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by admin on 5/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var btnBeginQuiz: UIButton!
    @IBOutlet weak var btnChooseTopic: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designButtonUI(btn: btnBeginQuiz)
        designButtonUI(btn: btnChooseTopic)
        designButtonUI(btn: btnSignOut)
        prepairData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//       getDataFromParentCategorysAndCategorysTable()
    }
    
    //Coredata actions
    //Lay du lieu tu hai bang va gan cho bien toan cuc arrDataListTopic
    func getDataFromParentCategorysAndCategorysTable(){
        //Vars
        var arrCategory: [Category] = []
        var arrCategoryWeb: [Category] = []
        var arrCategoryMobile: [Category] = []
        var arrParentCategory: [ParentCategory] = []
        let emptyArrQuestion: [Question] = []
        var userid: Int!
        
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
            userid = objResult.value(forKey: "id") as! Int
            
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

    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: == Anti Cheat ==
            checkDataquiz()
    }
    
    
    
    @IBAction func unwindToQuizIntroduction(segue:
        UIStoryboardSegue) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func designButtonUI(btn: UIButton){
        btn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        //Shadow and Radius
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 0.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 10.0
        btn.layer.borderColor = UIColor.cyan.cgColor
        btn.layer.borderWidth = 1
    }
    
    func prepairData(){
        var arrCategory: [Category] = []
        var arrQuestion: [Question] = []
        var arrQuestionhtml: [Question] = []
        var arrQuestioncss: [Question] = []
        var arrQuestionpython: [Question] = []
        var arrQuestionjava: [Question] = []
        var arrAnswer: [Answer] = []
        
        
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequestCategory = NSFetchRequest<NSFetchRequestResult>(entityName: "Categorys")
        let fetchRequestQuestion = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        let fetchRequestAnswer = NSFetchRequest<NSFetchRequestResult>(entityName: "Answers")
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            
            //Answers
            let resultAnswer = try managedContext.fetch(fetchRequestAnswer)
            for data in resultAnswer as! [NSManagedObject] {
                let objAnswer = Answer(text: (data.value(forKey: "text") as! String), prop: (data.value(forKey: "prop") as! Int), idquestion: (data.value(forKey: "idquestion") as! Int))
                arrAnswer.append(objAnswer)
            }
            arrAnswer = arrAnswer.sorted(by: { $0.idquestion < $1.idquestion })
            
            //Questions
            let resultQues = try managedContext.fetch(fetchRequestQuestion)
            for data in resultQues as! [NSManagedObject] {
                let idQues = data.value(forKey: "id") as! Int
                let textQues = data.value(forKey: "text") as! String
                let typeQues = data.value(forKey: "type") as! String
                let idcategoryQues = data.value(forKey: "idcategory") as! Int
                var arrAns: [Answer] = []
                for answer in arrAnswer {
                    if idQues == answer.idquestion {
                        arrAns.append(answer)
                    }
                }
                
                let objQuestion = Question(id: idQues, text: textQues, type: typeQues, answers: arrAns, idcategory: idcategoryQues)
                arrQuestion.append(objQuestion)
            }
            arrQuestion = arrQuestion.sorted(by: { $0.id < $1.id })
            
            for question in arrQuestion {
                if question.idcategory == 0 {
                    arrQuestionhtml.append(question)
                } else {
                    if question.idcategory == 1 {
                        arrQuestioncss.append(question)
                    } else {
                        if question.idcategory == 2 {
                            arrQuestionpython.append(question)
                        } else {
                            if question.idcategory == 3 {
                                arrQuestionjava.append(question)
                            } else {
                                return
                            }
                        }
                    }
                }
                
            }
            
            //Cates
            let resultCate = try managedContext.fetch(fetchRequestCategory)
            for data in resultCate as! [NSManagedObject] {
//                let idCate = data.value(forKey: "id") as! Int
//                var question: [Question] = []
//                if idCate == 0 {
//                    question = arrQuestionhtml
//                } else {
//                    if idCate == 1 {
//                        question = arrQuestioncss
//                    } else {
//                        if idCate == 2 {
//                            question = arrQuestionpython
//                        } else {
//                            question = arrQuestionjava
//                        }
//                    }
//                }
                let objCate = Category(id: (data.value(forKey: "id") as! Int), name: (data.value(forKey: "name") as! String), questions: [], highscore: 0, idparent: (data.value(forKey: "idparent") as! Int), imgname: (data.value(forKey: "imgname") as! String))
                arrCategory.append(objCate)
            }
            arrCategory = arrCategory.sorted(by: { $0.id < $1.id })

        } catch {
            print("Failed")
        }
        
        categoriesG = arrCategory
        questionshtmlG = arrQuestionhtml
        questionscssG = arrQuestioncss
        questionspythonG = arrQuestionpython
        questionsjavaG = arrQuestionjava
        
        print(arrCategory)
    }
    
    func checkDataquiz(){
        print("checkDataquiz")
        //vars
        var countCheckCategory = 0
        var countCheckQuestion = 0
        var countCheckAnswer = 0
        
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Tao mot cai fetchRequest
        let fetchRequestCategory = NSFetchRequest<NSFetchRequestResult>(entityName: "Categorys")
        let fetchRequestQuestion = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        let fetchRequestAnswer = NSFetchRequest<NSFetchRequestResult>(entityName: "Answers")
        
        //Thuc hien fetch cai fetchRequest vua tao
        do {
            //Cates
            let resultCate = try managedContext.fetch(fetchRequestCategory)
            for _ in resultCate as! [NSManagedObject] {
                countCheckCategory += 1
            }
            //Questions
            let resultQues = try managedContext.fetch(fetchRequestQuestion)
            for _ in resultQues as! [NSManagedObject] {
                countCheckQuestion += 1
            }
            //Answers
            let resultAnswer = try managedContext.fetch(fetchRequestAnswer)
            for _ in resultAnswer as! [NSManagedObject] {
                countCheckAnswer += 1
            }
        } catch {
            print("Failed")
        }
        
        if countCheckCategory == 0 {
           createCategory()
        }
        
        if countCheckQuestion == 0 {
           createQuestion()
        }
        
        if countCheckAnswer == 0 {
           createAnswer()
        }
    }
    
    //--------------------------------------------------------------
   
    func createCategory(){
        print("createCategory")
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext

        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let categEntity = NSEntityDescription.entity(forEntityName: "Categorys", in: managedContext)!

        //Insert du lieu
        for (i,category) in categories.enumerated() {
            let categ = NSManagedObject(entity: categEntity, insertInto: managedContext)
            categ.setValue(i, forKey: "id")
            categ.setValue(category.name, forKey: "name")
            categ.setValue(0, forKey: "highscore")
            categ.setValue(category.name, forKey: "imgname")
            categ.setValue(0, forKey: "idparent")
        }


        //Kiem tra
        do {
            try managedContext.save()
            print("Category data saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    func createQuestion(){
        print("createQuestion")
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext

        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let quesEntity = NSEntityDescription.entity(forEntityName: "Questions", in: managedContext)!

        //Insert du lieu
        for (_,question) in questionshtml.enumerated() {
            let ques = NSManagedObject(entity: quesEntity, insertInto: managedContext)
            ques.setValue(question.id, forKey: "id")
            ques.setValue(question.text, forKey: "text")
            ques.setValue(question.type, forKey: "type")
            ques.setValue(question.idcategory, forKey: "idcategory")
        }

        for (_,question) in questionscss.enumerated() {
            let ques = NSManagedObject(entity: quesEntity, insertInto: managedContext)
            ques.setValue(question.id, forKey: "id")
            ques.setValue(question.text, forKey: "text")
            ques.setValue(question.type, forKey: "type")
            ques.setValue(question.idcategory, forKey: "idcategory")
        }

        for (_,question) in questionspython.enumerated() {
            let ques = NSManagedObject(entity: quesEntity, insertInto: managedContext)
            ques.setValue(question.id, forKey: "id")
            ques.setValue(question.text, forKey: "text")
            ques.setValue(question.type, forKey: "type")
            ques.setValue(question.idcategory, forKey: "idcategory")
        }

        for (_,question) in questionsjava.enumerated() {
            let ques = NSManagedObject(entity: quesEntity, insertInto: managedContext)
            ques.setValue(question.id, forKey: "id")
            ques.setValue(question.text, forKey: "text")
            ques.setValue(question.type, forKey: "type")
            ques.setValue(question.idcategory, forKey: "idcategory")
        }


        //Kiem tra
        do {
            try managedContext.save()
            print("Question data saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    func createAnswer(){
        print("createAnswer")
        //Khai bao bien appDelegate theo kieu AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        //Lay context chua du lieu coredata
        let managedContext = appDelegate.persistentContainer.viewContext

        //Tao moi mot entity, dung de tuong tac voi bang(Entity User) trong csdl
        // Dau cham thang cuoi dong code de chac chan rang co User Entity duoi database
        let ansEntity = NSEntityDescription.entity(forEntityName: "Answers", in: managedContext)!

        //Insert du lieu
        for (_,question) in questionshtml.enumerated() {
            for (_, answer) in question.answers.enumerated() {
                let ans = NSManagedObject(entity: ansEntity, insertInto: managedContext)
                ans.setValue(answer.text, forKey: "text")
                ans.setValue(answer.prop, forKey: "prop")
                ans.setValue(answer.idquestion, forKey: "idquestion")
            }
        }

        for (_,question) in questionscss.enumerated() {
            for (_, answer) in question.answers.enumerated() {
                let ans = NSManagedObject(entity: ansEntity, insertInto: managedContext)
                ans.setValue(answer.text, forKey: "text")
                ans.setValue(answer.prop, forKey: "prop")
                ans.setValue(answer.idquestion, forKey: "idquestion")
            }
        }

        for (_,question) in questionspython.enumerated() {
            for (_, answer) in question.answers.enumerated() {
                let ans = NSManagedObject(entity: ansEntity, insertInto: managedContext)
                ans.setValue(answer.text, forKey: "text")
                ans.setValue(answer.prop, forKey: "prop")
                ans.setValue(answer.idquestion, forKey: "idquestion")
            }
        }

        for (_,question) in questionsjava.enumerated() {
            for (_, answer) in question.answers.enumerated() {
                let ans = NSManagedObject(entity: ansEntity, insertInto: managedContext)
                ans.setValue(answer.text, forKey: "text")
                ans.setValue(answer.prop, forKey: "prop")
                ans.setValue(answer.idquestion, forKey: "idquestion")
            }
        }


        //Kiem tra
        do {
            try managedContext.save()
            print("Answer data saved")
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    //---- No Data Standart ---------------------------------------------
    
    
    
}

