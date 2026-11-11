
import Foundation
import SwiftData

/* @MainActor means that the class's work is coordinated through the Main Actor, helping us safely manage UI-related state and our SwiftData context.*/
@MainActor
final class PlantViewModel {

    func addPlant(
        name: String,
        room: Room,
        light: Light,
        wateringDays: WateringDays,
        water: Water,
        context: ModelContext
    )
    {
        let plant = Plant(
            name: name,
            room: room,
            light: light,
            wateringDays: wateringDays,
            water: water
        )

        context.insert(plant)
    }
    
    func toggleWatered(plant: Plant) {

        // If already watered today, uncheck it.
        if let lastWatered = plant.lastWateredAt,
           Calendar.current.isDateInToday(lastWatered) {
            plant.lastWateredAt = nil
        } else {
            // Otherwise, mark it as watered now.
            plant.lastWateredAt = Date()
        }
    }

}

