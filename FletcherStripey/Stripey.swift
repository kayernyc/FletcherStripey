//
//  Stripey.swift
//  FletcherStripey
//
//  Created by KATHRIN AYER on 7/3/18.
//  Copyright © 2018 happierplaces. All rights reserved.
//

import UIKit

enum Color: UInt32 {
  case white, green, darkGray, lightGray

  private static var count: Color.RawValue = {
    var maxValue: UInt32 = 0
    while let _ = Color(rawValue: maxValue) {
      maxValue += 1
    }

    return maxValue
  }()

  static func randomColor() -> Color {
    let rand = arc4random_uniform(count)
    return Color(rawValue: rand)!
  }
}

extension Color {
  var value: UIColor {
    switch self {
    case .white:
      return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    case .green:
      return UIColor(red: 0.55, green: 0.64, blue: 0.02, alpha: 1.0)
    case .darkGray:
      return UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
    case .lightGray:
      return UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.0)
    }
  }
}

protocol StripyDelegate: class {
  func removeStripe(_ stripe: Stripy)
}

class Stripy: CALayer, CAAnimationDelegate {
  weak var stripeDelegate: StripyDelegate?

  private let maxWidth: UInt32 = 200
  private let minWidth: UInt32 = 10
  private let animiationTime = 1.0
  private let transitionTime = 3.0

  private func timing() -> [NSNumber] {
    var values: [Float] = [0]

    for _ in 0..<4 {
      let maximum = UInt32(90 - values.last!)

      var newValue = Float((arc4random_uniform(maximum) + arc4random_uniform(maximum))/2)
      newValue += values.last!
      values.append(newValue)
    }

    let returnArray = values.map { NSNumber(value: $0/100) }

    return returnArray
  }

  private func animation() -> CAKeyframeAnimation {
    let keyValues = timing()
    let animation = CAKeyframeAnimation()

    animation.keyPath = "opacity"

    animation.values = [0, 1, 1, 0, 0]
    animation.keyTimes = keyValues
    animation.duration = Double(arc4random_uniform(5) + 5)
    animation.isAdditive = true
    animation.delegate = self

    return animation
  }

  func animateStripe() {
    self.add(animation(), forKey: #keyPath(CALayer.opacity))
  }

  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if let stripeDelegate = self.stripeDelegate {
      stripeDelegate.removeStripe(self)
      removeFromSuperlayer()
    }
  }

  init(viewWidth: CGFloat, viewHeight: CGFloat) {
    super.init()

    let width = CGFloat(arc4random_uniform(maxWidth) + minWidth)
    let xPosition = CGFloat(arc4random_uniform(UInt32(viewWidth - width)))
    let color: UIColor = Color.randomColor().value

    self.backgroundColor = color.cgColor
    self.frame = CGRect(x: xPosition, y: 0, width: width, height: viewHeight)
    self.opacity = 0

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
