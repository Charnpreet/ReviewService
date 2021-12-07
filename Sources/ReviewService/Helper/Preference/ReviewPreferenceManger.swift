//
//  PreferenceManger.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation
class ReviewPreferenceManger: PreferenceDelegator {
    let userDefaults: UserDefaults
    
    init(userDfaults: UserDefaults) {
        self.userDefaults = userDfaults
    }
    func getCount(for key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    func updateCount(count: Int, using key: String) {
        userDefaults.set(count, forKey: key)
    }
    
    func getLastVersionPromotedForReview(for key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func updateAppVersion(versionToBeUpdated version: String, using key: String) {
        userDefaults.set(version, forKey: key)
    }
}
