//
//  ImobileSdkAdsMoPubNativeAdRenderer.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import MoPub

class ImobileSdkAdsMoPubNativeAdRenderer : NSObject, MPNativeAdRenderer {
    static func rendererConfiguration(with rendererSettings: MPNativeAdRendererSettings!) -> MPNativeAdRendererConfiguration! {
        let adRendererConfiguration = MPNativeAdRendererConfiguration()
        adRendererConfiguration.rendererSettings = rendererSettings
        adRendererConfiguration.rendererClass = self
        adRendererConfiguration.supportedCustomEvents = ["ImobileSdkAdsMoPubNativeCustomEvent"]

        return adRendererConfiguration
    }

    var viewSizeHandler: MPNativeViewSizeHandler!
    var rendererSettings: MPNativeAdRendererSettings

    var adapter: ImobileSdkAdsMoPubNativeAdAdapter?

    required init!(rendererSettings: MPNativeAdRendererSettings!) {
        NSLog("[\(type(of: self)) \(#function)]")

        self.rendererSettings = rendererSettings
        self.viewSizeHandler = rendererSettings.viewSizeHandler
    }

    func retrieveView(with adapter: MPNativeAdAdapter!) throws -> UIView {
        NSLog("[\(type(of: self)) \(#function)]")

        guard let adapter = adapter as? ImobileSdkAdsMoPubNativeAdAdapter else {
            NSLog("adapter not found")

            throw MPNativeAdNSErrorForRenderValueTypeError()
        }

        self.adapter = adapter

        guard let rendererSettings = self.rendererSettings as? ImobileSdkAdsMoPubNativeRendererSettings<ProgramListItemAdPlacerView> else {
            throw MPNativeAdNSErrorForRenderValueTypeError()
        }

        let view = rendererSettings.creationHandler()

        if let mainTextLabel = view.nativeTitleTextLabel(), let mainText = adapter.properties[kAdTitleKey] as? String {
            mainTextLabel.text = mainText
        }

        if let callToActionTextLabel = view.nativeCallToActionTextLabel(), let callToActionText = adapter.properties[kAdTextKey] as? String {
            callToActionTextLabel.text = callToActionText
        }

        if let mainImageView = view.nativeIconImageView(), let mainImage = adapter.properties[kAdMainImageKey] as? UIImage {
            mainImageView.image = mainImage
        }

        if let privacyIconImageView = view.nativePrivacyInformationIconImageView() {
            privacyIconImageView.removeFromSuperview()
        }

        return view
    }

    func nativeAdTapped() {
        NSLog("[\(type(of: self)) \(#function)]")
    }
}
