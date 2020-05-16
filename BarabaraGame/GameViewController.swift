//
//  GameViewControllorViewController.swift
//  BarabaraGame
//
//  Created by Yuka Uematsu on 2020/05/15.
//  Copyright © 2020 Uematsu Well. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView! //上
    @IBOutlet var imgView2: UIImageView! //真ん中
    @IBOutlet var imgView3: UIImageView! //下
    
    @IBOutlet var resultLabel: UILabel! // スコア表示
    
    var timer: Timer! //画像タイマー
    var score: Int = 1000 //スコアの値
    let defaults: UserDefaults = UserDefaults.standard //スコア保存
    
    let width: CGFloat = UIScreen.main.bounds.size.width //画面幅
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]//画面の位置
    
    var dx: [CGFloat] = [1.0, 0.5, -1.0] //画面の動かす幅
    
    
    func start() {
        //結果ラベルを見えなくする
        resultLabel.isHidden = true
        
        //タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,
                                     selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
                                     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()
    }
    
    
    @objc func up() {
        for i in 0..<3 {
            //端にきたら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]//画面の位置をdx分ずらす
        }
        imgView1.center.x = positionX[0]//上の画像をずらした位置に移動させる
        imgView2.center.x = positionX[1]//真ん中の画像をずらした位置に移動させる
        imgView3.center.x = positionX[2]//下の画像
        
    }
    @IBAction func stop() {
        if timer.isValid == true { //もしタイマーが動いていたら
            timer.invalidate() //タイマーを止める(無効にする)
        }
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i]))*2
                
            }
            resultLabel.text = "Score : " + String(score)
            resultLabel.isHidden = false
        
        let highScore1: Int = defaults.integer(forKey: "score1")
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
        
        if score > highScore1 {
            defaults.set(score, forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
            
        } else if score > highScore2 {
            defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        
        } else if score > highScore3 {
            defaults.set(score, forKey: "score3")
    }
    }

    @IBAction func retry() {
                score = 1000
                positionX = [width/2, width/2, width/2]
                if timer.isValid == false {
                    self.start()
                }
            }
        
    @IBAction func toTop() {
                self.dismiss(animated: true, completion: nil)
        }
        
        

}
   
