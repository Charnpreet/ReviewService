//
//  AppStoreReviews.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 9/7/21.
//

import Foundation

public protocol AppReviewPresenter {
    func presentReviewView()
}

public protocol ReviewHandler {
    func showReviewPopUp()
    var currentVersion: String {get}
}

/// review class to request automatic reviews at certains stage of your app
/// ideally not at launch of an app or in between the tasks
public final class AppStoreReviews: NSObject, AppReviewPresenter {
    fileprivate var appStoreController: ReviewHandler
    public init(appStoreController: ReviewHandler) {
        self.appStoreController = appStoreController
    }
    /// handles navigation from viewController
    /// ideally should be called in method view Disappear
    public func presentReviewView() {
        appStoreController.showReviewPopUp()
    }

}
