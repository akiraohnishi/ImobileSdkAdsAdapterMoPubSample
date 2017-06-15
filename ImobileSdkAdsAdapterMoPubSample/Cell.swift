//
//  Cell.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import UIKit

final class Cell : UICollectionViewCell {
    static let reuseIdentifier = "Cell"

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.label.frame = self.contentView.bounds
    }
}
