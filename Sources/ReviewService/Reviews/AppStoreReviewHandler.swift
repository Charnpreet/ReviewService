//
//  AppStoreReviewHandler.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation
import StoreKit

final class AppStoreReviewController: ReviewHandler {
    let lastRequestCountKey = "InstLastReviewRequestKey"
    let lastRequestappVersion = "InstLastReviewAppVersion"
    let reviewPreferenceManger: PreferenceDelegator
    let sceneProvider: SceneProviderDelegator
    let totalCountToShowReview: Int
    let version: String
    
    var currentVersion: String {
        version
    }
    
    
    public init(preferenceManger: PreferenceDelegator, sceneProvider: SceneProviderDelegator, totalCountToShowReview: Int, currentVersion: String) {
        self.reviewPreferenceManger = preferenceManger
        self.sceneProvider = sceneProvider
        self.totalCountToShowReview = totalCountToShowReview
        self.version = currentVersion
    }

    public func showReviewPopUp() {
        requestReviewIfNeeded()
    }
    
    private func requestReviewIfNeeded() {
        let addValueToCount: Int = 1
        let currentVersion =  self.version
        guard let previousVersion = reviewPreferenceManger.getLastVersionPromotedForReview(for: lastRequestappVersion) else {
            /*
             * means this is new user, so we should update count as well as save current version
             */
            let reviewCount = getReviewCount() + addValueToCount
            updateReviewsCount(count: reviewCount)
            updateAppVersion(with: currentVersion)
            return
        }
        
        if isItNewAppVersion(versionToBeChecked: currentVersion, checkAgainst: previousVersion) {
            let reviewCount = getReviewCount() + addValueToCount
            updateReviewsCount(count: reviewCount)
            requestReviewIfAppropriate(count: reviewCount, currentVersion: currentVersion)
        }
        
    }
    private func isItNewAppVersion(versionToBeChecked version: String, checkAgainst previousVersion: String) -> Bool {
        return version != previousVersion
    }
    
    private func getReviewCount() -> Int {
        return reviewPreferenceManger.getCount(for: lastRequestCountKey)
    }
    
    private func updateReviewsCount (count: Int) {
        reviewPreferenceManger.updateCount(count: count, using: lastRequestCountKey)
    }
 
    private func requestReviewIfAppropriate(count: Int, currentVersion: String) {
        if count > totalCountToShowReview {
            requestReview(for: currentVersion)
            resetCountToZero()
            updateAppVersion(with: currentVersion)
        }
    }
    
    private func requestReview(for currentVersion: String) {
        if #available(iOS 14.0, *) {
            guard let scene = sceneProvider.getConnectedScene() else {return}
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func resetCountToZero() {
        updateReviewsCount(count: 0)
    }
    
    private func updateAppVersion(with currentVersion: String) {
        reviewPreferenceManger.updateAppVersion(versionToBeUpdated: currentVersion, using: lastRequestappVersion)
    }
}
