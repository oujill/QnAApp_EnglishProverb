//
//  ScoreViewController.swift
//  question&answer
//
//  Created by JillOU on 2020/8/2.
//  Copyright © 2020 Jillou. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    //前一頁傳過來的property
    var myscore1 = 0//我的分數
    var yourscore1 = 0//電腦的分數
    //IBOutlet
    @IBOutlet weak var myscoreLabel: UILabel!
    @IBOutlet weak var yourscoreLabel: UILabel!
    
    @IBOutlet weak var challengeresultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showscore()
    }

    //show score storyboard
    func showscore(){
        print("result!!!!!")
        //show myscore&yourscore
        myscoreLabel.text = String(myscore1)
        yourscoreLabel.text = String(yourscore1)

        //challenge success/fail
        if myscore1 < yourscore1{
            challengeresultLabel.text = "Challenge Fail"
        }else{
           challengeresultLabel.text = "Challenge Success"
        }
    }

}
