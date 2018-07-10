//
//  ConfigViewController.swift
//  FletcherStripey
//
//  Created by KATHRIN AYER on 7/10/18.
//  Copyright © 2018 happierplaces. All rights reserved.
//

import UIKit
import SnapKit

class ConfigViewController: UIViewController, ConstraintRelatableTarget {
  let labelStrings = ["Stripe size", "Number of stripes", "Color", "Speed"]
  let insetConst = 20
  let offsetConst = 10

  override func viewDidLoad() {
    super.viewDidLoad()

    let container = UIView()
    container.backgroundColor = .white
    view.addSubview(container)

    container.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(insetConst)
      make.left.equalTo(view).offset(insetConst)
      make.right.equalTo(view).offset(-insetConst)
      make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-insetConst)
    }

    for index in 0..<labelStrings.count {
      let subview = UILabel()
      subview.text = labelStrings[index]
      container.addSubview(subview)
      subview.sizeToFit()

      if index == 0 {
        subview.snp.makeConstraints { (make) in
          make.left.equalTo(container.snp.left).offset(insetConst)
          make.top.equalTo(container).offset(insetConst)
        }

      } else {
        let previousView = container.subviews[index - 1]
        subview.snp.makeConstraints { (make) in
          make.top.equalTo(previousView.snp.bottom).offset(insetConst)
          make.left.equalTo(previousView)
        }
      }
    }
  }
}
