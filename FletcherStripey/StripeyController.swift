//
//  StripeyController.swift
//  FletcherStripey
//
//  Created by KATHRIN AYER on 7/2/18.
//  Copyright © 2018 happierplaces. All rights reserved.
//

import UIKit

class StripeyController: UIViewController {

  private lazy var viewHeight = {
    view.layer.frame.size.height
  }()

  private lazy var viewWidth = {
    view.layer.frame.size.width
  }()

  var stripes = [Stripey]()

  private func generateStripes(count: Int?) {

    let stripeCount = count ?? Int(arc4random_uniform(6) + 2)

    for _ in 0..<stripeCount {
      let stripe = Stripey(viewWidth: viewWidth, viewHeight: viewHeight)
      stripe.stripeDelegate = self
      stripes.append(stripe)

      view.layer.addSublayer(stripe)
      stripe.animateStripe()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.isIdleTimerDisabled = true
    generateStripes(count: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension StripeyController {}

extension StripeyController: StripeyDelegate {
  func removeStripe(_ stripe: Stripey) {
    if stripes.count < 25 {
      let newCount = stripes.count > 1 ? Int(arc4random_uniform(2) + 1) : Int(arc4random_uniform(6) + 1)
      generateStripes(count: newCount)
    }

    stripes = stripes.filter {$0 != stripe}
  }
}
