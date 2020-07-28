//
//  TopicInfoViewController.swift
//  PersonalQuiz
//
//  Created by admin on 7/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
var categoryGB: Category?

class TopicInfoViewController: UIViewController{
    var strDes: String?
    
    @IBOutlet weak var lblTopicName: UILabel!
    @IBOutlet weak var imgViewTopic: UIImageView!
    @IBOutlet weak var lblDescriptionTopic: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTopicName.text = categoryGB?.name
        imgViewTopic.image = UIImage(named: (categoryGB?.imgname)!)
        if categoryGB?.name == "html" {
            strDes = "Here is description about html"
        } else {
            if categoryGB?.name == "css" {
                strDes = "Here is description about css"
            } else {
                if categoryGB?.name == "python" {
                    strDes = "Here is description about python"
                } else {
                    strDes = "Here is description about java"
                }
            }
        }
        lblDescriptionTopic.text = strDes
        designButtonUI(btn: btnStart)
        designButtonUI(btn: btnCancel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        categoryType = categoryGB?.name
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
