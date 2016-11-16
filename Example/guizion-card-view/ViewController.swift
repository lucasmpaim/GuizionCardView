//
//  ViewController.swift
//  guizion-card-view
//
//  Created by Lucas on 07/07/2016.
//  Copyright (c) 2016 Lucas. All rights reserved.
//

import UIKit
import guizion_card_view

class ViewController: UIViewController {

    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var testFont: UILabel!
    
    var count = 0
    
    let tappingTime = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.setCreditCardNumber), userInfo: nil, repeats: false)
        
    }
    
    func setCreditCardNumber() {
        let cardNumber = "5374 2675 6742 5782"
        cardView.updateNumber(cardNumber.substring(to: cardNumber.characters.index(cardNumber.startIndex, offsetBy: count)))
        
        if count < cardNumber.characters.count {
            count += 1
            Timer.scheduledTimer(timeInterval: tappingTime, target: self, selector: #selector(ViewController.setCreditCardNumber), userInfo: nil, repeats: false)
        } else {
            count = 0
            self.setCreditCardName()
        }
    }
    
    
    func setCreditCardName() {
        let cardName = "LUCAS M PAIM"
        cardView.updateName(cardName.substring(to: cardName.characters.index(cardName.startIndex, offsetBy: count)))
        
        if count < cardName.characters.count {
            count += 1
            Timer.scheduledTimer(timeInterval: tappingTime, target: self, selector: #selector(ViewController.setCreditCardName), userInfo: nil, repeats: false)
        } else {
            count = 0
            self.setCreditValidate()
        }
    }
    
    
    func setCreditValidate() {
        let expirationDate = "12/18"
        cardView.updateExpirationDate(expirationDate.substring(to: expirationDate.characters.index(expirationDate.startIndex, offsetBy: count)))
        
        if count < expirationDate.characters.count {
            count += 1
            Timer.scheduledTimer(timeInterval: tappingTime, target: self, selector: #selector(ViewController.setCreditValidate), userInfo: nil, repeats: false)
        } else {
            count = 0
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.flipAndSetCCV), userInfo: nil, repeats: false)
        }
        
    }
    
    
    func flipAndSetCCV() {
        try! cardView.flip() {
            self.setCreditCardCCV()
        }
    }
    
    func setCreditCardCCV() {
        let cardCCV = "123"
        cardView.updateCCVNumber(cardCCV.substring(to: cardCCV.characters.index(cardCCV.startIndex, offsetBy: count)))
        
        if count < cardCCV.characters.count {
            count += 1
            Timer.scheduledTimer(timeInterval: tappingTime, target: self, selector: #selector(ViewController.setCreditCardCCV), userInfo: nil, repeats: false)
        } else {
            count = 0
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.forceFlip), userInfo: nil, repeats: false)
        }
    }
    
    func forceFlip (){
        try! cardView.flip() {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

