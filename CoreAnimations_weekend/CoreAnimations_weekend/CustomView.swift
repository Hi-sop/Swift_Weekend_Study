//
//  CustomView.swift
//  CoreAnimations_weekend
//
//  Created by Hisop on 2024/01/22.
//

import UIKit

class CustomView: UIView {
    let width: CGFloat = 550
    let height: CGFloat = 550
    
    var cupLayer = CAShapeLayer()
    var strawLayer = CAShapeLayer()
    var drinkLayer = CAShapeLayer()
    var maskLayer = CAShapeLayer()
    
    var drinkState: Bool = false
    
    func layerInit() {
        drawStraw()
        drawDrink()
        drawMask()
        drawCup()
        gestureRecognizerInit()
    }
    
    func gestureRecognizerInit() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeDrinks))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changeDrinks() {
        let position = CABasicAnimation(keyPath: "position.y")
        let transform = CABasicAnimation(keyPath: "transform.rotation.z")
        
        if drinkState {
            position.fromValue = 60
            position.toValue = 350
            transform.fromValue = 10 * Double.pi / 180
            transform.toValue = 0
            
        } else {
            position.fromValue = 350
            position.toValue = 60
            transform.toValue = 10 * Double.pi / 180
        }
        drinkState.toggle()
        
        position.duration = 1.0
        transform.duration = 1.0
        
        position.fillMode = .forwards
        position.isRemovedOnCompletion = false
        transform.fillMode = .forwards
        transform.isRemovedOnCompletion = false
        
        drinkLayer.add(position, forKey: "drinkAnimation")
        strawLayer.add(transform, forKey: "strawAnimation")
    }
    
    func drawCup() {
        cupLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 100))
        
        path.addLine(to: CGPoint(x: 125, y: 330))
        
        let bottom: Int = 125
        path.addCurve(to: CGPoint(x: 125 + bottom, y: 330), control1: CGPoint(x: 125 + bottom / 3, y: 350) , control2: CGPoint(x: 125 + (bottom / 3) * 2, y: 350))
        
        path.addLine(to: CGPoint(x: 275, y: 100))
            
        cupLayer.path = path
        
        cupLayer.strokeColor = UIColor.gray.cgColor
        cupLayer.fillColor = UIColor.clear.cgColor
        
        cupLayer.lineWidth = 10
        
        self.layer.addSublayer(cupLayer)
    }
    
    func drawMask() {
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 100))
        
        path.addLine(to: CGPoint(x: 125, y: 330))
        
        let bottom: Int = 125
        path.addCurve(to: CGPoint(x: 125 + bottom, y: 330), control1: CGPoint(x: 125 + bottom / 3, y: 350) , control2: CGPoint(x: 125 + (bottom / 3) * 2, y: 350))
        
        path.addLine(to: CGPoint(x: 275, y: 100))
        path.closeSubpath()
        
        maskLayer.path = path
        
        maskLayer.fillColor = UIColor.brown.cgColor
        maskLayer.mask = drinkLayer
        
        self.layer.addSublayer(maskLayer)
    }
    
    func drawStraw() {
        strawLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 125 + (125 / 2), y: 330))
        path.addLine(to: CGPoint(x: 230, y: 100))
        path.addLine(to: CGPoint(x: 290, y: 60))
        
        strawLayer.path = path
        
        strawLayer.strokeColor = UIColor.darkGray.cgColor
        strawLayer.fillColor = UIColor.clear.cgColor
        
        strawLayer.lineWidth = 11
        strawLayer.lineCap = .round
        
        self.layer.addSublayer(strawLayer)
    }
    
    func drawDrink() {
        drinkLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let path = CGMutablePath(rect: CGRect(x: 70, y: 350, width: 200, height: 300), transform: nil)
        
        drinkLayer.path = path
                    
        self.layer.addSublayer(drinkLayer)
    }
    
}
