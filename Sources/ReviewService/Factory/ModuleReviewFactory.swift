//
//  ModuleFactory.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation

@available(*, deprecated, message: "Use AppStoreReviewPresenterFactory instead.")
public protocol ReviewModuleFactory {
    func  make(with countToshowReview: Int, currentVerion version: String) -> AppReviewPresenter
}

@available(*, deprecated, message: "Use AppStoreReviewService instead.")
public final class ReviewFactory: ReviewModuleFactory {
    
    public init () {}
    public func make(with countToshowReview: Int, currentVerion version: String ) -> AppReviewPresenter {
        let userDefaults = UserDefaults.standard
        let manager = ReviewPreferenceManger(userDfaults: userDefaults)
        let sceneProvider = SceneProvider()
        let reviewController = AppStoreReviewController(preferenceManger: manager, sceneProvider: sceneProvider, totalCountToShowReview: countToshowReview, currentVersion: version)
        return AppStoreReviews(appStoreController: reviewController)
    
   }
}

public protocol AppStoreReviewPresenterFactory {
    func showReviewPopup(after reviewCountThreshold: Int, on currentVersion: String)
}

public class AppStoreReviewService: AppStoreReviewPresenterFactory {

    public init () {}
    
    private func getAppReviewPresenter(after reviewCountThreshold: Int, on currentVersion: String) -> AppReviewPresenter {
        let userDefaults = UserDefaults.standard
        let manager = ReviewPreferenceManger(userDfaults: userDefaults)
        let sceneProvider = SceneProvider()
        let reviewController = AppStoreReviewController(preferenceManger: manager, sceneProvider: sceneProvider, totalCountToShowReview: reviewCountThreshold, currentVersion: currentVersion)
        return AppStoreReviews(appStoreController: reviewController)

   }

    public func showReviewPopup(after reviewCountThreshold: Int, on currentVersion: String) {
          let presenter = getAppReviewPresenter(after: reviewCountThreshold, on: currentVersion)
        presenter.presentReviewView()
    }
}
