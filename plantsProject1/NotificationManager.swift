
import Foundation
import SwiftData
import UserNotifications

@MainActor
final class NotificationManager {

    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()
    private let prefix = "planto.watering."
    private let maximumNotifications = 60

    private init() {}

    // Update notifications to match saved plants.
    func synchronize(
        context: ModelContext,
        askPermission: Bool = false
    ) async {

        // Ask permission only after saving a new plant.
        if askPermission {
            let settings = await center.notificationSettings()

            if settings.authorizationStatus == .notDetermined {
                do {
                    _ = try await center.requestAuthorization(
                        options: [.alert, .badge, .sound]
                    )
                } catch {
                    print("Notification permission error: \(error)")
                }
            }
        }

        let settings = await center.notificationSettings()

        guard settings.authorizationStatus == .authorized ||
              settings.authorizationStatus == .provisional else {
            return
        }

        // Load the latest plant data from SwiftData.
        let plants: [Plant]

        do {
            plants = try context.fetch(
                FetchDescriptor<Plant>()
            )
        } catch {
            print("Could not fetch plants: \(error)")
            return
        }

        // Remove Planto's old scheduled notifications.
        let pending = await center.pendingNotificationRequests()

        let oldIDs = pending
            .map(\.identifier)
            .filter { $0.hasPrefix(prefix) }

        center.removePendingNotificationRequests(
            withIdentifiers: oldIDs
        )

        // Collect future reminders for all plants.
        var reminders: [(date: Date, plant: Plant)] = []

        let calendar = Calendar.current
        let now = Date()

        // Schedule reminders across the next 60 days.
        let endDate = calendar.date(
            byAdding: .day,
            value: 60,
            to: now
        ) ?? now

        for plant in plants {

            let interval = plant.wateringDays.numberOfDays

            // First watering is due when the plant is added.
            // Later waterings follow the selected interval.
            let startingDay: Date

            if let lastWatered = plant.lastWateredAt {
                startingDay = calendar.date(
                    byAdding: .day,
                    value: interval,
                    to: calendar.startOfDay(for: lastWatered)
                ) ?? lastWatered
            } else {
                startingDay = calendar.startOfDay(
                    for: plant.createdAt
                )
            }

            var day = startingDay

            // Find the next scheduled 9:00 AM.
            while day <= endDate {

                if let fireDate = calendar.date(
                    bySettingHour: 9,
                    minute: 0,
                    second: 0,
                    of: day
                ), fireDate > now {

                    reminders.append((
                        date: fireDate,
                        plant: plant
                    ))
                }

                guard let nextDay = calendar.date(
                    byAdding: .day,
                    value: interval,
                    to: day
                ) else {
                    break
                }

                day = nextDay
            }
        }

        // iOS limits the number of pending notifications.
        // Schedule the earliest reminders first.
        reminders.sort { $0.date < $1.date }

        for reminder in reminders.prefix(maximumNotifications) {

            let content = UNMutableNotificationContent()

            content.title = "Time to water 💧"
            content.body =
                "\(reminder.plant.name) in " +
                "\(reminder.plant.room.rawValue) needs " +
                "\(reminder.plant.water.rawValue)"

            content.sound = .default

            let dateComponents = calendar.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: reminder.date
            )

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: false
            )

            let identifier =
                prefix +
                reminder.plant.id.uuidString +
                "." +
                String(Int(reminder.date.timeIntervalSince1970))

            let request = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: trigger
            )

            do {
                try await center.add(request)
            } catch {
                print("Could not schedule notification: \(error)")
            }
        }
    }
}

