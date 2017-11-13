//
//  MaskLabel.swift
//  guizion-card-view
//
//  Created by Lucas Paim on 13/11/2017.
//

import Foundation
import UIKit


class MaskLabel: UILabel {
    
    var textMask: String = "#### #### #### ####"
    
    fileprivate var applyingMask = false
    
    override var text: String? {
        didSet {
            if !applyingMask {
                applyMask(text)
            }
        }
    }
    
    
    fileprivate func applyMask(_ _value: String?) {
        //Remove spaces
        
        applyingMask = true
        
        guard let value = _value?.replacingOccurrences(of: " ", with: "") else { return }
        
        var maskedValue = ""
        var currentTextIndex = 0
        
        textMask.forEach {
            if currentTextIndex < value.count {
                if $0 == "#" {
                    maskedValue += value[currentTextIndex]
                    currentTextIndex += 1
                } else {
                    maskedValue += "\($0)"
                }
            }
        }
        
        text = maskedValue
        applyingMask = false
    }
    
}
