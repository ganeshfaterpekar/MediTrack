# 📰 MediTrack
A SwiftUI-based iOS application for managing medications, built with **MVVM + Clean Architecture**, focusing on **maintainability, testability, and extensibility**.

## 📱 Features

- View a list of medications
- Add, edit, and delete medications
- Persist medications via a backend API
- Clean separation between UI, domain, and data layers
- Dependency Injection using an `AppContainer`
- Async/await–based networking
- Designed to support future extensions

---

## 🧱 Architecture Overview

The project follows **Clean Architecture** with **MVVM** in the presentation layer.

### High-level layers

```
Presentation (SwiftUI + ViewModels)
        ↓
Domain (Business models + protocols)
        ↓
Data (API, DTOs, networking)
```

### Key principles

- UI depends on ViewModels
- ViewModels depend on Domain protocols
- Domain models are pure and independent
- Data layer implements Domain protocols


```
MedicationApp
├─ App
│  ├─ MedicationApp.swift
│  └─ DIContainer.swift
│
├─ Domain
│  ├─ Models
│  │  ├─ Medication.swift
│  │  └─ MedicationFrequency.swift
│  └─ Protocols
│     └─ MedicationService.swift
│
├─ Data
│  ├─ API
│  │  ├─ MedicationAPIService.swift
│  │  ├─ APIClient.swift
│  │  └─ Endpoints.swift
│  │
│  ├─ Request
│  │  └─ RequestPayload.swift
│  │
│  └─ Response
│     └─ ResponsePayload.swift
│
└─ Presentation
   ├─ Views
   │  ├─ MedicationListView.swift
   │  └─ MedicationFormView.swift
   │
   ├─ ViewModels
   │  ├─ MedicationListViewModel.swift
   │  └─ MedicationFormViewModel.swift
   │
   └─ Shared
      └─ Utils.swift
      
```

---

## 🧠 Domain Layer

### Purpose
The **Domain layer** represents the business logic and core concepts of the app.

### Contents
- **Models**
  - `Medication`
  - `MedicationFrequency`
- **Protocols**
  - `MedicationService`

### Characteristics
- Pure Swift types
- No dependency on SwiftUI or networking
- No dependency on the Data layer
- Expresses *what* the app does, not *how*

---
## 🌐 Data Layer

### Purpose
The **Data layer** handles data persistence and API communication.

### Responsibilities
- API calls
- Request/response DTOs
- Mapping DTOs → Domain models
- Implementing Domain protocols

### Structure
- **API**: API client, endpoints, services
- **Request**: Request DTOs
- **Response**: Response DTOs

Domain models never depend on DTOs.

---
## 🖥️ Presentation Layer (MVVM)

### Views
SwiftUI views are lightweight and bind to ViewModels.

### ViewModels
- `@MainActor`
- Interact only with Domain protocols
- Expose UI state via `@Published`
- Handle async logic and errors

---

## 🔌 Dependency Injection

The app uses an **AppContainer-based DI** approach.

### Benefits
- Centralized dependency creation
- Easy mocking and testing
- No global singletons
- Clear dependency graph

Injected into SwiftUI using the environment.

---
## 📦 Swift Package Manager

The project uses **two SPM packages**:

1. **Networking Package**
   - API client
   - HTTP abstractions
   - JSON encoders/decoders

2. **UI Package**
   - Shared UI components
   - Reusable SwiftUI helpers

---
## 🧪 Testing Strategy

- Unit tests focus on ViewModels
- Data layer is mocked via `MedicationService`
- Domain models are pure and require minimal testing
- UI behavior driven by ViewModel stateś
---

## 🚀 Future Improvements

- Medication reminders and notifications
---

## ✅ Summary

This project demonstrates:
- Clean Architecture in a real SwiftUI app
- MVVM with strong separation of concerns
- Testable, maintainable, and scalable design
- Production-style dependency injection

---
