//
//  QuestionViewController.swift
//  PersonalQuiz
//
//  Created by admin on 5/27/20.
//  Copyright © 2020 admin. All rights reserved.
//
// MARK: Not Used Anymore!!

import UIKit

class QuestionViewController: UIViewController {
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as!
            ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
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
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
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
        
        nextQuestion()
        
      }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    
        
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) /
            Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
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
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
        
        
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
      }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    var questions: [Question] = [
        Question(id: 0, text: "Which food do you like the most?",
                 type: "single",
                 answers: [
                    Answer(text: "Steak",prop: 1, idquestion: 0),
                    Answer(text: "Fish", prop: 0, idquestion: 0),
                    Answer(text: "Carrots", prop: 0, idquestion: 0),
                    Answer(text: "Corn", prop: 0, idquestion: 0)
            ], idcategory: 0),
        Question(id: 1,
                 text: "Which activities do you enjoy?",
                 type: "single",
                 answers: [
                    Answer(text: "Steak",prop: 1, idquestion: 1),
                    Answer(text: "Fish", prop: 0, idquestion: 1),
                    Answer(text: "Carrots", prop: 0, idquestion: 1),
                    Answer(text: "Corn", prop: 0, idquestion: 1)
            ], idcategory: 0),
        
        Question(id: 2,
                 text: "How much do you enjoy car rides?",
                 type: "single",
                 answers: [
                    Answer(text: "Steak",prop: 1, idquestion: 1),
                    Answer(text: "Fish", prop: 0, idquestion: 1),
                    Answer(text: "Carrots", prop: 0, idquestion: 1),
                    Answer(text: "Corn", prop: 0, idquestion: 1)
            ], idcategory: 0)
    ]
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
