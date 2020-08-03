//
//  QnaViewController.swift
//  question&answer
//
//  Created by JillOU on 2020/8/2.
//  Copyright © 2020 Jillou. All rights reserved.
//

import UIKit

class QnaViewController: UIViewController {
    //建立題庫
    var qnas = [QnaModel(question: "Idle young, needy old.", answer: "少壯不努力，老大徒傷悲"),
                QnaModel(question: "Homer sometimes nods.", answer: "智者千慮，必有一失"),
                QnaModel(question: "Money makes the mare go.", answer: "有錢能使鬼拖磨"),
                QnaModel(question: "Beuty is in the eye of beholder.", answer: "情人眼裡出西施"),
                QnaModel(question: "As you make your bed so you must lie on it.", answer: "自作自受，咎由自取"),
                QnaModel(question: "Every cloud has a silver lining.", answer: "塞翁失馬，焉知非福"),
                QnaModel(question: "Keep something for a rainy day.", answer: "未雨綢繆"),
                QnaModel(question: "Actions speak louder than words.", answer: "坐而言不如起而行"),
                QnaModel(question: "Learn to walk before you run.", answer: "按部就班"),
                QnaModel(question: "Example is better than percept.", answer: "身教勝於言教")]

    //初始化
    var num = 0//現在題數
    var myScore = 0//我的分數
    var yourScore = 0//電腦的分數
    var youranswernum = 0
    var fouranswer:[String] = []//四個選項
    var timer = Timer()//倒數計時
    var time = 10//倒數計時
    //IBOutlet
    @IBOutlet weak var qnanumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    @IBOutlet weak var myscoreLabel: UILabel!
    @IBOutlet weak var yourscoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qnas.shuffle()
        showqna()
    }
    
    //click answer button
    @IBAction func clickanswer(_ sender: UIButton) {
        timer.invalidate()//倒數計時歸零
        youranswernum = Int.random(in: 0...3)
        num += 1
        print("correct answer is :\(qnas[0].answer)")
        print("my chose is :\(String(describing: sender.title(for: .normal)))")
        print("computer chose is :\(fouranswer[youranswernum])")
        if num < 5{//題數不到五題，繼續作答
            if sender.title(for: .normal) == qnas[0].answer{
                myScore += 10
            }
            if qnas[0].answer == fouranswer[youranswernum]{
                yourScore += 10
            }
            //show cuurent score
            myscoreLabel.text = String(myScore)
            yourscoreLabel.text = String(yourScore)
            //顯示下一題
            qnas.remove(at: 0)
            qnas.shuffle()
            showqna()
        }else{//題數到達五題，跳到下一頁顯示結果頁
            if let controller = (storyboard?.instantiateViewController(withIdentifier: "ScoreViewController")) as? ScoreViewController{
                //最後一次分數加上去
                if sender.title(for: .normal) == qnas[0].answer{
                    myScore += 10
                }
                if qnas[0].answer == fouranswer[youranswernum]{
                    yourScore += 10
                }
                //show cuurent score
                myscoreLabel.text = String(myScore)
                yourscoreLabel.text = String(yourScore)
                controller.myscore1 = myScore
                controller.yourscore1 = yourScore
                present(controller, animated: true, completion: nil)
            }
        }
    }
    
    
    //show qna storyboard
    func showqna(){
        //init fouranswer
        fouranswer = []
        //countdown time
        countdowntime()
        //show qna storyboard
        qnanumberLabel.text = "第\(num+1)題"
        questionLabel.text = qnas[0].question
        //random四個選項
        fouranswer = [qnas[0].answer]//第一個選項
        var newqnas = qnas
        newqnas.remove(at: 0)
        for _ in 0...2{
            newqnas = newqnas.shuffled()
            fouranswer.append(newqnas[0].answer)
            newqnas.remove(at: 0)
        }
        fouranswer.shuffle()
        for item in 0...3{
            answerButton[item].setTitle(fouranswer[item], for: .normal)
        }
    }
    
    //倒數計時
    func countdowntime(){
        if num<5{
            time = 10
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatetimer), userInfo: nil, repeats: true)
        }
    }
    @objc func updatetimer(){
        time -= 1
        if time != 0{
            timeLabel.text = String(time)
        }else{
            timeLabel.text = "10"
        }
        if time == 0{
            youranswernum = Int.random(in: 0...3)
            print("computer chose is :\(fouranswer[youranswernum])")
            timer.invalidate()
            num += 1
            if num < 5{//題數不到五題，繼續作答
                if qnas[0].answer == fouranswer[youranswernum]{
                    yourScore += 10
                }
                //show cuurent score
                myscoreLabel.text = String(myScore)
                yourscoreLabel.text = String(yourScore)
                //顯示下一題
                qnas.remove(at: 0)
                qnas.shuffle()
                showqna()
            }else{//題數到達五題，跳到下一頁顯示結果頁
                if let controller = (storyboard?.instantiateViewController(withIdentifier: "ScoreViewController")) as? ScoreViewController{
                    //最後一次分數加上去
                    if qnas[0].answer == fouranswer[youranswernum]{
                        yourScore += 10
                    }
                    //show cuurent score
                    controller.myscore1 = myScore
                    controller.yourscore1 = yourScore
                    present(controller, animated: true, completion: nil)
                }
            }
        }
    }
}
