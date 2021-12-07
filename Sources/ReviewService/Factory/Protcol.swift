//
//  Protcol.swift
//  ReviewService
//
//  Created by CHARNPREET SINGH on 24/8/21.
//

import Foundation
public protocol ReviewModuleFactory {
    func  make(with countToshowReview: Int) -> AppReviewPresenter
}
