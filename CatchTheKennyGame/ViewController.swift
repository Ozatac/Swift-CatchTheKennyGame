//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Tunahan Özataç on 17.02.2020.
//  Copyright © 2020 Tunahan Ozatac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Gerekli tanımlamalarımızı yaptık.
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var ball1: UIImageView!
    @IBOutlet weak var ball2: UIImageView!
    @IBOutlet weak var ball3: UIImageView!
    @IBOutlet weak var ball4: UIImageView!
    @IBOutlet weak var ball5: UIImageView!
    @IBOutlet weak var ball6: UIImageView!
    @IBOutlet weak var ball7: UIImageView!
    @IBOutlet weak var ball8: UIImageView!
    @IBOutlet weak var ball9: UIImageView!
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var ballArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score : \(score)"
        
        //High Score Check
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
            
        }
        
        //Topların dokunulabilirik açtık
        ball1.isUserInteractionEnabled = true
        ball2.isUserInteractionEnabled = true
        ball3.isUserInteractionEnabled = true
        ball4.isUserInteractionEnabled = true
        ball5.isUserInteractionEnabled = true
        ball6.isUserInteractionEnabled = true
        ball7.isUserInteractionEnabled = true
        ball8.isUserInteractionEnabled = true
        ball9.isUserInteractionEnabled = true
        
        // Ekrana yapılan dokunmaları takip eden metoddur.
        let recognizer1  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer2  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer3  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer4  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer5  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer6  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer7  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer8  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer9  = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        
        //Birbirine bağladık
        ball1.addGestureRecognizer(recognizer1)
        ball2.addGestureRecognizer(recognizer2)
        ball3.addGestureRecognizer(recognizer3)
        ball4.addGestureRecognizer(recognizer4)
        ball5.addGestureRecognizer(recognizer5)
        ball6.addGestureRecognizer(recognizer6)
        ball7.addGestureRecognizer(recognizer7)
        ball8.addGestureRecognizer(recognizer8)
        ball9.addGestureRecognizer(recognizer9)
        
        ballArray = [ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8, ball9]
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBall), userInfo: nil, repeats: true)
        
        hideBall()
    }
    
    @objc func hideBall(){
        for ball in ballArray {
            ball.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(ballArray.count - 1))) // rastgele 0 ile 8 arasında deger elde ettik
        ballArray[random].isHidden = false  // rastgele birini gösterdik
        
    }
    
    @objc func incraseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"

    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate() //Timer Durdurma
            hideTimer.invalidate() //hideTimer Durdurma
            
            for ball in ballArray {
                       ball.isHidden = true
            }
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "HighScore")
                
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBall), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }


}

