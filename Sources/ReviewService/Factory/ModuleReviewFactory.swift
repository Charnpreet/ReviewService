//
//  ModuleFactory.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation

@available(*, deprecated, message: "Use AppStoreReviewService instead.")
public protocol ReviewModuleFactory {
    func make(with countToShowReview: Int, currentVersion version: String) -> AppReviewPresenter
}

@available(*, deprecated, message: "Use AppStoreReviewService instead.")
public final class ReviewFactory: ReviewModuleFactory {

    public init() {}

    public func make(with countToShowReview: Int, currentVersion version: String) -> AppReviewPresenter {
        let manager = ReviewPreferenceManager()
        let sceneProvider = SceneProvider()
        let reviewController = AppStoreReviewController(preferenceManager: manager, sceneProvider: sceneProvider, totalCountToShowReview: countToShowReview, currentVersion: version)
        return AppStoreReviews(appStoreController: reviewController)
    }
}

public protocol AppStoreReviewPresenterFactory {
    func showReviewPopup(after reviewCountThreshold: Int, on currentVersion: String)
}

public class AppStoreReviewService: AppStoreReviewPresenterFactory {

    public init() {}

    private func getAppReviewPresenter(after reviewCountThreshold: Int, on currentVersion: String) -> AppReviewPresenter {
        let manager = ReviewPreferenceManager()
        let sceneProvider = SceneProvider()
        let reviewController = AppStoreReviewController(preferenceManager: manager, sceneProvider: sceneProvider, totalCountToShowReview: reviewCountThreshold, currentVersion: currentVersion)
        return AppStoreReviews(appStoreController: reviewController)
    }

    public func showReviewPopup(after reviewCountThreshold: Int, on currentVersion: String) {
        let presenter = getAppReviewPresenter(after: reviewCountThreshold, on: currentVersion)
        presenter.presentReviewView()
    }
}
