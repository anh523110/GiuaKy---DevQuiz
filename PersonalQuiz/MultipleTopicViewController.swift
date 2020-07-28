//
//  MultipleTopicViewController.swift
//  PersonalQuiz
//
//  Created by admin on 6/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MultipleTopicViewController: UIViewController {
    
    @IBOutlet var htmlButton: UIButton!
    @IBOutlet var cssButton: UIButton!
    @IBOutlet var pythonButton: UIButton!
    @IBOutlet var javaButton: UIButton!
    
    var color1 = UIColor(red: 255/255, green: 153/255, blue: 255/255, alpha: 0.7)
    var color2 = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
    var color3 = UIColor(red: 255/255, green: 204/255, blue: 153/255, alpha: 1)
    var color4 = UIColor(red: 153/255, green: 255/255, blue: 102/255, alpha: 0.7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(usernameGlobal)
        designButtonUI(btn: htmlButton,bgcl: color1)
        designButtonUI(btn: cssButton, bgcl: color2)
        designButtonUI(btn: pythonButton, bgcl: color3)
        designButtonUI(btn: javaButton, bgcl: color4)
        // Do any additional setup after loading the view.
    }
    
    func designButtonUI(btn: UIButton,bgcl: UIColor){
        btn.backgroundColor = bgcl
        //btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        //Shadow and Radius
        btn.layer.shadowColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 7.0, height: 7.0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 0.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 10.0
        btn.layer.borderColor = UIColor.cyan.cgColor
        btn.layer.borderWidth = 1
    }
    
    @IBAction func CategoryButtonPressed(_ sender: UIButton) {
        switch sender {
        case htmlButton:
            categoryType="html"
        case cssButton:
            categoryType="css"
        case pythonButton:
            categoryType="python"
        case javaButton:
            categoryType="java"
        default:
            break
        }
        performSegue(withIdentifier: "testSegue", sender: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
