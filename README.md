<div align="center">

# 🛍️ Tuks E-Commerce

**A fully native iOS e-commerce application built with UIKit and Swift**

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![UIKit](https://img.shields.io/badge/UIKit-100%25%20Programmatic-007AFF?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/documentation/uikit)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-8B5CF6?style=for-the-badge)](https://en.wikipedia.org/wiki/Model–view–viewmodel)
[![iOS](https://img.shields.io/badge/iOS-16.0+-000000?style=for-the-badge&logo=ios&logoColor=white)](https://www.apple.com/ios)

<p>
  A complete shopping experience — from browsing products and managing wishlists to placing orders.<br>
  Built following the <strong>MVVM</strong> architecture pattern with clean, modular code.
</p>

---

</div>

## ✨ Features

<table>
  <tr>
    <td width="50%">
      <h3>🔐 Authentication</h3>
      <p>Register, login, forgot/change password with email verification</p>
    </td>
    <td width="50%">
      <h3>🏠 Home</h3>
      <p>Multi-section compositional layout with brand carousel, banners, and product grid</p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h3>🔍 Store</h3>
      <p>Search and browse products with real-time filtering and pagination</p>
    </td>
    <td width="50%">
      <h3>📦 Product Detail</h3>
      <p>Dynamic variant selection (color, size), image gallery with thumbnails, add to bag</p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h3>❤️ Wishlist</h3>
      <p>Add/remove favorites with optimistic UI updates and cross-screen sync via NotificationCenter</p>
    </td>
    <td width="50%">
      <h3>🛒 Bag</h3>
      <p>View cart items, order summary with subtotal/tax/delivery, checkout flow</p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h3>👤 Profile</h3>
      <p>View and edit profile info, upload profile photo (multipart form data), logout</p>
    </td>
    <td width="50%">
      <h3>🎉 Success Screens</h3>
      <p>Reusable success view for account creation and order placement</p>
    </td>
  </tr>
</table>

---

## 🏗️ Architecture & Patterns

<table>
  <tr>
    <th align="left">Pattern</th>
    <th align="left">Usage</th>
  </tr>
  <tr>
    <td><strong>MVVM</strong></td>
    <td>Separation of UI and business logic</td>
  </tr>
  <tr>
    <td><strong>Builder Pattern</strong></td>
    <td>Clean ViewController instantiation with dependency injection</td>
  </tr>
  <tr>
    <td><strong>Endpoint Protocol</strong></td>
    <td>Type-safe networking with async/await</td>
  </tr>
  <tr>
    <td><strong>Repository Pattern</strong></td>
    <td>Abstracted data access layer</td>
  </tr>
  <tr>
    <td><strong>NotificationCenter</strong></td>
    <td>Cross-screen communication for wishlist sync</td>
  </tr>
  <tr>
    <td><strong>Delegate Pattern</strong></td>
    <td>Cell-to-ViewController communication (e.g., bag item actions)</td>
  </tr>
</table>

---

## 🛠️ Tech Stack

| Technology | Details |
|:--|:--|
| **Language** | Swift |
| **UI Framework** | UIKit (100% programmatic, no Storyboards) |
| **Layout** | SnapKit (Auto Layout DSL) |
| **Architecture** | MVVM |
| **Networking** | URLSession with async/await, custom Endpoint protocol |
| **Image Loading** | Custom extension on UIImageView |
| **Security** | Keychain for token storage |
| **Local Storage** | UserDefaults for user profile data |

---

## 📋 Requirements

<p>
  <img src="https://img.shields.io/badge/iOS-16.0+-blue?style=flat-square" alt="iOS 16.0+">
  <img src="https://img.shields.io/badge/Xcode-15.0+-1575F9?style=flat-square&logo=xcode&logoColor=white" alt="Xcode 15.0+">
  <img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift 5.9+">
</p>

---

## 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/narrminn/Tuks-E-commerce.git

# Open the project
cd Tuks-E-commerce/Tuks-E-Commerce
open Tuks-E-Commerce.xcodeproj
```

> **Note:** Install dependencies (if using CocoaPods/SPM for SnapKit), then build and run on simulator or device.

---

<div align="center">

## 👩‍💻 Author

**Narmin Alasova** — iOS Developer

[![GitHub](https://img.shields.io/badge/GitHub-@narrminn-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/narrminn)

</div>
