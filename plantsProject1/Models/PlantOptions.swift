import Foundation

enum Room: String, CaseIterable{
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case bathroom = "Bathroom"
    case homeOffice = "Home Office"
    case balcony = "Balcony"
}


enum Light: String, CaseIterable {
    case fullSun = "Full sun"
    case partialLight = "Partial Light"
    case lowLight = "Low light"
}

enum WateringDays: String, CaseIterable{
    case everyday = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}


enum Water: String, CaseIterable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"
}
