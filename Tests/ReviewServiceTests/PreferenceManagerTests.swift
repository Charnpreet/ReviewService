//
//  ReviewServiceTests.swift
//  ReviewServiceTests
//
//  Created by CHARNPREET SINGH on 9/7/21.
//

import XCTest
@testable import ReviewService

class PreferenceManagerTests: XCTestCase {

    var preferenceManager: PreferenceDelegator!
    override func setUp() {
        preferenceManager = ReviewPreferenceManger(userDfaults: UserDefaults.standard)
        super.setUp()
    }
    
    override func tearDown() {
        preferenceManager = nil
        super.tearDown()
    }
    
    func test_count_is_updated_correctly() {
        let count = 0
        preferenceManager.updateCount(count: count, using: "test")
        let newCount = preferenceManager.getCount(for: "test")
        XCTAssertTrue(newCount == count)
    }
    
    func test_app_version_is_updated_correctly() {
        let version = "1.0"
        preferenceManager.updateAppVersion(versionToBeUpdated: version, using: "test")
        let savedVersion = preferenceManager.getLastVersionPromotedForReview(for: "test")
        XCTAssertTrue(savedVersion == version)
    }
    
    func test_only_CurrectKey_gets_CorrectCount() {
        let count = 1
        preferenceManager.updateCount(count: count, using: "test")
        let newCount = preferenceManager.getCount(for: "test-1")
        XCTAssertFalse(newCount == count)
    }
    
    func test_only_CurrectKey_gets_CorrectAppVersion() {
        let version = "1.0"
        preferenceManager.updateAppVersion(versionToBeUpdated: version, using: "test")
        let savedVersion = preferenceManager.getLastVersionPromotedForReview(for: "test-1")
        XCTAssertFalse(savedVersion == version)
    }

}
