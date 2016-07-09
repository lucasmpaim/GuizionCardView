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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.setCreditCardNumber), userInfo: nil, repeats: false)
        
    }
    
    func setCreditCardNumber() {
        let cardNumber = "5374267567425782"
        cardView.updateNumber(cardNumber.substringToIndex(cardNumber.startIndex.advancedBy(count)))
        
        if count < cardNumber.characters.count {
            count += 1
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.setCreditCardNumber), userInfo: nil, repeats: false)
        } else {
            count = 0
            try! cardView.flip() {
                self.setCreditCardCCV()
            }
        }
    }
    
    
    func setCreditCardCCV() {
        let cardCCV = "123"
        cardView.updateCCVNumber(cardCCV.substringToIndex(cardCCV.startIndex.advancedBy(count)))
        
        if count < cardCCV.characters.count {
            count += 1
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.setCreditCardCCV), userInfo: nil, repeats: false)
        } else {
            count = 0
            NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.forceFlip), userInfo: nil, repeats: false)
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

