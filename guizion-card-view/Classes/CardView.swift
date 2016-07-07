//
//  CardView.swift
//  Pods
//
//  Created by Guizion Labs on 07/07/16.
//
//

import Foundation
import UIKit

/**
 CardView is a iOS UI Library for Credit Card animation
 - Author: Guizion Labs
 - Version: 1.0
 */
public class CardView: UIView {
    
    private var frontView: UIImageView?
    private var backView: UIImageView?
    private let noCardView = UIImageView(image: UIImage(named: "no_card"))
    
    /**
     Retrive the card type
     - SeeAlso: `CardTypes`
     */
    public var card: CreditCard = CreditCard()
    
    public override func layoutSubviews() {
        noCardView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        frontView?.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        backView?.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
    }
    
    
    /**
     Use this function to flip de credit card to the back-side
     
     - Throws: CreditCardErrors.NumberNotProvided
     
     ```
     do{
        try self.flip()
     } catch CreditCardErrors.NumberNotProvided {
     
     } catch _ {
     
     }
     ```
     */
    public func flip() throws {
        
        if frontView == nil || backView == nil {
            throw CreditCardErrors.NumberNotProvided
        }
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        var views : (frontView: UIView, backView: UIView)
        views = (frontView: frontView!, backView: backView!)
        
        UIView.transitionFromView(views.frontView,
                                  toView: views.backView,
                                  duration: 1,
                                  options: transitionOptions,
                                  completion: { _ in
        })
        
    }
    
    
    public func updateNumber(number: String) {
        
    }
    
}