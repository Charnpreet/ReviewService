//
//  AppReview_Tests.swift
//  ReviewServiceTests
//
//  Created by CHARNPREET SINGH on 25/8/21.
//

import XCTest
@testable import ReviewService
class AppReviewTests: XCTestCase {
    var reviewHandler: ReviewHandler!
    var userDefaults: UserDefaults!
    var manager: PreferenceDelegator!
    var sceneProvider: SceneProvider!
    let lastRequestCountKey = "InstLastReviewRequestKey"
    let lastRequestappVersion = "InstLastReviewAppVersion"
    override func setUp() {
        userDefaults = UserDefaults.standard
        sceneProvider = SceneProvider()
        manager = ReviewPreferenceManger(userDfaults: userDefaults)
        reviewHandler = AppStoreReviewController(preferenceManger: manager, sceneProvider: sceneProvider, totalCountToShowReview: 4, currentVersion: "2.3")
    }

    override func tearDown() {
        userDefaults = nil
        sceneProvider = nil
        manager = nil
        reviewHandler = nil
        resetUserDefaults()
    }
    /*helper function to reset User Defaults*/
    private func resetUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func test_appVersion_is_Set_And_Count_Is_Updated_If_Its_new_user() {
        let countBeforePopupCalled = manager.getCount(for: lastRequestCountKey)
        reviewHandler.showReviewPopUp()
        let count = manager.getCount(for: lastRequestCountKey)
        XCTAssertTrue(count == countBeforePopupCalled + 1, "count is not updated when its new user")
        let previousVersion = manager.getLastVersionPromotedForReview(for: lastRequestappVersion )
        XCTAssertNotNil(previousVersion, "app has version")
        
    }
    
    func test_only_update_Count_When_Its_newVersion() {
        let countBeforePopupCalled = manager.getCount(for: lastRequestCountKey)
        let currentVersion = reviewHandler.currentVersion
        manager.updateAppVersion(versionToBeUpdated: currentVersion + ".1", using: lastRequestappVersion )
        reviewHandler.showReviewPopUp()
        let count = manager.getCount(for: lastRequestCountKey)
        XCTAssertTrue(count == countBeforePopupCalled + 1, "count is not updated when its a new Version")
    }
    
    func test_app_is_not_Updating_Count_when_Its_not_A_New_Version() {
        let countBeforePopupCalled = manager.getCount(for: lastRequestCountKey)
        let currentVersion = reviewHandler.currentVersion
        manager.updateAppVersion(versionToBeUpdated: currentVersion, using: lastRequestappVersion )
        reviewHandler.showReviewPopUp()
        let count = manager.getCount(for: lastRequestCountKey)
        XCTAssertTrue(count == countBeforePopupCalled, "count is updated on the same versions")
    }
    
    func test_update_AppVersion_And_Reset_Count_Once_PopUp_Is_Shown() {
        let isEmpty: Int = 0
        let currentVersion = reviewHandler.currentVersion
        manager.updateAppVersion(versionToBeUpdated: "\(currentVersion)" + ".1", using: lastRequestappVersion)
        manager.updateCount(count: 5, using: lastRequestCountKey)
        reviewHandler.showReviewPopUp()
        let newVersionSet =  manager.getLastVersionPromotedForReview(for: lastRequestappVersion)
        let count = manager.getCount(for: lastRequestCountKey)
        XCTAssert(count == isEmpty, "Count is not reseted after showing review popup \(count)")
        XCTAssert(currentVersion == newVersionSet, "App Version is not updated after showing review popup")
    }
    
}
