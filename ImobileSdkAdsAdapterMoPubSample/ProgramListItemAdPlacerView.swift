//
//  ProgramListItemAdPlacerView.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import UIKit
import MoPub

final class ProgramListItemAdPlacerView : UIView, MPNativeAdRendering {
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.clipsToBounds = true

        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = GgmColor.parse("#2d4895")!
        label.text = "titleTextLabel"

        return label
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isOpaque = true

        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let privacyInformationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isOpaque = true
        imageView.backgroundColor = UIColor.white

        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let callToActionTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.clipsToBounds = true

        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = GgmColor.parse("#767676")!
        label.text = "callToActionTextLabel"

        return label
    }()

    let sponsoredTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.clipsToBounds = true

        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = GgmColor.parse("#767676")!
        label.text = "Sponsored"

        return label
    }()

    let line1px: UIView = {
        let view = UIView()
        view.backgroundColor = GgmColor.parse("#ebebeb")!

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let leadingMargin: CGFloat = floor(self.bounds.width * 0.05)
        let innerWidth: CGFloat = floor(self.bounds.width * 0.9)
        let vMargin: CGFloat = 6.0

        let ratio: CGFloat = 201.0 / 269.0
        let imageWidth: CGFloat = floor(innerWidth * 0.45 * ratio)

        let iconImageleadingMargin: CGFloat = floor(leadingMargin + (innerWidth * 0.45 - imageWidth) / 2)

        iconImageView.frame = CGRect(x: iconImageleadingMargin, y: vMargin, width: imageWidth, height: imageWidth)

        let programX: CGFloat = floor(leadingMargin + innerWidth * 0.49)
        let programWidth: CGFloat = floor(innerWidth * 0.51)

        let defaultSize = CGSize(width: programWidth, height: 100.0)

        let titleSize = titleTextLabel.sizeThatFits(defaultSize)
        let catSize = callToActionTextLabel.sizeThatFits(defaultSize)
        let sponsoredTextSize = sponsoredTextLabel.sizeThatFits(defaultSize)

        let titleBottomMargin: CGFloat = 4.0
        let catBottomMargin: CGFloat = 1.0

        let programHeight: CGFloat = titleSize.height + titleBottomMargin + catSize.height + catBottomMargin + sponsoredTextSize.height
        let programTopMargin: CGFloat = floor((self.bounds.height - programHeight) / 2.0)

        var y: CGFloat = programTopMargin

        titleTextLabel.frame = CGRect(origin: CGPoint(x: programX, y: y), size: titleSize)

        y += floor(titleTextLabel.frame.height + titleBottomMargin)

        callToActionTextLabel.frame = CGRect(origin: CGPoint(x: programX, y: y), size: catSize)

        y += floor(callToActionTextLabel.frame.height + catBottomMargin)

        sponsoredTextLabel.frame = CGRect(origin: CGPoint(x: programX, y: y), size: sponsoredTextSize)

        let privacyIconSize: CGFloat = 20.0
        let privacyIconOrigin = CGPoint(x: leadingMargin + innerWidth - privacyIconSize, y: self.bounds.height - vMargin - privacyIconSize)

        privacyInformationIconImageView.frame = CGRect(origin: privacyIconOrigin, size: CGSize(width: privacyIconSize, height: privacyIconSize))

        let line1pxY: CGFloat = 0.0
        line1px.frame = CGRect(x: leadingMargin, y: line1pxY, width: innerWidth, height: 1 / UIScreen.main.scale)
    }

    func configureSubviews() {
        self.addSubview(iconImageView)
        self.addSubview(titleTextLabel)
        self.addSubview(callToActionTextLabel)
        self.addSubview(sponsoredTextLabel)
        self.addSubview(privacyInformationIconImageView)
        self.addSubview(line1px)
    }

    func nativeTitleTextLabel() -> UILabel! {
        return titleTextLabel
    }

    func nativeCallToActionTextLabel() -> UILabel! {
        return callToActionTextLabel
    }
    
    func nativeIconImageView() -> UIImageView! {
        return iconImageView
    }
    
    func nativePrivacyInformationIconImageView() -> UIImageView! {
        return privacyInformationIconImageView
    }
}
