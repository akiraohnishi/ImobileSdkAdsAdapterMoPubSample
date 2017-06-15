//
//  ViewController.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import UIKit
import MoPub

class ViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 4.0
        flowLayout.minimumInteritemSpacing = 4.0

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.alwaysBounceVertical = true

        view.allowsMultipleSelection = true

        return view
    }()

    var placer: MPCollectionViewAdPlacer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .gray

        configureCollectionView()
        setupMopubAdPlacer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureCollectionView() {
        self.collectionView.backgroundColor = .gray
        self.collectionView.isHidden = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)

        self.view.addSubview(self.collectionView)

        let topConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)

        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
            ])
    }

    func setupMopubAdPlacer() {
        NSLog("[\(type(of: self)) \(#function)]")

        let nativeAdSettings: MPStaticNativeAdRendererSettings = MPStaticNativeAdRendererSettings()
        nativeAdSettings.renderingViewClass = ProgramListItemAdPlacerView.self
        nativeAdSettings.viewSizeHandler = { (maximumWidth: CGFloat) -> CGSize in
            let ratio: CGFloat = 201.0 / 269.0
            let imageHeight = floor(maximumWidth * 0.9 * 0.45 * ratio)

            // imageHeight + top/bottom margin ( 6px )
            let adViewHeight: CGFloat = imageHeight + 12.0

            return CGSize(width: maximumWidth, height: adViewHeight)
        }

        let imobileAdSettings: ImobileSdkAdsMoPubNativeRendererSettings = ImobileSdkAdsMoPubNativeRendererSettings<ProgramListItemAdPlacerView>()
        imobileAdSettings.viewSizeHandler = { (maximumWidth: CGFloat) -> CGSize in
            let ratio: CGFloat = 201.0 / 269.0
            let imageHeight = floor(maximumWidth * 0.9 * 0.45 * ratio)

            // imageHeight + top/bottom margin ( 6px )
            let adViewHeight: CGFloat = imageHeight + 12.0

            return CGSize(width: maximumWidth, height: adViewHeight)
        }

        imobileAdSettings.creationHandler = {
            return ProgramListItemAdPlacerView()
        }

        let nativeAdConfig: MPNativeAdRendererConfiguration = MPStaticNativeAdRenderer.rendererConfiguration(with: nativeAdSettings)
        let imobileAdConfig = ImobileSdkAdsMoPubNativeAdRenderer.rendererConfiguration(with: imobileAdSettings)!

        let adConfigs = [nativeAdConfig, imobileAdConfig]

        let positioning: MPClientAdPositioning = MPClientAdPositioning()
        positioning.addFixedIndexPath(IndexPath(row: 1, section: 0))

        self.placer = MPCollectionViewAdPlacer(collectionView: self.collectionView, viewController: self, adPositioning: positioning, rendererConfigurations: adConfigs)
        self.placer.delegate = self

        self.placer.loadAds(forAdUnitID: Constants.mopubAdUnitId)
    }
}

// MARK:- UICollectionView delegate methods

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = self.collectionView.mp_dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell

        cell.label.text = "\(indexPath)"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 139)
    }
}

// MARK:- MPCollectionViewAdPlacerDelegate

extension ViewController : MPCollectionViewAdPlacerDelegate {
    func nativeAdWillPresentModal(for placer: MPCollectionViewAdPlacer!) {
        NSLog("[\(type(of: self)) \(#function)]")
    }

    func nativeAdDidDismissModal(for placer: MPCollectionViewAdPlacer!) {
        NSLog("[\(type(of: self)) \(#function)]")
    }

    func nativeAdWillLeaveApplication(from placer: MPCollectionViewAdPlacer!) {
        NSLog("[\(type(of: self)) \(#function)]")
    }
}

