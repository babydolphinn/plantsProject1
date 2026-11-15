import Foundation

/* allows Swift to convert your enum values into a format that can be saved and loaded. */
enum Room: String, CaseIterable, Identifiable, Codable{
    var id: String { rawValue }
    
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case bathroom = "Bathroom"
    case balcony = "Balcony"
}




enum Light: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }

    // Keep these EXACT values.
    // SwiftData uses them to decode saved plants.
    case fullSun = "Full sun"
    case partialLight = "Partial sun"
    case lowLight = "Low sun"

    // Icons are separate from saved data.
    var symbol: String {
        switch self {
        case .fullSun:
            return "sun.max"
        case .partialLight:
            return "sun.horizon"
        case .lowLight:
            return "moon"
        }
    }
}



enum WateringDays: String, CaseIterable, Identifiable, Codable{
    var id: String { rawValue }
    
    var numberOfDays: Int {
        switch self {
        case .everyDay:
            return 1
        case .every2Days:
            return 2
        case .every3Days:
            return 3
        case .onceAWeek:
            return 7
        case .every10Days:
            return 10
        case .every2Weeks:
            return 14
        }
    } /* Your Picker displays text like "Once a week", but the app needs the number 7 to calculate when the next watering is due.
       
       This is called computed property because Swift calculates its value instead of storing it separately.*/

    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}


enum Water: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"
}

