I understand now. Here's the consolidated content for the `README.md` file:

---

# ReviewService

`ReviewService` is a streamlined library designed to prompt users for reviews after a certain number of app launches or specific interactions. It leverages Apple's `App Store Review API` to provide a seamless experience.

## Installation

`ReviewService` is available as a Swift Package. To install it, simply add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/Charnpreet/ReviewService.git", from: "1.0.0")
```

## Usage

### SwiftUI

To use `ReviewService` in a SwiftUI application:

1. Import the module:

```swift
import ReviewService
```

2. Create an instance of the `ReviewService` and call the `requestReviewIfAppropriate` method within your SwiftUI view:

```swift
struct ContentView: View {
    let reviewService = ReviewService()

    var body: some View {
        VStack {
            // Your content here
        }
        .onAppear {
            reviewService.requestReviewIfAppropriate(currentVersion: "1.0.0", countToShowReview: 4)
        }
    }
}
```

### UIKit

For UIKit applications:

1. Import the module:

```swift
import ReviewService
```

2. Instantiate the `ReviewService` class and call its `requestReviewIfAppropriate` method, typically in the `viewDidAppear` method of your view controller:

```swift
class ViewController: UIViewController {
    let reviewService = ReviewService()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reviewService.requestReviewIfAppropriate(currentVersion: "1.0.0", countToShowReview: 4)
    }
}
```

## Simplified Architecture

The new architecture of `ReviewService` focuses on simplicity and directness. By removing multiple layers of abstraction, the service is now more straightforward to use and maintain.

## License

`ReviewService` is released under the MIT license. Refer to the `LICENSE` file for more details.

---

You can copy the content above and save it as `README.md` in your `ReviewService` repository.
