//
//  SceneProvider.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 22/7/21.
//

import Foundation
import StoreKit

protocol SceneProviderDelegator {
    func getConnectedScene() -> UIWindowScene?
}

struct SceneProvider: SceneProviderDelegator {
    func getConnectedScene() -> UIWindowScene? {
        return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
