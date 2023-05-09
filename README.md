README file for the `ReviewService` class:

# ReviewService

`ReviewService` is a simple library that provides a convenient way to show a review popup to the user after a certain number of app launches or visits to a specific section. It is implemented using the `App Store Review API` provided by Apple.

## Installation

`ReviewService` is available as a Swift Package. To install it, simply add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/Charnpreet/ReviewService.git", from: "1.0.0")
```

## Usage

To use `ReviewService`, you first need to import the module:

```swift
import ReviewService
```

Then, you can create an instance of the `ReviewService` class and call its `showReviewPopup` method, passing in the `reviewCountThreshold` and `currentVersion` parameters:

```swift
let reviewService = ReviewService()
reviewService.showReviewPopup(after: 4, on: "1.0.0")
```

This will show the review popup to the user after the app has been launched or the specific section has been visited `4` times on the version `"1.0.0"`.


## Deprecation Notice

The `ReviewFactory` class has been deprecated in favor of the `ReviewService` class. Please update your code to use the new API.

## License

`ReviewService` is released under the MIT license. See `LICENSE` for details.
