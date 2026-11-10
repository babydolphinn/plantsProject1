import Foundation

struct Plant: Identifiable { /* indentifiable tells swift that every plant has unique id*/
    var id = UUID() /* unique identifier for plants, in case there's plants with same name*/
    
    var name: String
    var room: Room
    var light: Light
    var wateringDays: WateringDays
    var water: Water
    
    var createdAt = Date() /* creation date, Date() gets the current date and time.*/
    var lastWateredAt: Date? = nil /* when the plant was last watered, '?' means the value is optional. For example, when you first add a plant, you might not have watered it yet. therefore it can be a date value or nil, '= nil' is the deafault value*/
}
