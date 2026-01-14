enum Frequency: String, Codable, Equatable {
    case daily = "daily"
    case twice_daily = "twice_daily"
    case weekly = "weekly"
    case as_needed = "as_needed"
    
    var rawValue: String {
        switch self {
        case .daily(_) : return "Daily"
        case .twice_daily(_,_): return "Twice Daily"
        case .weekly(_, _): return "Weekly"
        case .as_needed: return "As Needed"
        }
    }
}