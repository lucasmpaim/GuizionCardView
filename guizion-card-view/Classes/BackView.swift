//
//  BackView.swift
//  Pods
//
//  Created by Lucas Paim on 09/07/16.
//
//

import Foundation

class CardBackView: UIImageView {

    let ccvNumber = UILabel()
    
    init(){
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
        self.addSubview(ccvNumber)
        ccvNumber.font = UIFont(name: Constants.fontName, size: 15.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let xPos = ((self.frame.width * 280)/343) - 15
        let yPos = (self.frame.height * 99)/207
        
        ccvNumber.frame = CGRect(x: xPos, y: yPos, width: 50, height: 18)
    }
    
}
