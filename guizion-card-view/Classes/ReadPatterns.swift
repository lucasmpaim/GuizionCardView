//
//  ReadPatterns.swift
//  Pods
//
//  Created by Guizion Labs on 07/07/16.
//
//

import Foundation

class CardNumberFormatter {
    
    var patternDictionary: Dictionary<CardTypes, CardInfo> = Dictionary()
    
    var cachedCard: CreditCard?
    
    init() {
        let filePath = NSBundle.mainBundle().pathForResource("CardPatterns", ofType: "plist")
        guard let array = NSArray(contentsOfFile: filePath!) else {fatalError("CardPatterns.plist is missing!")}
        
        for cardData in array {
            let card = CardInfo(dictionary: cardData as! Dictionary<String, String>)
            let cardType = CardTypes(rawValue: card.name!) ?? CardTypes.NotRecognized
            patternDictionary[cardType] = card
        }
    }
    
    func patternMatchesWithNumberString(number: String, pattern: NSRegularExpression) -> Bool {
        let numberOfMatches = pattern.numberOfMatchesInString(number, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, number.characters.count))
        return numberOfMatches > 0
    }

    func verifyPattern (number: String) -> CreditCard? {
        
        if(cachedCard != nil) {
            if(patternMatchesWithNumberString(number, pattern: cachedCard!.card!.pattern!)) {
                return cachedCard
            } else {
                cachedCard = nil
            }
        }
        
        for (type, card) in patternDictionary {
        
            if patternMatchesWithNumberString(number, pattern: card.pattern!) {
                cachedCard = CreditCard(type: type, card: card)
                return cachedCard
            }
        }
        
        return number.characters.count < 4 ? CreditCard() : CreditCard(type: CardTypes.NotRecognized)
    }
}

