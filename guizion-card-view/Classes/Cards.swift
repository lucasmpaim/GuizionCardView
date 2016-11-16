//
//  Cards.swift
//  Pods
//
//  Created by Guizion Labs on 07/07/16.
//
//

import Foundation


public enum CardTypes: String {
    case Diners = "Diners Club"
    case Visa = "Visa"
    case Mastercard = "MasterCard"
    case JCB = "JCB"
    case AmericanExpress = "American Express"
    case LaserCardServices = "Laser Card Services Ltd."
    case ChinaUnionPay = "China UnionPay"
    case Maestro = "Maestro (MasterCard)"
    case Discover = "Discover"
    case NotRecognized = "Not Recognized"
    case None = "None"
}


/**
 
 <key>numberColor</key>
 <string>#D7D7D7</string>
 <key>nameColor</key>
 <string>#D4D4D4</string>
 <key>expirationColor</key>
 <string>#D4D4D4</string>
 <key>ccvColor</key>
 <string>#4B4B4B</string>
 
 */

public struct CardInfo {
    var pattern: NSRegularExpression?
    var frontImage: String?
    var backImage: String?
    var name: String?
    var group: String?
    
    var numberColor: String?
    var nameColor: String?
    var expirationColor: String?
    var ccvColor: String?
    
    init(dictionary: Dictionary<String, String>) {
        self.pattern = try! NSRegularExpression(pattern: dictionary["pattern"]!, options: [.caseInsensitive])
        self.frontImage = dictionary["imageFront"]
        self.backImage = dictionary["imageBack"]
        self.name = dictionary["companyName"]
        self.group = dictionary["numberGrouping"]
        
        self.numberColor = dictionary["numberColor"]
        self.nameColor = dictionary["nameColor"]
        self.expirationColor = dictionary["expirationColor"]
        self.ccvColor = dictionary["ccvColor"]
    }
    
}

public struct CreditCard {
    
    let cardType: CardTypes
    let card: CardInfo?
    
    init() {
        self.cardType = .None
        self.card = nil
    }
    
    init(type: CardTypes) {
        self.cardType = type
        self.card = nil
    }
    
    init(type: CardTypes, card: CardInfo) {
        self.cardType = type
        self.card = card
    }
    
}
