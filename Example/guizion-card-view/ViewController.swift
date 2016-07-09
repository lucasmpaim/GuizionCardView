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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.setCreditCardNumber), userInfo: nil, repeats: false)
        
    }
    
    func setCreditCardNumber() {
        cardView.updateNumber("5374267567425782")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

