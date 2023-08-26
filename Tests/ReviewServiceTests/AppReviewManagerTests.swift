//
//  AppReviewManagerTests.swift
//  
//
//  Created by CHARNPREET SINGH on 26/8/2023.
//

import XCTest
@testable import ReviewService

class AppReviewManagerTests: XCTestCase {

    var userDefaults: UserDefaults!
    var reviewManager: AppReviewManager!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        reviewManager = AppReviewManager(userDefaults: userDefaults)
    }

    override func tearDown() {
        userDefaults.removePersistentDomain(forName: #file)
        super.tearDown()
    }

    func testReviewCountIncrement() {
        reviewManager.incrementReviewCount()
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 1)
    }

    func testReviewCountReset() {
        reviewManager.incrementReviewCount()
        reviewManager.resetReviewCount()
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 0)
    }

    func testAppVersionUpdate() {
        reviewManager.updateAppVersion(with: "1.0.1")
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.1")
    }

    func testReviewRequestOnNewVersion() {
        reviewManager.incrementReviewCount()
        reviewManager.incrementReviewCount()
        reviewManager.incrementReviewCount()
        reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.1")
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 0)
    }

    func testReviewRequestOnSameVersion() {
        reviewManager.incrementReviewCount()
        reviewManager.incrementReviewCount()
        reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 3)
    }

    func testReviewRequestOnThreshold() {
        reviewManager.incrementReviewCount()
        reviewManager.incrementReviewCount()
        reviewManager.incrementReviewCount()
        reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 0)
    }
}
