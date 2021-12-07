//
//  ModuleFactory.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation

public protocol ReviewModuleFactory {
    func  make(with countToshowReview: Int, currentVerion version: String) -> AppReviewPresenter
}

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
