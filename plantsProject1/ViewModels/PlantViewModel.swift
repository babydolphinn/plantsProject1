
import Foundation
import SwiftData

@MainActor
final class PlantViewModel {

    // Save a new plant
    func addPlant(
        name: String,
        room: Room,
        light: Light,
        wateringDays: WateringDays,
        water: Water,
        context: ModelContext
    ) {
        let plant = Plant(
            name: name,
            room: room,
            light: light,
            wateringDays: wateringDays,
            water: water
        )

        context.insert(plant)
    }

    // Check whether a plant was watered today
    func isWateredToday(_ plant: Plant) -> Bool {
        guard let lastWatered = plant.lastWateredAt else {
            return false
        }

        return Calendar.current.isDateInToday(lastWatered)
    }

    // Calculate the next watering date
    func nextWateringDate(for plant: Plant) -> Date {

        // A plant that has never been watered
        // gets its first reminder on the day it was added.
        guard let lastWatered = plant.lastWateredAt else {
            return Calendar.current.startOfDay(
                for: plant.createdAt
            )
        }

        let wateringDay = Calendar.current.startOfDay(
            for: lastWatered
        )

        return Calendar.current.date(
            byAdding: .day,
            value: plant.wateringDays.numberOfDays,
            to: wateringDay
        ) ?? wateringDay
    }

    // Check if a plant belongs in today's reminders
    func isDueToday(_ plant: Plant) -> Bool {

        // Keep completed plants visible for the rest of today.
        if isWateredToday(plant) {
            return true
        }

        let today = Calendar.current.startOfDay(for: Date())

        return nextWateringDate(for: plant) <= today
    }

    // Mark a plant as watered or undo today's completion
    func toggleWatered(plant: Plant) {

        if isWateredToday(plant) {
            plant.lastWateredAt = nil
        } else {
            plant.lastWateredAt = Date()
        }
    }
}

