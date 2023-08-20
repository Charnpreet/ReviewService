//
//  AppStoreReviewHandler.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation
import StoreKit
import UIKit

public class ReviewService {
    private let preferenceManager = ReviewPreferenceManager()
    private let reviewCountKey = "InstLastReviewRequestKey"
    private let lastReviewVersionKey = "InstLastReviewAppVersionKey"

    public init() {}

    public func showReviewPopup(after reviewCountThreshold: Int, on currentVersion: String) {
        let currentCount = preferenceManager.getCount(for: reviewCountKey)
        let lastVersion = preferenceManager.getLastVersionPromotedForReview(for: lastReviewVersionKey)

        if let lastVersion = lastVersion, lastVersion == currentVersion {
            if currentCount >= reviewCountThreshold {
                requestReview()
                preferenceManager.updateCount(count: 0, using: reviewCountKey)
            } else {
                preferenceManager.updateCount(count: currentCount + 1, using: reviewCountKey)
            }
        } else {
            preferenceManager.updateCount(count: 1, using: reviewCountKey)
            preferenceManager.updateAppVersion(versionToBeUpdated: currentVersion, using: lastReviewVersionKey)
        }
    }

    private func requestReview() {
        if #available(iOS 14.0, *) {
            guard let scene = connectedScene() else { return }
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }

    private func connectedScene() -> UIWindowScene? {
        return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
