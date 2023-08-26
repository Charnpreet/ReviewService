//  AppReviewManagerTests.swift
//
//
//  Created by CHARNPREET SINGH on 26/8/2023.

import XCTest
@testable import ReviewService

// Mock for UserDefaults
class UserDefaultsMock: UserDefaults {
    var mockValues: [String: Any] = [:]

    override func integer(forKey defaultName: String) -> Int {
        return mockValues[defaultName] as? Int ?? 0
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        mockValues[defaultName] = value
    }

    override func string(forKey defaultName: String) -> String? {
        return mockValues[defaultName] as? String
    }
}

class AppReviewManagerTests: XCTestCase {

    var userDefaultsMock: UserDefaultsMock!
    var reviewManager: AppReviewManager!

    override func setUp() {
        super.setUp()
        userDefaultsMock = UserDefaultsMock()
        reviewManager = AppReviewManager(userDefaults: userDefaultsMock)
    }

    
    func testAppVersionUpdate() {
        reviewManager.updateAppVersion(with: "1.0.1")
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.1")
    }

    func testReviewRequestOnNewVersion() {
        for _ in 1...2 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }
        reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.1")
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 0)
    }

    func testReviewRequestOnSameVersion() {
        for _ in 1...2 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 2)
    }

    func testNewUserScenario() {
        // Ensure no stored version initially
        XCTAssertNil(reviewManager.getLastVersionPromotedForReview())

        // Call the method
        reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")

        // Check if the review count is incremented to 1
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 1)

        // Check if the current version is saved
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.0")
    }

    func testReviewCountIncrement() {
        // Set an initial version to simulate a non-new user scenario
        reviewManager.updateAppVersion(with: "1.0.0")
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.0")

        // Call the method once
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.0")
        // Check if the review count is incremented to 1
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 1)

        // Call the method again
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.0")
        // Check if the review count is incremented to 2
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 2)

        // Call the method one more time
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.0")
        // Check if the review count is incremented to 3
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 3)
    }

    func testReviewRequestOnThreshold() {
        // Set an initial version to simulate a non-new user scenario
        reviewManager.updateAppVersion(with: "1.0.0")
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.0")

        // Call the method to reach the threshold
        for _ in 1...3 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }

        // Check if the review count is reset to 0
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 0)
    }

    func testReviewCountContinuation() {
        // Set an initial version to simulate a non-new user scenario
        reviewManager.updateAppVersion(with: "1.0.0")
        XCTAssertEqual(reviewManager.getLastVersionPromotedForReview(), "1.0.0")

        // Call the method twice, which is less than the threshold of 3
        for _ in 1...2 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }

        // Check if the review count is incremented to 2 and not reset
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 2)
    }

    func testMultipleVersionChangesWithoutReachingThreshold() {
        // Call the method with different versions
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.0")
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.1")
        reviewManager.requestReviewIfAppropriate(countToShowReview: 4, currentVersion: "1.0.2")

        // Check if the review count is incremented to 3 and not reset
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 3)
    }

    func testReviewCountRightBeforeThreshold() {
        // Call the method twice, which is one less than the threshold of 3
        for _ in 1...2 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }

        // Check if the review count is incremented to 2 and not reset
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 2)
    }

    func testReviewCountRightAfterThreshold() {
        // Call the method four times, which is one more than the threshold of 3
        for _ in 1...4 {
            reviewManager.requestReviewIfAppropriate(countToShowReview: 3, currentVersion: "1.0.0")
        }

        // Check if the review count is reset to 0
        XCTAssertEqual(reviewManager.getCount(for: "lastRequestCountKey"), 1)
    }
}
