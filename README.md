
---

## **2️⃣ Cravex README.md**


# Cravex 🍕🍦

**Flutter Food Delivery App**

Cravex is a Flutter-based food delivery mobile app that allows users to browse food items, view details, add to cart, and pay using Stripe integration. Admins can add new food items through a separate admin panel.

---

## **Features**

- Browse food categories: Pizza, Icecream, Salad, Burger
- View horizontal & vertical food item lists
- Tap on a food item for detailed view
- Add items to cart and manage cart
- Stripe payment integration
- Firebase Firestore for data storage
- Admin panel for adding new items
- State management using `setState` and Streams

---

## **Screenshots**

![Home Screen](assets/Images/home.png)
![Food Details](assets/Images/fooddetails.png)
![Cart](assets/Images/cart.png)

---

## **Tech Stack**

- **Flutter** (Dart)
- **Firebase** (Auth & Firestore)
- **Stripe API** (Payments)
- **Image Picker** (Upload item images)
- **CurvedNavigationBar** for smooth navigation

---

## **Getting Started**

### **Prerequisites**

- Flutter SDK >= 3.9.0
- Firebase project setup
- Stripe account for payments

### **Installation**

1. Clone the repository:


git clone https://github.com/Talhabyte/cravex.git


2.Navigate to the project directory:
cd cravex

3.Get dependencies:
flutter pub get

4.Configure Firebase and Stripe keys:

Replace firebase_options.dart and Stripe publishableKey with your keys.

5.Run the app:
flutter run

Folder Structure:

lib/screens - App screens (Home, Food Details, Login, Signup)

lib/admin - Admin panel screens

lib/widgets - Reusable widgets and constants

lib/services - Firebase & Stripe services

Future Improvements:

Add user authentication & profile

Implement order tracking

Add reviews and ratings for items

Push notifications for order updates
