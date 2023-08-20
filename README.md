Certainly! Here's the updated README file with the usage for both SwiftUI and UIKit:

---

# ReviewService

`ReviewService` is a simple library that provides a convenient way to show a review popup to the user after a certain number of app launches or visits to a specific section. It is implemented using the `App Store Review API` provided by Apple.

## Installation

`ReviewService` is available as a Swift Package. To install it, simply add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/Charnpreet/ReviewService.git", from: "1.0.0")
```

## Usage

### UIKit

To use `ReviewService` with UIKit, you first need to import the module:

```swift
import ReviewService
```

Then, in the `viewWillDisappear` method of your `UIViewController`, create an instance of the `ReviewService` class and call its `showReviewPopup` method:

```swift
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    let reviewService = ReviewService()
    reviewService.showReviewPopup(after: 4, on: "1.0.0")
}
```

### SwiftUI

For SwiftUI, you can use the `.onDisappear` modifier:

```swift
import SwiftUI
import ReviewService

struct ContentView: View {
    var body: some View {
        // Your view content
        Text("Hello, World!")
            .onDisappear {
                let reviewService = ReviewService()
                reviewService.showReviewPopup(after: 4, on: "1.0.0")
            }
    }
}
```

This will show the review popup to the user after the app has been launched or the specific section has been visited `4` times on the version `"1.0.0"`.

## Architecture

```
+------------------------+       +------------------------+
|                        |       |                        |
|  ReviewService         |       |  ReviewPreferenceManager |
|                        |       |                        |
+------------------------+       +------------------------+
        |       ^                       ^
        |       |                       |
        v       |                       |
+------------------------+       +------------------------+
|                        |       |                        |
|  AppStoreReviewService |------>|  AppStoreReviewController |
|                        |       |                        |
+------------------------+       +------------------------+
                                        |
                                        v
                                +------------------------+
                                |                        |
                                |  AppStoreReviews       |
                                |                        |
                                +------------------------+
```

## Deprecation Notice

The `ReviewFactory` class and associated `ReviewModuleFactory` protocol have been deprecated in favor of the `ReviewService` class. It's recommended to update your code to use the new API as soon as possible for better maintainability and performance.

## License

`ReviewService` is released under the MIT license. See `LICENSE` for details.

---

This README now provides a comprehensive guide for users to understand how to use the service in their projects with both UIKit and SwiftUI, the architecture, and the deprecation notice.
