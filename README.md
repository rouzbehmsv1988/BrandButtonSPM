# BrandButtonSPM

BrandButtonSPM is a Swift Package for easily creating and managing custom-styled buttons within your SwiftUI applications. It provides a flexible and reusable `BrandButton` component that can be customized with different styles, colors, and behaviors.

## Features

- Customizable button styles including leading, trailing, and image-supported designs.
- Dynamic enable/disable button states with smooth animations.
- Easily integrable with Swift Package Manager.

## Installation and Usage

### Swift Package Manager

You can add `BrandButtonSPM` to your project via Swift Package Manager and import BrandButton to your files.


## Deployment Decistion

there were two ways to deploy a button that can be used both in UIKit and SwiftUI. 
1. A swiftUI based button and have a UIKittWrapper for it
2. A UIKit based button and have a SwiftUIWrapper for it

Both Are implemented but the more concrete one is the first one that I have deployed in more details.
I have commented the code example

## Architecture

I have decided to use a Redux Pattern since you mentioned that you are migrating to Redux for your own app and also since the emphasize of the task was on State Management.

### Notes:

I have used a global function for reducer because of the small domain of this task. there are also better ways to deploy that instead of a global function.




