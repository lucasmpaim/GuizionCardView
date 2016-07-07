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

public struct CardInfo {
    var pattern: NSRegularExpression?
    var frontImage: String?
    var backImage: String?
    var name: String?
    var group: String?
    
    init(dictionary: Dictionary<String, String>) {
        self.pattern = try! NSRegularExpression(pattern: dictionary["pattern"]!, options: [.CaseInsensitive])
        self.frontImage = dictionary["imageFront"]
        self.backImage = dictionary["imageBack"]
        self.name = dictionary["companyName"]
        self.group = dictionary["numberGrouping"]
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
