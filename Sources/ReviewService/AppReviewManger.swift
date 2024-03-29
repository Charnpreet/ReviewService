////
////  AppStoreReviewHandler.swift
////  ReviewService
////
////  Created by CHARNPREET SINGH on 22/7/21.

import Foundation
import StoreKit
import UIKit

public protocol ReviewManager {
    func requestReviewIfAppropriate(countToShowReview: Int, currentVersion: String)
}

public final class AppReviewManager: ReviewManager {
    private let userDefaults: UserDefaults
    private let lastRequestCountKey = "lastRequestCountKey"
    private let lastRequestAppVersion = "lastRequestAppVersion"

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func requestReviewIfAppropriate(countToShowReview: Int, currentVersion: String) {
        guard getLastVersionPromotedForReview() != nil else {
            incrementReviewCount()
            updateAppVersion(with: currentVersion)
            return
        }

        incrementReviewCount()
        let updatedReviewCount = getCount(for: lastRequestCountKey) // Get the updated count
        requestReviewIfNeeded(currentReviewCount: updatedReviewCount, countToShowReview: countToShowReview, currentVersion: currentVersion)
    }

    // MARK: - Private Helper Methods

    internal func requestReviewIfNeeded(currentReviewCount: Int, countToShowReview: Int, currentVersion: String) {
        if currentReviewCount >= countToShowReview {
            requestReview()
            resetReviewCount()
            updateAppVersion(with: currentVersion)
        }
    }
    internal func getCount(for key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }

    internal func incrementReviewCount() {
        let currentCount = getCount(for: lastRequestCountKey)
        userDefaults.set(currentCount + 1, forKey: lastRequestCountKey)
    }

    internal func resetReviewCount() {
        userDefaults.set(0, forKey: lastRequestCountKey)
    }

    internal func getLastVersionPromotedForReview() -> String? {
        return userDefaults.string(forKey: lastRequestAppVersion)
    }

    internal func updateAppVersion(with version: String) {
        userDefaults.set(version, forKey: lastRequestAppVersion)
    }

    internal func requestReview() {
        if #available(iOS 14.0, *) {
            guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
}
