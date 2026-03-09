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


<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 56 25" src="https://github.com/user-attachments/assets/497843dd-77e5-4255-846a-5d1c09f8e8e5" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 56 31" src="https://github.com/user-attachments/assets/86262db3-9155-47bd-978a-dc56e9090e5d" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 56 57" src="https://github.com/user-attachments/assets/2bed0cb7-2dde-46cb-93c1-d5f1acaff211" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 57 34" src="https://github.com/user-attachments/assets/e13fa018-fd92-4c67-b2b1-07c6cc06532d" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 54 41" src="https://github.com/user-attachments/assets/5b931b13-e5f4-4fe4-9631-f586cd343d0b" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 56 07" src="https://github.com/user-attachments/assets/8ec6f9c9-6043-4d5a-94fe-9734392b0305" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 54 48" src="https://github.com/user-attachments/assets/c2b875c7-779d-41a2-9cf8-189e1716289a" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 55 04" src="https://github.com/user-attachments/assets/c1130948-329e-4c03-926f-3d1fac645fa4" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 55 32" src="https://github.com/user-attachments/assets/d823a41c-636d-4877-9b25-123897034c5b" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 55 35" src="https://github.com/user-attachments/assets/929d84e4-6f73-4c99-b074-f32709b81474" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 55 40" src="https://github.com/user-attachments/assets/655ec9ec-8b7d-488a-8c78-8e913a06fe1a" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-09 at 12 56 18" src="https://github.com/user-attachments/assets/fd65f1c5-be1e-4227-939e-c73c446fd495" />

