//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.redColor()


let label = UILabel(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
label.text = "huehuehue"

view.addSubview(label)


XCPlaygroundPage.currentPage.liveView = view

let cardNumber = "012345678"

cardNumber.substringToIndex(cardNumber.startIndex.advancedBy(4))
