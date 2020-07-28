//
//  QuestionData.swift
//  PersonalQuiz
//
//  Created by admin on 5/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


struct ParentCategory {
    var id: Int
    var name: String
    var categories: [Category]
}

struct Category {
    var id: Int
    var name: String
    var questions: [Question]
    var highscore: Int
    var idparent: Int
    var imgname: String
}

struct Question {
    var id: Int
    var text: String
    var type: String
    var answers: [Answer]
    var idcategory: Int
}

struct Answer {
    var text: String
    var prop: Int
    var idquestion: Int
}

struct HighScore {
    var iduser: Int
    var idcategory: Int
    var score: Int
}



enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"

    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
    
    var resultlabel: String {
        switch self {
        case .dog:
            return "You have done like a junior developer. Your skills're really good and I think you can create a lot of amazing websites in the future."
        case .cat:
            return "My Lord! You're a perfect guy. The future's waiting for you with many oppotunities openning!!"
        case .rabbit:
            return "Are you working for Google!! Why i said that? Because You're so intelligent. Your algorithm mindset couldn't describe by any words. "
        case .turtle:
            return "After finishing this quiz!! I wish you can work for me. In my opinion, absolutely You can earn alot of money for my company. Do you agree!!"
        }
    }
}

var parentCategories: [ParentCategory] = [
    ParentCategory(id: 1, name: "mobile", categories: [
        Category(id: 3, name: "java", questions: [], highscore: 300, idparent: 1, imgname: "java"),
        Category(id: 2, name: "python", questions: [], highscore: 300, idparent: 1, imgname: "python")]),
    ParentCategory(id: 0, name: "web", categories: [
        Category(id: 1, name: "css", questions: [], highscore: 100, idparent: 0, imgname: "css"),
        Category(id: 0, name: "html", questions: [], highscore: 1000, idparent: 0, imgname: "html")])
]

















//MARK: == Lib Data Question ==


var questionshtml: [Question] = [
    Question(id: 0,
             text: "Thẻ HTML nào tạo ra một checkbox?",
             type: "single",
             answers: [
                Answer(text: "<input type = \"checkbox\">", prop: 1, idquestion: 0),
                Answer(text: "<input type = \"check\">", prop: 0, idquestion: 0),
                Answer(text: "<checkbox>", prop: 0, idquestion: 0),
                Answer(text: "<check>", prop: 0, idquestion: 0)
        ], idcategory: 0

    ),
    Question(id: 1,
             text: "Chọn phần tử HTML được dùng nhấn mạnh nội dung văn bản?",
             type: "single",
             answers: [
                Answer(text: "<em>", prop: 1, idquestion: 1),
                Answer(text: "<b>", prop: 0, idquestion: 1),
                Answer(text: "<i>", prop: 0, idquestion: 1),
                Answer(text: "<italic>", prop: 0, idquestion: 1)
        ], idcategory: 0
    ),
    Question(id: 2,
             text: "Đoạn HTML nào là đúng để tạo một liên kết?",
             type: "single",
             answers: [
                Answer(text: "<a href=\"http://www.baravn.com\">Tìm ở đây</a>", prop: 1, idquestion: 2),
                Answer(text: "<a>http://www.baravn.com</a>", prop: 0, idquestion: 2),
                Answer(text:"<a url=\"http://www.baravn.com\">Tìm ở đây</a>",prop: 0,idquestion: 2),
                Answer(text: "<a name=\"http://www.baravn.com\">Tìm ở đây</a>", prop: 0, idquestion: 2)
        ], idcategory: 0
    ),
    Question(id: 3,
             text: "Chọn phần tử HTML nào đúng nhất cho định dạng tiêu đề lớn nhất?",
             type: "single",
             answers: [
                Answer(text: "<h1>", prop: 1, idquestion: 3),
                Answer(text: "<heading>", prop: 0, idquestion: 3),
                Answer(text:"<head>",prop: 0,idquestion: 3),
                Answer(text: "<h6>", prop: 0, idquestion: 3)
        ], idcategory: 0
    ),
    Question(id: 4,
             text: "Đâu là mã HTML thực hiện căn lề trái cho nội dung 1 ô trong bảng?",
             type: "single",
             answers: [
                Answer(text: "<td align=\"left\">", prop: 1, idquestion: 4),
                Answer(text: "<tdleft>", prop: 0, idquestion: 4),
                Answer(text:"<td valign=\"left\">",prop: 0,idquestion: 4),
                Answer(text: "<td leftalign>", prop: 0, idquestion: 4)
        ], idcategory: 0
    ),
    Question(id: 5,
             text: "Which html 5 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 5),
                Answer(text: "Fish", prop: 0, idquestion: 5),
                Answer(text:"Carrots",prop: 0,idquestion: 5),
                Answer(text: "Corn", prop: 0, idquestion: 5)
        ], idcategory: 0
    ),
    Question(id: 6,
             text: "Which html 6 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 6),
                Answer(text: "Fish", prop: 0, idquestion: 6),
                Answer(text:"Carrots",prop: 0,idquestion: 6),
                Answer(text: "Corn", prop: 0, idquestion: 6)
        ], idcategory: 0
    ),
    Question(id: 7,
             text: "Which html 7 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 7),
                Answer(text: "Fish", prop: 0, idquestion: 7),
                Answer(text:"Carrots",prop: 0,idquestion: 7),
                Answer(text: "Corn", prop: 0, idquestion: 7)
        ], idcategory: 0
    ),
    Question(id: 8,
             text: "Which html 8 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 8),
                Answer(text: "Fish", prop: 0, idquestion: 8),
                Answer(text:"Carrots",prop: 0,idquestion: 8),
                Answer(text: "Corn", prop: 0, idquestion: 8)
        ], idcategory: 0
    ),
    Question(id: 9,
             text: "Which html 9 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 9),
                Answer(text: "Fish", prop: 0, idquestion: 9),
                Answer(text:"Carrots",prop: 0,idquestion: 9),
                Answer(text: "Corn", prop: 0, idquestion: 9)
        ], idcategory: 0
    ),
]

var questionscss: [Question] = [
    Question(id: 10,
             text: "CSS là viết tắt của?",
             type: "single",
             answers: [
                Answer(text: "Cascading Style Sheets", prop: 1, idquestion: 10),
                Answer(text: "Creative Style Sheets", prop: 0, idquestion: 10),
                Answer(text:"Computer Style Sheets",prop: 0,idquestion: 10),
                Answer(text: "Coloful Style Sheets", prop: 0, idquestion: 10)
        ], idcategory: 1
    ),
    Question(id: 11, text: "Muốn liên kết file HTML với file định nghĩa CSS ta dùng dòng nào sau đây?",
             type: "single",
             answers: [
                Answer(text: "link rel=\"stylesheet\" type=\"text/css\" href=\"mystyle.css\">", prop: 1, idquestion: 11),
                Answer(text: "<style src =\"mystyle.css\">", prop: 0, idquestion: 11),
                Answer(text:"<stylesheet>mystyle.css</stylesheet>",prop: 0,idquestion: 11),
                Answer(text: "Tất cả đều đúng", prop: 0, idquestion: 11)
        ], idcategory: 1
    ),
    Question(id: 12,
             text: "Thuộc tính nào định nghĩa CSS ngay trong 1 tag?",
             type: "single",
             answers: [
                Answer(text: "class", prop: 1, idquestion: 12),
                Answer(text: "font", prop: 0, idquestion: 12),
                Answer(text:"style",prop: 0,idquestion: 12),
                Answer(text: "styles", prop: 0, idquestion: 12)
        ], idcategory: 1
    ),
]

var questionspython: [Question] = [
    Question(id: 13,
             text: "PYTHON là gì?",
             type: "single",
             answers: [
                Answer(text: "PYTHON Language", prop: 1, idquestion: 13),
                Answer(text: "Fish", prop: 0, idquestion: 13),
                Answer(text:"Carrots",prop: 0,idquestion: 13),
                Answer(text: "Corn", prop: 0, idquestion: 13)
        ], idcategory: 2
    ),
    Question(id: 14,
             text: "Which python 1 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 14),
                Answer(text: "Fish", prop: 0, idquestion: 14),
                Answer(text:"Carrots",prop: 0,idquestion: 14),
                Answer(text: "Corn", prop: 0, idquestion: 14)
        ], idcategory: 2
    ),
    Question(id: 15,
             text: "Which python 2 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 15),
                Answer(text: "Fish", prop: 0, idquestion: 15),
                Answer(text:"Carrots",prop: 0,idquestion: 15),
                Answer(text: "Corn", prop: 0, idquestion: 15)
        ], idcategory: 2
    ),
]

var questionsjava: [Question] = [
    Question(id: 16, text: "JAVA là gì?",
             type: "single",
             answers: [
                Answer(text: "JAVA Language", prop: 1, idquestion: 16),
                Answer(text: "Fish", prop: 0, idquestion: 16),
                Answer(text:"Carrots",prop: 0,idquestion: 16),
                Answer(text: "Corn", prop: 0, idquestion: 16)
        ], idcategory: 3
    ),
    Question(id: 17,
             text: "Which java 1 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 17),
                Answer(text: "Fish", prop: 0, idquestion: 17),
                Answer(text:"Carrots",prop: 0,idquestion: 17),
                Answer(text: "Corn", prop: 0, idquestion: 17)
        ], idcategory: 3
    ),
    Question(id: 18, text: "Which java 2 do you like the most?",
             type: "single",
             answers: [
                Answer(text: "True", prop: 1, idquestion: 18),
                Answer(text: "Fish", prop: 0, idquestion: 18),
                Answer(text:"Carrots",prop: 0,idquestion: 18),
                Answer(text: "Corn", prop: 0, idquestion: 18)
        ], idcategory: 3
    ),
]


var categories: [Category] = [
    Category(id:0,
             name: "html",
             questions: [],
             highscore: 0, idparent: 0, imgname: "html"
    ),
    Category(id:1,
             name: "css",
             questions: [],
             highscore: 0, idparent: 0, imgname: "css"
    ),
    Category(id:2,
             name: "python",
             questions: [],
             highscore: 0, idparent: 1, imgname: "python"
    ),
    Category(id:3,
             name: "java",
             questions: [],
             highscore: 0, idparent: 1, imgname: "java"
    )
]

