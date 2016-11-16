//
//  FrontView.swift
//  Pods
//
//  Created by Lucas Paim on 09/07/16.
//
//

import Foundation

class CardFrontView: UIImageView {

    let cardNumber = UILabel()
    let cardName = UILabel()
    let validateNumber = UILabel()
    
    init() {
        super.init(image: nil, highlightedImage: nil)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(cardNumber)
        self.addSubview(cardName)
        self.addSubview(validateNumber)
        cardNumber.font = UIFont(name: Constants.fontName, size: 22.0)
        validateNumber.font = UIFont(name: Constants.fontName, size: 16.0)
        cardName.font = UIFont(name: Constants.fontName, size: 16.0)
    }

    override func layoutSubviews() {
        func calculateCardLabelPos(_ originalY: CGFloat, originalX: CGFloat) -> (x: CGFloat, y: CGFloat) {
            let yPos = (self.frame.height * originalY)/207
            let xPos = (self.frame.width * originalX)/343
            return (x: xPos, y: yPos)
        }
        
        let cardNumberPos = calculateCardLabelPos(111, originalX: 30)
        cardNumber.frame = CGRect(x: cardNumberPos.x, y: cardNumberPos.y, width: self.frame.width, height: 26)
        
        let cardNamePos = calculateCardLabelPos(172, originalX: 30)
        cardName.frame = CGRect(x: cardNamePos.x, y: cardNamePos.y, width: self.frame.width, height: 26)
        
        let validatePos = calculateCardLabelPos(172, originalX: 261)
        validateNumber.frame = CGRect(x: validatePos.x, y: validatePos.y, width: self.frame.width, height: 26)

    }
    
}
