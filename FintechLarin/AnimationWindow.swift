//
//  AnimationWindow.swift
//  FintechLarin
//
//  Created by Иван Lardis on 04/12/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class AnimationWindow: UIWindow {

    private lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: 320, y: 320)

        let cell = CAEmitterCell()
        cell.birthRate = 2
        cell.lifetime = 1
        cell.velocity = 20
        cell.scale = 0.1

        cell.emissionRange = CGFloat.pi * 2.0
        cell.contents = UIImage(named: "tinkoff-logo")!.cgImage

        emitterLayer.emitterCells = [cell]
        return emitterLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sendEvent(_ event: UIEvent) {
        if event.type == .touches, let touches = event.allTouches {
            for touch in touches {
                switch touch.phase {
                case .began:
                    layer.addSublayer(emitterLayer)
                    break
                case .moved:
                    let translation = touch.location(in: self.window)
                    emitterLayer.emitterPosition = CGPoint(x: translation.x, y: translation.y)
                    break
                case .ended:
                    emitterLayer.removeFromSuperlayer()
                    break
                default: return
                }
            }
        }
        super.sendEvent(event)
    }
}
