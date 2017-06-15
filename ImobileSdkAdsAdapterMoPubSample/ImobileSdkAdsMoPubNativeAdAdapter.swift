//
//  ImobileSdkAdsMoPubNativeAdAdapter.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import MoPub

class ImobileSdkAdsMoPubNativeAdAdapter : NSObject, MPNativeAdAdapter {
    var properties: [AnyHashable : Any]! = [:]

    var defaultActionURL: URL! = nil

    let imobileSdkAdsNativeObject: ImobileSdkAdsNativeObject

    var iMobileSdkAdsDelegate: IMobileSdkAdsDelegate?
    var spotId: String?

    init(imobileSdkAdsNativeObject: ImobileSdkAdsNativeObject) {
        NSLog("[\(type(of: self)) \(#function)]")

        self.imobileSdkAdsNativeObject = imobileSdkAdsNativeObject

        // set properties

        properties[kAdTitleKey] = self.imobileSdkAdsNativeObject.getAdTitle()
        properties[kAdTextKey] = self.imobileSdkAdsNativeObject.getAdDescription()
        properties[kAdMainImageKey] = self.imobileSdkAdsNativeObject.getAdImage()
    }

    func setSpotDelegate(_ spotId: String) {
        self.spotId = spotId
        ImobileSdkAds.setSpotDelegate(spotId, delegate: self)
    }

    func displayContent(for URL: URL!, rootViewController controller: UIViewController!) {
        NSLog("[\(type(of: self)) \(#function)]")
    }

    func willAttach(to view: UIView!) {
        NSLog("[\(type(of: self)) \(#function)] view: \(view)")

        ImobileSdkAds.show(bySpotID: spotId!)

        self.imobileSdkAdsNativeObject.addClickFunction(view)
    }

    func trackClick() {
        NSLog("[\(type(of: self)) \(#function)]")
    }
}

// MARK:- IMobileSdkAdsDelegate

extension ImobileSdkAdsMoPubNativeAdAdapter : IMobileSdkAdsDelegate {
    func imobileSdkAdsSpot(_ spotId: String!, didReadyWithValue value: ImobileSdkAdsReadyResult) {
        NSLog("[\(#function)] spotId: \(spotId), value: \(value)")
    }

    func imobileSdkAdsSpotIsNotReady(_ spotId: String!) {
        NSLog("[\(#function)] spotId: \(spotId)")
    }

    func imobileSdkAdsSpotDidClick(_ spotId: String!) {
        NSLog("[\(#function)] spotId: \(spotId)")
    }

    func imobileSdkAdsSpotDidClose(_ spotId: String!) {
        NSLog("[\(#function)] spotId: \(spotId)")
    }

    func imobileSdkAdsSpotDidShow(_ spotId: String!) {
        NSLog("[\(#function)] spotId: \(spotId)")
    }
}
