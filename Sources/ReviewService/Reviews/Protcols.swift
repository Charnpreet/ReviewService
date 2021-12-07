//
//  Reviewable.swift
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
