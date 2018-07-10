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

  override func viewDidLoad() {
    super.viewDidLoad()

    let box = UIView()
    box.backgroundColor = .green

    let container = UIView()
    container.backgroundColor = .white

    container.addSubview(box)
    view.addSubview(container)

    container.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(10)
      make.left.equalTo(view).offset(20)
      make.right.equalTo(view).offset(-20)
      make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-10)
    }

    box.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(50)
      make.center.equalTo(container)
    }
//
//    headerView.translatesAutoresizingMaskIntoConstraints = false
//    headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//    headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//    headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
//    headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

  }
}
