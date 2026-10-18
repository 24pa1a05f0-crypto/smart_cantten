# Smart Canteen (Flutter demo)

## Features included
- Student sign-in / create-account form with validation (local demo only; no server authentication).
- Food menu with food photos, category filters and search.
- Add-to-cart buttons, quantity controls, order total and pickup-slot selection.
- Place demo orders and view them in My Orders with status and pickup information.
- Profile, help/about actions and sign out.

## Run
From this project folder run:
```bash
flutter pub get
flutter analyze
flutter run
```

Food photos load from Unsplash and therefore require an internet connection. A placeholder appears if an image cannot load.

## Important limitations
This is a working front-end/demo flow. Login, cart and orders are kept in memory and reset when the app restarts. It does not yet use Firebase, a payment gateway, a real canteen backend, or live staff-side order status. For production, connect Firebase Authentication, Firestore and staff/admin authorization.
