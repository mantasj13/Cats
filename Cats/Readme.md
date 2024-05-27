#  Cats App

### Development Environment:
 - Development Environment: Xcode 15.3
 - Minimum Target: iOS 15.0

### Architecture 
- I've adopted the MVVM pattern to enhance the readability, maintainability, scalability, and testability of the iOS application. To facilitate this, I used the @Published property wrapper, allowing SwiftUI to automatically refresh the necessary components when the state changes. Additionally, I've integrated the async/await paradigm into networking operations, enhancing the efficiency and responsiveness of the application.

### Layers
- ViewModel: Business layer.
- Service layer: Handles the interaction with external services and APIs.
- Network layer: Utilises Swift's URLSession for network operations.

### Testing
- Unit tests were added to test the behavior of different modules.

### The UI
- The design is intentionally kept simple with default fonts, and sizes, using SwiftUI.
