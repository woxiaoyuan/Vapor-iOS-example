//
//  ModelType.swift
//  Allison-Vapor-iOS-App
//
//  Created by 耶啵的小头盔 on 12/29/22.
//

import Foundation

enum ModelType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    case add
    case update(Song)
}
