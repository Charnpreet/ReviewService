//
//  ModuleFactory.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation

public final class ReviewFactory: ReviewModuleFactory {
    public init () {}
    public func make(with countToshowReview: Int) -> AppReviewPresenter {
        let userDefaults = UserDefaults.standard
        let manager = ReviewPreferenceManger(userDfaults: userDefaults)
        let sceneProvider = SceneProvider()
        let reviewController = AppStoreReviewController(preferenceManger: manager, sceneProvider: sceneProvider, versionHander: AppVersionHandler(), totalCountToShowReview: countToshowReview)
        return AppStoreReviews(appStoreController: reviewController)
    
   }
}
