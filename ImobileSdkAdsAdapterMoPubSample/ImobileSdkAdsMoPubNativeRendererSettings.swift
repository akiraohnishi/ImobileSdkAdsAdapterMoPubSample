//
//  ImobileSdkAdsMoPubNativeRendererSettings.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation
import MoPub

class ImobileSdkAdsMoPubNativeRendererSettings<T> : NSObject, MPNativeAdRendererSettings {
    var viewSizeHandler: MPNativeViewSizeHandler!

    var creationHandler: (() -> T)!

    override init() {
        NSLog("[\(type(of: self)) \(#function)]")

        super.init()
    }
}
