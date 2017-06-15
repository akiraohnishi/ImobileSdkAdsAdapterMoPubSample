//
//  ImobileSdkAdsMoPubNativeCustomEvent.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import MoPub

struct ImobileCustomEventData {
    let publisherId: String
    let mediaId: String
    let spotId: String

    init?(info: [AnyHashable:Any]) {
        guard let publisherId = info["publisherId"] as? String else {
            return nil
        }

        guard let mediaId = info["mediaId"] as? String else {
            return nil
        }

        guard let spotId = info["spotId"] as? String else {
            return nil
        }

        self.publisherId = publisherId
        self.mediaId = mediaId
        self.spotId = spotId
    }
}

@objc(ImobileSdkAdsMoPubNativeCustomEvent)
class ImobileSdkAdsMoPubNativeCustomEvent : MPNativeCustomEvent {
    override func requestAd(withCustomEventInfo info: [AnyHashable : Any]!) {
        NSLog("[\(type(of: self)) \(#function)]")

        // info には MoPub の管理画面で定義した Custom Event Class Data が入ってくる
        // info から i-mobile の広告のリクエストに必要な publisherId, mediaId, spotId を取り出す

        guard let eventData = ImobileCustomEventData(info: info) else {
            return
        }

        NSLog("publisherId: \(eventData.publisherId), mediaId: \(eventData.mediaId), spotId: \(eventData.spotId)")

        ImobileSdkAds.register(withPublisherID: eventData.publisherId, mediaID: eventData.mediaId, spotID: eventData.spotId)
        ImobileSdkAds.start(bySpotID: eventData.spotId)

        ImobileSdkAds.getNativeAdData(eventData.spotId, delegate: self)
    }
}

// MARK:- IMobileSdkAdsDelegate

extension ImobileSdkAdsMoPubNativeCustomEvent : IMobileSdkAdsDelegate {
    func imobileSdkAdsSpot(_ spotId: String!, didReadyWithValue value: ImobileSdkAdsReadyResult) {
        NSLog("[\(#function)] spotId: \(spotId), value: \(value)")
    }

    func imobileSdkAdsSpot(_ spotId: String!, didFailWithValue value: ImobileSdkAdsFailResult) {
        NSLog("[\(#function)] spotId: \(spotId), value: \(value)")

        self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse("\(value)"))
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
    
    func onNativeAdDataReciveCompleted(_ spotId: String!, nativeArray: [Any]!) {
        NSLog("[\(type(of: self)) \(#function)] spotId: \(spotId), nativeArray: \(nativeArray)")

        guard let adObject = nativeArray[0] as? ImobileSdkAdsNativeObject else {
            NSLog("invalid native ad object")

            self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse("invalid native ad object"))

            return
        }

        adObject.getAdImageCompleteHandler { image in
            guard let _ = image else {
                self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForImageDownloadFailure())
                return
            }

            let adapter = ImobileSdkAdsMoPubNativeAdAdapter(imobileSdkAdsNativeObject: adObject)
            adapter.setSpotDelegate(spotId)
            let mpNativeAd = MPNativeAd(adAdapter: adapter)

            self.delegate.nativeCustomEvent(self, didLoad: mpNativeAd)
        }
    }
}
