# Planto 🌱
### Plant Care Reminders

**Planto** is a native iOS application that helps you keep track of your plants and their watering schedules. Add your plants, organize their care details, and stay on top of daily watering reminders with a simple, friendly interface.

Designed in **Sketch** and developed using **SwiftUI**, Planto combines plant care with Apple's Liquid Glass design.

## Features

- 🌱 **Plant Management** — Add plants with their name, room, light requirements, watering frequency, and water amount.
- 💧 **Watering Reminders** — View plants that need watering today based on their selected schedules.
- ✅ **Daily Progress** — Mark plants as watered and track your progress with an animated progress bar.
- ✏️ **Edit & Delete** — Update plant information, delete reminders, or swipe left to remove a plant.
- 🔔 **Local Notifications** — Receive scheduled watering notifications on your iPhone.
- 🎉 **Completion Screen** — See a celebration screen when all of today's reminders are completed.
- 🌙 **Dark Interface** — A consistent dark appearance with native Liquid Glass buttons.

## Technologies Used

| Technology | Purpose |
|---|---|
| Swift | Programming language |
| SwiftUI | Building the user interface |
| SwiftData | Local plant data storage |
| UserNotifications | Scheduling local watering notifications |
| MVVM | Separating data, logic, and views |
| Sketch | UI/UX design |
| Icon Composer | Creating the app icon |
| Xcode | Development and testing |

## App Screens

Planto includes:

- **Welcome Screen** — First-time experience with a "Set Plant Reminder" button.
- **My Plants** — Today's watering reminders and progress.
- **Set Reminder** — Form for adding a plant.
- **Edit Reminder** — Edit existing plant details or delete a reminder.
- **No Reminders** — Empty state when no reminders are due.
- **All Reminders Completed** — Celebration after completing daily reminders.

## Project Structure

```text
plantsProject1/
├── Models/
│   ├── Plant.swift
│   └── PlantOptions.swift
├── ViewModels/
│   └── PlantViewModel.swift
├── Views/
│   ├── Components/
│   ├── ContentView.swift
│   ├── SetReminderView.swift
│   ├── StartPlantJourneyView.swift
│   └── AllRemindersCompletedView.swift
├── Theme/
│   ├── AppColors.swift
│   ├── AppTypography.swift
│   └── AppSpacing.swift
├── NotificationManager.swift
├── MyApp.swift
└── Assets.xcassets/
```

## How It Works

1. Open Planto and add your first plant.
2. Enter its care information and choose a watering interval.
3. View the plants that need watering today.
4. Mark a plant as watered after taking care of it.
5. Track your daily progress and receive reminders for upcoming watering dates.

Plant information is saved locally using SwiftData, so the app doesn't require an internet connection or a separate backend for its core functionality.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/babydolphinn/plantsProject1.git
   ```

2. Open `Planto.xcodeproj` in Xcode.
3. Select an iPhone simulator or a connected iPhone.
4. Configure your development team under **Signing & Capabilities** if needed.
5. Build and run the application.

When prompted, allow notifications to receive watering reminders.

## Design System

Planto uses a centralized design system to keep the interface consistent.

- `AppColors.swift` defines the application's color palette.
- `AppTypography.swift` defines the typography.
- `AppSpacing.swift` defines spacing and corner-radius values.
- `MyApp.swift` applies the dark appearance throughout the app.

The interface uses a black background, green accents, rounded cards, and Liquid Glass controls.

## Notifications

Planto uses local notifications through Apple's `UserNotifications` framework.

Watering reminders are scheduled for **9:00 AM** according to each plant's watering frequency. The app updates its notification schedule when plants are added, edited, deleted, or marked as watered.

Notification delivery requires the user's permission and is subject to iOS scheduling behavior.

## About the Project

Planto is an iOS development project focused on learning and applying SwiftUI, SwiftData, MVVM architecture, local notifications, reusable components, and Apple's modern interface design principles.

The goal is to create a simple and enjoyable experience that makes caring for plants easier.
