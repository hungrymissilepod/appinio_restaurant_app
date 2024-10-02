# Appinio Tech Task - Restaurant Booking App

This is a Cupertino restaurant booking app built for Android, iOS, and Web.

## Technical Details

This app was built using Flutter `3.22.0` and Dart `3.4.0`. I used `bloc` as my state management of choice because it is an industry standard.

I took care to ensure that my code was CLEAN, and easily testable.

**Note:** In order to test when a table has been booked by the current user, please enter `Jake` when booking a table. In a real application we would be checking that the user's uid matches rather than their username.

## Screenshots

![Simulator Screenshot - iPhone 15 Pro Max - 2024-10-02 at 19 02 47](https://github.com/user-attachments/assets/bea0d2c7-97e5-4734-b928-bb96a7a72a7d)
`MenuView` displaying a list of `FoodItem` from Firebase Firestore

![Simulator Screenshot - iPhone 15 Pro Max - 2024-10-02 at 19 02 51](https://github.com/user-attachments/assets/2fc426bc-8398-4cb9-8ab8-f637d67d33ad)
The search functionality on `MenuView`

![Simulator Screenshot - iPhone 15 Pro Max - 2024-10-02 at 19 02 54](https://github.com/user-attachments/assets/0c61b8bc-888d-42d4-a8d1-29558a45ac47)
`FoodItemDetailView` display more information about the `FoodItem`

![Simulator Screenshot - iPhone 15 Pro Max - 2024-10-02 at 19 03 02](https://github.com/user-attachments/assets/ad9b4a74-1f0c-4de9-9b20-332aaf543ef9)
Picking a date and time in `BookingView`

![Simulator Screenshot - iPhone 15 Pro Max - 2024-10-02 at 19 03 22](https://github.com/user-attachments/assets/d43538ee-4546-46a7-96e0-8e9f03945d3a)
`TableView` displaying a list of available and reserved `TableModel` from Firestore




