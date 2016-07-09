//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class MyView: UIView {
    
    var frontCard:UIView!
    var backCard:UIView!
    
    func makeView() {
        
        self.backgroundColor = UIColor.lightGrayColor()
        self.layer.borderColor = UIColor.purpleColor().CGColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 10
        
    }
    
    
    func flipFrontToBack(frontView: UIView, backView: UIView) {
        
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        var views : (frontView: UIView, backView: UIView)
        views = (frontView: frontView, backView: backView)
        
        /*
         http://stackoverflow.com/questions/24413539/uiview-    transitionwithview-swift-syntax
         */
        
        UIView.transitionFromView(views.frontView,
                                  toView: views.backView,
                                  duration: 1,
                                  options: transitionOptions,
                                  completion: { _ in
        })
    }
    
    func smallSquare(backgroundColor: UIColor, borderColor:     UIColor) -> UIView {
        let bounds = CGRect(x: 50, y: 50, width: 50, height: 50)
        let view = UIView(frame: bounds)
        view.backgroundColor = backgroundColor
        view.layer.borderColor = borderColor.CGColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 10
        
        return view
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        frontCard = smallSquare(UIColor.blackColor(), borderColor: UIColor.whiteColor())
        backCard = smallSquare(UIColor.whiteColor(), borderColor: UIColor.redColor())
        makeView()

        self.addSubview(backCard)
        self.addSubview(frontCard)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        flipFrontToBack(frontCard, backView: backCard)
    }
    
    func flipIt() {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: false)
        
    }
}

let bounds = CGRect(x: 0, y: 0, width: 400, height: 200)
let view = MyView(frame: bounds)



XCPlaygroundPage.currentPage.liveView = view
//view.flipIt() // Works if NSTimer > 0


let maskLayer = CAShapeLayer()
let maskRect = CGRectMake(-25, bounds.maxY - 25, 50, 50);
let path = CGPathCreateWithEllipseInRect(maskRect, nil)


let finalRect = CGRectMake(-bounds.width*2, bounds.maxY - bounds.height*2, bounds.width * 4, bounds.height * 4)
let finalPath = CGPathCreateWithEllipseInRect(finalRect, nil)

//let path = CGPathCreateWithRect(maskRect, nil);
maskLayer.path = path

view.layer.mask = maskLayer

CATransaction.begin()

CATransaction.setCompletionBlock({
    print("completed")
    view.flipIt()
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


print("asjdkefgjdndd")
