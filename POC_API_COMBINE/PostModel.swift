//
//  PostModel.swift
//  POC_API_COMBINE
//
//  Created by Kiran Sonne on 01/08/24.
//

import Foundation
struct PostModel: Codable, Identifiable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}
