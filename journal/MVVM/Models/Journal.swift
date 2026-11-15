//
//  Journal.swift
//  journal
//
//  Created by layan alshehri on 04/06/1448 AH.
//

import Foundation
struct Journal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date = Date()
    var isBookmarked: Bool = false
}
