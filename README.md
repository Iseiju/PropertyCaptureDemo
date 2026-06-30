# PropertyCaptureDemo

## Requirements

* Xcode 26 or later

## Setup

1. Open the project in Xcode 26 or later.
2. Under **Signing & Capabilities**, select your Apple ID under **Team**.
3. If prompted, update the Bundle Identifier to a unique value.
4. Build and run.

> **Note:** On the iOS Simulator, the app uses the photo library instead of the camera.

## Running Unit Tests

1. Complete the setup steps above.
2. Select the **PropertyCaptureDemoTests** scheme.
3. Press **⌘U** or choose **Product → Test**.

---

# Technical Overview

## App Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture with a clear separation of responsibilities:

```text
App
├── Features
│   ├── Landing
│   │   ├── Views
│   │   └── LandingFactory.swift
│   ├── Home
│   │   ├── Models
│   │   ├── ViewModels
│   │   ├── Views
│   │   └── HomeFactory.swift
│   └── CaptureForm
│       ├── Models
│       ├── Services
│       ├── ViewModels
│       ├── Views
│       └── PropertyFormFactory.swift
├── Navigation
│   ├── Route.swift
│   └── Router.swift
├── Services
│   ├── Location
│   ├── Network
│   ├── Persistence
│   └── Photo
├── Shared
│   ├── Components
│   ├── Errors
│   ├── Extensions
│   └── Utilities
├── Resources
│   ├── Assets.xcassets
│   └── LaunchScreen.storyboard
├── AppContainer.swift
└── PropertyCaptureDemoApp.swift
```

### Design Decisions

* **Feature-first architecture** keeps related code together and improves scalability.
* **MVVM** separates the UI, presentation logic, and business logic for better maintainability.
* **Shared services** (networking, location, and persistence) are centralized to promote reuse and reduce duplication.
* **Dependency injection** via `AppContainer` improves testability and simplifies dependency management.
* A **dedicated navigation layer** via `Router` keeps routing logic separate from feature implementations.
* **Feature factories** handle screen creation and dependency injection, keeping views lightweight.

---

## State Management & Data Flow

The app uses SwiftUI's native state management:

* `@State` for view-local state.
* `@Observable` for shared presentation state.
* Dependency injection via `.environment` for the router navigation service.
* `async/await` for asynchronous operations.

Typical data flow:

```text
 User Action
      │
      ▼
    View
      │
      ▼
 ViewModel
      │
      ▼
 Service Layer
      │
      ▼
 System APIs / Network
      │
      ▼
 ViewModel updates state
      │
      ▼
 View automatically refreshes
```

Keeping state changes inside the ViewModel maintains a predictable, one-way data flow and reduces coupling between the UI and business logic.

---

## Technology Stack

| Technology                        | Reason                                           |
| --------------------------------- | ------------------------------------------------ |
| SwiftUI                           | Declarative UI.                                  |
| Swift Concurrency (`async/await`) | Asynchronous programming.                        |
| SwiftData                         | Lightweight persistence integrated with SwiftUI. |
| XCTest                            | Unit Testing                                     |
| Core Location                     | Device location access for photo enrichment.     |
| ImagePicker                       | Image capture.                                   |
| ActivityView                      | Content sharing.                                 |
| Nominatim (OpenStreetMap)         | Reverse geocoding.                               |

### Trade-offs

**SwiftUI**

* ✅ Fast development.
* ✅ Reactive UI updates.
* ❌ Some functionality still requires UIKit interoperability (e.g., `ImagePicker` and `ActivityView`).

**SwiftData**

* ✅ Minimal setup.
* ✅ Great integration with SwiftUI.
* ❌ Less mature than Core Data for advanced use cases.

**Nominatim**

* ✅ No API key required.
* ✅ Open source.
* ❌ Subject to usage policies and rate limits, making it less suitable for large-scale production applications.

---

## Future Improvements

Given additional time, I would prioritize:

* Improved error handling and retry mechanisms.
* Attach metadata to the photo based on the enriched details.
* Expanded unit test coverage.
* Expand the CI pipeline with automated deployment.
* Overall UI/UX polish.

---

## What Was Intentionally Left Out

To stay within the project time box, I intentionally did not implement:

* Advanced image editing.
* Offline support for capturing photos and synchronizing them later.
* Extensive UI polish and animations.
