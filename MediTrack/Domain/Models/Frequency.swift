//
//  Frequency.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 15/1/2026.
//
//
enum Frequency: String, CaseIterable, Codable {
    case daily = "daily"
    case twiceDaily = "twice_daily"
    case weekly = "weekly"
    case asNeeded = "as_needed"
    
    var displayTitle: String {
        switch self {
        case .daily: return "Daily"
        case .twiceDaily: return "Twice Daily"
        case .weekly: return "Weekly"
        case .asNeeded: return "As Needed"
        }
    }
}

extension Frequency {
    static func fromDisplay(_ value: String) -> Frequency? {
        allCases.first { $0.displayTitle.caseInsensitiveCompare(value) == .orderedSame }
    }
}
