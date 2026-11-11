import Foundation
import SwiftData /* Apple's framework for storing information on the device.*/


/* @Model tells SwiftData that this type represents information we want to save.
        class replaces struct because SwiftData's @Model requires a class.
        final means other classes cannot inherit from Plant*/
@Model
final class Plant {
    var id = UUID() /* unique identifier for plants, in case there's plants with same name*/
    
    var name: String
    var room: Room
    var light: Light
    var wateringDays: WateringDays
    var water: Water
    
    var createdAt = Date() /* creation date, Date() gets the current date and time.*/
    var lastWateredAt: Date? = nil /* when the plant was last watered, '?' means the value is optional. For example, when you first add a plant, you might not have watered it yet. therefore it can be a date value or nil, '= nil' is the deafault value*/
    
    init(
        name: String,
        room: Room,
        light: Light,
        wateringDays: WateringDays,
        water: Water
    ) {
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.water = water
    }

}

#if DEBUG
extension Plant {
    static var example: Plant {
        Plant(
            name: "Monstera",
            room: .kitchen,
            light: .fullSun,
            wateringDays: .everyDay,
            water: .small
        )
    }
}
#endif
