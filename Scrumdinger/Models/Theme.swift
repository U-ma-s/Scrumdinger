//
//  Theme.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/15
//  
//

import SwiftUI

enum Theme: String, Identifiable, CaseIterable, Codable {//CaseIterableに準拠することで，enumの全ての要素にallCasesでアクセスできる
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized//case名を大文字に
    }
    
    var id: String {
        name
    }
}
