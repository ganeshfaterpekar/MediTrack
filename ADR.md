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

## Summary

These decisions prioritise:
- Clarity over cleverness
- Extensibility without over-engineering
- Alignment with real API constraints
- A maintainable foundation suitable for team development


