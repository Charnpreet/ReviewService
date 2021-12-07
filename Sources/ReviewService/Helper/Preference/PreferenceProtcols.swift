//
//  Protcols.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 24/8/21.
//

import Foundation

 protocol PreferenceDelegator {
    func getCount(for key: String) -> Int
    func updateCount(count: Int, using key: String)
    func getLastVersionPromotedForReview(for key: String) -> String?
    func updateAppVersion(versionToBeUpdated version: String, using key: String)
}

protocol AppBundlableDelegator {
    func getCurrentAppVersion() -> String?
}
