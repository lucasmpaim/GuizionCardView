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
    
    private var frontView = UIImageView()
    private var backView = UIImageView()
    
    private let noCardView = UIImageView(image: UIImage.loadImageFromPodBundle("no_card"))
    private let cardFormatter = CardNumberFormatter()
    private var lastCardType = CardTypes.None
    
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
    }
    
    /**
     Retrive the card type
     - SeeAlso: `CardTypes`
     */
    public var card: CreditCard = CreditCard()
    
    public override func layoutSubviews() {
        noCardView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        frontView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        backView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
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
        
        if frontView.image == nil || backView.image == nil {
            throw CreditCardErrors.NumberNotProvided
        }
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        var views : (frontView: UIView, backView: UIView)
        views = (frontView: frontView, backView: backView)
        
        UIView.transitionFromView(views.frontView,
                                  toView: views.backView,
                                  duration: 1,
                                  options: transitionOptions,
                                  completion: { _ in
        })
        
    }
    
    
    public func updateNumber(number: String) {
        let card = self.cardFormatter.verifyPattern(number)
        
        if card.cardType == .None {
            frontView.image = nil
            backView.image = nil
            noCardView.hidden = false
            return
        }
        
        if card.cardType != lastCardType {
            frontView.image = UIImage.loadImageFromPodBundle(card.card?.frontImage ?? "not_reconized")
            backView.image = UIImage.loadImageFromPodBundle(card.card?.backImage ?? "not_reconized")
            bubbleAnimation() { [weak self] in
                self?.noCardView.hidden = true
            }
        }
        
        lastCardType = card.cardType
        self.card = card ?? self.card
    }
    
    func bubbleAnimation(onComplete: () -> Void) {
        let maskLayer = CAShapeLayer()
        let maskRect = CGRectMake(-25, bounds.maxY - 25, 50, 50);
        let path = CGPathCreateWithEllipseInRect(maskRect, nil)
        
        let finalRect = CGRectMake(-bounds.width*2, bounds.maxY - bounds.height*2, bounds.width * 4, bounds.height * 4)
        let finalPath = CGPathCreateWithEllipseInRect(finalRect, nil)
        maskLayer.path = path
        
        frontView.layer.mask = maskLayer
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock({
            print("completed")
            onComplete()
            try! self.flip()
        })
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = maskLayer.path
        anim.toValue = finalPath
        anim.duration = 2.5
        anim.removedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayer.addAnimation(anim, forKey: nil)
        
        maskLayer.path = finalPath
        CATransaction.commit()
    }
    
}