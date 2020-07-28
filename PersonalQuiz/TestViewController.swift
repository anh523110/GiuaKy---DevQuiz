//
//  TestViewController.swift
//  PersonalQuiz
//
//  Created by admin on 6/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

var  categoryType: String!
var categoriesG: [Category] = []
var questionshtmlG: [Question] = []
var questionscssG: [Question] = []
var questionspythonG: [Question] = []
var questionsjavaG: [Question] = []

class TestViewController: UIViewController {
    
    var categoryIndex = 0
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    @IBOutlet weak var lbTest: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    
    
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet weak var labelTimer: UILabel!
    weak var timer: Timer?
    weak var timerVisible: Timer?
    var time = 0
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesG[0].questions = generateRandomQuestion(arrQuestions: questionshtmlG)
        categoriesG[1].questions = generateRandomQuestion(arrQuestions: questionscssG)
        categoriesG[2].questions = generateRandomQuestion(arrQuestions: questionspythonG)
        categoriesG[3].questions = generateRandomQuestion(arrQuestions: questionsjavaG)
        
        for (indexc, category) in categoriesG.enumerated() {
            for (indexq, question) in category.questions.enumerated(){
               categoriesG[indexc].questions[indexq].answers = generateRandomAnswer(arrAnswers: question.answers)
            }
        }
        
        test()
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "MultipleTopicResultSegue" {
            let resultsViewController = segue.destination as!
            ResultsViewController
            resultsViewController.responses = answersChosen
            resultsViewController.apptype="new"
        }
    }
    
    func test(){
        lbTest.text = categoryType
    }
    
    func timeBegin(){
        time = 0
        labelTimer.text = String(time)
    }
    
    func startTimer(){
        timerVisible?.invalidate()
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(TestViewController.outOfTime), userInfo: nil, repeats: false)
        timerVisible = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TestViewController.setTimeValue), userInfo: nil, repeats: true)
    }
    
    @objc func setTimeValue() {
        if time<6 {
            time += 1
            labelTimer.text = String(time)
        }else{
                timerVisible?.invalidate()
        }
    }
    
    @objc func outOfTime() {
        missAnswers()
        stopTimer()
        nextQuestion()
        
    }
    
    func stopTimer(){
        timer?.invalidate()
        timerVisible?.invalidate()
    }
    
    func updateSingleStack(using answers: [Answer]) {
        timeBegin()
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
        startTimer()
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        timeBegin()
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        startTimer()
    }

    func updateRangedStack(using answers: [Answer]) {
        timeBegin()
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
        startTimer()
    }
    
    func setCategoryIndex(){
        switch categoryType {
        case "html":
            categoryIndex=0
        case "css":
            categoryIndex=1
        case "python":
            categoryIndex=2
        case "java":
            categoryIndex=3
        default:
            break
        }
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        setCategoryIndex()
        
        let currentQuestion = categoriesG[categoryIndex].questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) /
            Float(categoriesG[categoryIndex].questions.count)
        
        navigationItem.title = "Question Number \(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated:true)
        
        switch currentQuestion.type {
        case "single":
            updateSingleStack(using: currentAnswers)
        case "multiple":
            updateMultipleStack(using: currentAnswers)
        case "ranged":
            updateRangedStack(using: currentAnswers)
        default:
            return
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = categoriesG[categoryIndex].questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        stopTimer()
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = categoriesG[categoryIndex].questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        stopTimer()
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = categoriesG[categoryIndex].questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        stopTimer()
        nextQuestion()
    }


    func nextQuestion() {
         questionIndex += 1
        
        if questionIndex < categoriesG[categoryIndex].questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "MultipleTopicResultSegue", sender: nil)
            questionNum = questionIndex
        }
    }
    
    
    func generateRandomQuestion(arrQuestions: Array<Question>) -> Array<Question> {
        var arrInts = [Int]()
        for (index,_) in arrQuestions.enumerated(){
            arrInts.append(index)
        }
        
        var arrRandom = [Int]()
        var arrRandomQuestion = [Question]()
        
        while arrRandom.count < arrInts.count {
            let randomIndex = Int(arc4random_uniform(UInt32(arrInts.count)))
            let myItem = arrInts[randomIndex]
            var count = 0
            for item in arrRandom {
                if(item == myItem){
                    count += 1
                }
            }
            
            if(count == 0){
                arrRandom.append(myItem)
            }
        }
       
        for item in arrRandom {
            arrRandomQuestion.append(arrQuestions[item])
        }
        
        return arrRandomQuestion
    }
    
    func missAnswers(){
        answersChosen.append(Answer(text: "default wrong answer", prop: 0, idquestion: 0))
    }
    
    func generateRandomAnswer(arrAnswers: Array<Answer>) -> Array<Answer> {
        let arrInts = [0,1,2,3]
        var arrRandom = [Int]()
        var arrRandomQuestion = [Answer]()
        
        while arrRandom.count < arrInts.count {
            let randomIndex = Int(arc4random_uniform(UInt32(arrInts.count)))
            let myItem = arrInts[randomIndex]
            var count = 0
            for item in arrRandom {
                if(item == myItem){
                    count += 1
                }
            }
            
            if(count == 0){
                arrRandom.append(myItem)
            }
        }
        
        for item in arrRandom {
            arrRandomQuestion.append(arrAnswers[item])
        }
        
        return arrRandomQuestion
    }

//    struct Question {
//        var id: Int
//        var text: String
//        var type: String
//        var answers: [Answer]
//        var idcategory: Int
//    }
//
//    struct Answer {
//        var text: String
//        var prop: Int
//        var idquestion: Int
//    }
    
    //------------------------------------------------------------
    
//    var questionshtml: [Question] = [
//        Question(id: 0,
//                 text: "Which html do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 0),
//                    Answer(text: "Fish", prop: 0, idquestion: 0),
//                    Answer(text: "Carrots", prop: 0, idquestion: 0),
//                    Answer(text: "Corn", prop: 0, idquestion: 0)
//            ], idcategory: 0
//
//        ),
//        Question(id: 1,
//                 text: "Which html 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 1),
//                    Answer(text: "Fish", prop: 0, idquestion: 1),
//                    Answer(text: "Carrots", prop: 0, idquestion: 1),
//                    Answer(text: "Corn", prop: 0, idquestion: 1)
//            ], idcategory: 0
//        ),
//        Question(id: 2,
//                 text: "Which html 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 2),
//                    Answer(text: "Fish", prop: 0, idquestion: 2),
//                    Answer(text:"Carrots",prop: 0,idquestion: 2),
//                    Answer(text: "Corn", prop: 0, idquestion: 2)
//            ], idcategory: 0
//        ),
//        Question(id: 3,
//                 text: "Which html do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 3),
//                    Answer(text: "Fish", prop: 0, idquestion: 3),
//                    Answer(text:"Carrots",prop: 0,idquestion: 3),
//                    Answer(text: "Corn", prop: 0, idquestion: 3)
//            ], idcategory: 0
//        ),
//        Question(id: 4,
//                 text: "Which html 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 4),
//                    Answer(text: "Fish", prop: 0, idquestion: 4),
//                    Answer(text:"Carrots",prop: 0,idquestion: 4),
//                    Answer(text: "Corn", prop: 0, idquestion: 4)
//            ], idcategory: 0
//        ),
//        Question(id: 5,
//                 text: "Which html 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 5),
//                    Answer(text: "Fish", prop: 0, idquestion: 5),
//                    Answer(text:"Carrots",prop: 0,idquestion: 5),
//                    Answer(text: "Corn", prop: 0, idquestion: 5)
//            ], idcategory: 0
//        ),
//        Question(id: 6,
//                 text: "Which html do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 6),
//                    Answer(text: "Fish", prop: 0, idquestion: 6),
//                    Answer(text:"Carrots",prop: 0,idquestion: 6),
//                    Answer(text: "Corn", prop: 0, idquestion: 6)
//            ], idcategory: 0
//        ),
//        Question(id: 7,
//                 text: "Which html 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 7),
//                    Answer(text: "Fish", prop: 0, idquestion: 7),
//                    Answer(text:"Carrots",prop: 0,idquestion: 7),
//                    Answer(text: "Corn", prop: 0, idquestion: 7)
//            ], idcategory: 0
//        ),
//        Question(id: 8,
//                 text: "Which html 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 8),
//                    Answer(text: "Fish", prop: 0, idquestion: 8),
//                    Answer(text:"Carrots",prop: 0,idquestion: 8),
//                    Answer(text: "Corn", prop: 0, idquestion: 8)
//            ], idcategory: 0
//        ),
//        Question(id: 9,
//                 text: "Which html do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 9),
//                    Answer(text: "Fish", prop: 0, idquestion: 9),
//                    Answer(text:"Carrots",prop: 0,idquestion: 9),
//                    Answer(text: "Corn", prop: 0, idquestion: 9)
//            ], idcategory: 0
//        ),
//    ]
//
//    var questionscss: [Question] = [
//        Question(id: 10,
//                 text: "Which css do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 10),
//                    Answer(text: "Fish", prop: 0, idquestion: 10),
//                    Answer(text:"Carrots",prop: 0,idquestion: 10),
//                    Answer(text: "Corn", prop: 0, idquestion: 10)
//            ], idcategory: 1
//        ),
//        Question(id: 11, text: "Which css 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 11),
//                    Answer(text: "Fish", prop: 0, idquestion: 11),
//                    Answer(text:"Carrots",prop: 0,idquestion: 11),
//                    Answer(text: "Corn", prop: 0, idquestion: 11)
//            ], idcategory: 1
//        ),
//        Question(id: 12,
//                 text: "Which css 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 12),
//                    Answer(text: "Fish", prop: 0, idquestion: 12),
//                    Answer(text:"Carrots",prop: 0,idquestion: 12),
//                    Answer(text: "Corn", prop: 0, idquestion: 12)
//            ], idcategory: 1
//        ),
//    ]
//
//    var questionspython: [Question] = [
//        Question(id: 13,
//                 text: "Which python do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 13),
//                    Answer(text: "Fish", prop: 0, idquestion: 13),
//                    Answer(text:"Carrots",prop: 0,idquestion: 13),
//                    Answer(text: "Corn", prop: 0, idquestion: 13)
//            ], idcategory: 2
//        ),
//        Question(id: 14,
//                 text: "Which python 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 14),
//                    Answer(text: "Fish", prop: 0, idquestion: 14),
//                    Answer(text:"Carrots",prop: 0,idquestion: 14),
//                    Answer(text: "Corn", prop: 0, idquestion: 14)
//            ], idcategory: 2
//        ),
//        Question(id: 15,
//                 text: "Which python 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 15),
//                    Answer(text: "Fish", prop: 0, idquestion: 15),
//                    Answer(text:"Carrots",prop: 0,idquestion: 15),
//                    Answer(text: "Corn", prop: 0, idquestion: 15)
//            ], idcategory: 2
//        ),
//    ]
//
//    var questionsjava: [Question] = [
//        Question(id: 16, text: "Which java do you like the most?",
//                 type: "single",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 16),
//                    Answer(text: "Fish", prop: 0, idquestion: 16),
//                    Answer(text:"Carrots",prop: 0,idquestion: 16),
//                    Answer(text: "Corn", prop: 0, idquestion: 16)
//            ], idcategory: 3
//        ),
//        Question(id: 17,
//                 text: "Which java 1 do you like the most?",
//                 type: "multiple",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 17),
//                    Answer(text: "Fish", prop: 0, idquestion: 17),
//                    Answer(text:"Carrots",prop: 0,idquestion: 17),
//                    Answer(text: "Corn", prop: 0, idquestion: 17)
//            ], idcategory: 3
//        ),
//        Question(id: 18, text: "Which java 2 do you like the most?",
//                 type: "ranged",
//                 answers: [
//                    Answer(text: "True", prop: 1, idquestion: 18),
//                    Answer(text: "Fish", prop: 0, idquestion: 18),
//                    Answer(text:"Carrots",prop: 0,idquestion: 18),
//                    Answer(text: "Corn", prop: 0, idquestion: 18)
//            ], idcategory: 3
//        ),
//    ]
//
//
//    var categories: [Category] = [
//        Category(id:0,
//                 name: "html",
//                 questions: []
//        ),
//        Category(id:1,
//                 name: "css",
//                 questions: []
//        ),
//        Category(id:2,
//                 name: "python",
//                 questions: []
//        ),
//        Category(id:3,
//                 name: "java",
//                 questions: []
//        )
//    ]
    
}




