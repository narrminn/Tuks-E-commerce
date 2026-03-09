Tuks E-Commerce


A fully native iOS e-commerce application built with UIKit and Swift, following the MVVM architecture pattern. The app provides a complete shopping experience — from browsing products and managing wishlists to placing orders.



Features

Authentication — Register, login, forgot/change password with email verification
Home — Multi-section compositional layout with brand carousel, banners, and product grid


Store — Search and browse products with real-time filtering and pagination


Product Detail — Dynamic variant selection (color, size), image gallery with thumbnails, add to bag


Wishlist — Add/remove favorites with optimistic UI updates and cross-screen sync via NotificationCenter


Bag — View cart items, order summary with subtotal/tax/delivery, checkout flow


Profile — View and edit profile info, upload profile photo (multipart form data), logout


Success Screens — Reusable success view for account creation and order placement




Architecture & Patterns

MVVM — Separation of UI and business logic


Builder Pattern — Clean ViewController instantiation with dependency injection


Endpoint Protocol — Type-safe networking with async/await


Repository Pattern — Abstracted data access layer


NotificationCenter — Cross-screen communication for wishlist sync


Delegate Pattern — Cell-to-ViewController communication (e.g., bag item actions)

Tech Stack

Language: Swift
UI Framework: UIKit (100% programmatic, no Storyboards)


Layout: SnapKit (Auto Layout DSL)


Architecture: MVVM


Networking: URLSession with async/await, custom Endpoint protocol


Image Loading: Custom extension on UIImageView


Security: Keychain for token storage


Local Storage: UserDefaults for user profile data

Requirements

iOS 16.0+,
Xcode 15.0+,
Swift 5.9+



Installation

Clone the repository:

git clone https://github.com/narrminn/Tuks-E-commerce.git

Open the project:

cd Tuks-E-commerce/Tuks-E-Commerce
open Tuks-E-Commerce.xcodeproj

Install dependencies (if using CocoaPods/SPM for SnapKit)
Build and run on simulator or device



Author
Narmin Alasova — iOS Developer

GitHub: @narrminn

