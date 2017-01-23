//
//  CardView.swift
//  Pods
//
//  Created by Guizion Labs on 07/07/16.
//
//

import Foundation
import UIKit
import UIColor_Hex_Swift
/**
 CardView is a iOS UI Library for Credit Card animation
 - Author: Guizion Labs
 - Version: 1.0
 */
open class CardView: UIView {
    
    public enum State {
        case front
        case back
    }
    
    fileprivate var frontView = CardFrontView()
    fileprivate var backView = CardBackView()
    
    fileprivate let noCardView = UIImageView(image: UIImage.loadImageFromPodBundle("no_card"))
    fileprivate let cardFormatter = CardNumberFormatter()
    fileprivate var lastCardType = CardTypes.None
    
    open var state: State = .front
    
    /**
     Retrive the card type
     - SeeAlso: `CardTypes`
     */
    open var card: CreditCard = CreditCard()
    
    open var bundleAnimationDuration = 2.5
    open var flipAnimationDuration = 1
    
    open override func layoutSubviews() {
        noCardView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        frontView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(backView)
        self.addSubview(noCardView)
        self.addSubview(frontView)
        
        frontView.cardNumber.textColor = UIColor("#D7D7D7")
        frontView.cardName.textColor = UIColor("#D4D4D4")
        frontView.validateNumber.textColor = UIColor("#D4D4D4")
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
    open func flip(_ onComplete: @escaping () -> Void) throws {
        
        if frontView.image == nil || backView.image == nil {
            throw CreditCardErrors.numberNotProvided
        }
        
        let transitionOptions: UIViewAnimationOptions
        var views : (frontView: UIView, backView: UIView)
        
        if state == .front {
            views = (frontView: frontView, backView: backView)
            transitionOptions = UIViewAnimationOptions.transitionFlipFromRight
        } else {
            views = (frontView: backView, backView: frontView)
            transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        }
        
        
        UIView.transition(from: views.frontView,
                          to: views.backView,
                          duration: 1,
                          options: transitionOptions,
                          completion: { [weak self] _ in
                            
                            self?.state = self?.state == .front ? .back : .front
                            
                            onComplete()
                            
        })
        
    }
    
    open func updateNumber(_ number: String) {
        
        
        frontView.cardNumber.text = number
        
        if number.isEmpty {
            lastCardType = .None
            frontView.image = nil
            backView.image = nil
            //noCardView.isHidden = false
            frontView.cardNumber.textColor = UIColor("#D7D7D7")
            frontView.cardName.textColor = UIColor("#D4D4D4")
            frontView.validateNumber.textColor = UIColor("#D4D4D4")
            return
        }
        
        let card = self.cardFormatter.verifyPattern(number)
        self.card = card ?? self.card
        
        if card.cardType == .None {
            frontView.image = nil
            backView.image = nil
            //noCardView.isHidden = false
            
            frontView.cardNumber.textColor = UIColor("#D7D7D7")
            frontView.cardName.textColor = UIColor("#D4D4D4")
            frontView.validateNumber.textColor = UIColor("#D4D4D4")
        }
        
        if card.cardType != lastCardType {
            frontView.image = UIImage.loadImageFromPodBundle(card.card?.frontImage ?? "notrecognized_front")
            backView.image = UIImage.loadImageFromPodBundle(card.card?.backImage ?? "notrecognized_back")
            backView.ccvNumber.textColor = UIColor(card.card?.ccvColor ?? "#4B4B4B")
            frontView.cardNumber.textColor = UIColor(card.card?.numberColor ?? "#434343")
            frontView.cardName.textColor = UIColor(card.card?.nameColor ?? "#656565")
            frontView.validateNumber.textColor = UIColor(card.card?.expirationColor ?? "#656565")
            
            bubbleAnimation() { [weak self] in
//                if self?.frontView.image != .none {
//                    self?.noCardView.isHidden = true
//                }
            }
        }
        lastCardType = card.cardType
    }
    
    open func updateCCVNumber(_ number: String) {
        backView.ccvNumber.text = number
    }
    
    open func updateName(_ name: String) {
        frontView.cardName.text = name
    }
    
    open func updateExpirationDate(_ date: String) {
        frontView.validateNumber.text = date
    }
    
    func bubbleAnimation(_ onComplete: @escaping () -> Void) {
        let maskLayer = CAShapeLayer()
        let maskRect = CGRect(x: -25, y: bounds.maxY - 25, width: 50, height: 50);
        let path = CGPath(ellipseIn: maskRect, transform: nil)
        
        let finalRect = CGRect(x: -bounds.width*2, y: bounds.maxY - bounds.height*2, width: bounds.width * 4, height: bounds.height * 4)
        let finalPath = CGPath(ellipseIn: finalRect, transform: nil)
        maskLayer.path = path
        
        frontView.layer.mask = maskLayer
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock({
            print("completed")
            onComplete()
        })
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = maskLayer.path
        anim.toValue = finalPath
        anim.duration = 2.5
        anim.isRemovedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayer.add(anim, forKey: nil)
        
        maskLayer.path = finalPath
        CATransaction.commit()
    }
    
}
