//
//  VersionHandler.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 24/8/21.
//

import Foundation

class AppVersionHandler {
    func getCurrentAppVersion() -> String? {
        let infoDictionaryKey = kCFBundleVersionKey as String
        return Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
    }
}
