# Architecture Decision Record (ADR)

## Project: MediTrack
**Date:** 15-01-2026 


This document records the key architectural and design decisions made during the development of the MedicationApp, along with the reasoning behind them.

---

## ADR-001: Overall Architecture Pattern

### Decision
Use **Clean Architecture with MVVM** in the presentation layer.

### Context
The application is expected to evolve beyond simple CRUD operations (e.g. reminders, notifications). The codebase should remain maintainable, testable, and easy for a team to extend.

### Considered Options
- MVC / MVVM without strict layering  
- MVVM + Coordinators  
- Clean Architecture + MVVM  
- TCA architecture  
- VIPER

### Rationale
Clean Architecture was chosen to:
- Clearly separate UI, business logic, and data access
- Keep Domain models pure and framework-independent
- Allow the Data layer to be replaced or extended without impacting UI
- Improve testability via protocol-based boundaries

MVVM aligns naturally with SwiftUI, keeping views declarative and lightweight while avoiding unnecessary complexity.

### Consequences
- Slightly more upfront structure
- Stronger long-term maintainability and testability
- Clear extension points for future features

---

## ADR-002: Navigation and Routing Approach

### Decision
Use **SwiftUI’s built-in navigation and sheet presentation**, driven by view state, without introducing a Coordinator or Router layer.

### Context
Navigation requirements are simple:
- Medication list
- Add/edit medication via modal sheets

### Considered Options
- Coordinator    
- SwiftUI `NavigationStack` and `.sheet`  

### Rationale
SwiftUI’s native navigation APIs are sufficient for the current scope. Introducing coordinators would add indirection without clear benefit. Navigation state remains local and explicit, improving readability.

### Consequences
- Simple, readable navigation flow
- Easy to refactor to coordinators later if complexity increases
- Avoids premature abstraction

---

## ADR-003: Simplicity over “Correctness” — Medication Frequency Modeling

### Decision
Model medication frequency as a simple enum (`daily`, `twice_daily`, `weekly`, `as_needed`) without explicit time or scheduling rules in the Domain layer.

### Context
Real-world medication schedules can be complex, but the provided API does not support reminder times, weekly days, or activity-based anchors.

### Rationale
Instead of over-engineering:
- Frequency modeling aligns directly with API capabilities
- Time-based scheduling is intentionally excluded
- The Domain reflects current system constraints

This avoids mismatch between UI, domain, and backend while keeping the design extensible.

### Consequences
- Less expressive frequency modeling in the short term
- Faster development and clearer intent
- Scheduling and reminders can be layered later via a separate service

---

## ADR-004: Reminder System Implementation Plan (Not Implemented)
## Technical Approach

### 1) Create a separate SPM: Notifications Package (Medication-agnostic)
Create a reusable module (e.g., `MBNotifications`) that schedules local notifications for *any* domain.

**Responsibilities**
- Request notification permission
- Schedule notifications based on a generic schedule model
- Cancel/update pending notifications by identifier


**Non-goals**
- The package must not import or reference app-specific types such as `Medication`, `MedicationFrequency`, or `Frequency`

This makes the package reusable for other features and future apps.

---
### 2) Platform APIs Used
- `UserNotifications`
  - `UNUserNotificationCenter`
  - `UNNotificationRequest`
  - `UNCalendarNotificationTrigger` (repeating schedules)
---

## Proposed Notifications Package API

### Generic schedule model (domain-agnostic)

```swift
public enum NotificationSchedule: Sendable, Equatable {
    case calendar(DateComponents, repeats: Bool)
    case calendars([DateComponents], repeats: Bool)   // e.g., twice daily
}
```

### Request model

```swift
public struct NotificationRequest: Sendable, Equatable {
    public let id: String                    // stable identifier (e.g., medicationId)
    public let title: String
    public let body: String
    public let schedule: NotificationSchedule
}
```

### Scheduler interface

```swift
public protocol NotificationScheduling: Sendable {
    func requestAuthorizationIfNeeded() async throws
    func schedule(_ request: NotificationRequest) async throws
    func cancel(ids: [String]) async
}
```

### Concrete implementation
- `LocalNotificationScheduler: NotificationScheduling`
  - Internally uses `UNUserNotificationCenter`

---

## Integration with Existing Architecture

### Where reminder logic belongs
- **Domain** defines intent via a protocol (app-specific): `MedicationReminderService`
- **Infrastructure/Data** implements the protocol by adapting Medication → generic notification request(s)
- **Notifications SPM** performs the scheduling (platform-specific, but medication-agnostic)

---

## Edge Cases to Handle

- Authorization / permissions
- Notification limits
- Time zone & daylight saving time (DST)

---
## Summary

These decisions prioritise:
- Clarity over cleverness
- Extensibility without over-engineering
- Alignment with real API constraints
- A maintainable foundation suitable for team development


