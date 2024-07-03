# Expense Tracker

Expense Tracker is a Flutter application that helps you manage your daily expenses efficiently. With this app, you can add, edit, and delete expenses, view expense summaries, and receive daily notifications reminding you to record your expenses.

## Features

- **Add Expense**: Add new expenses with details such as description, amount, date, and type.
- **Edit Expense**: Edit existing expenses.
- **Delete Expense**: Swipe to delete expenses.
- **Expense Summary**: View a summary of your expenses by type.
- **Daily Notifications**: Receive daily reminders to record your expenses.
- **Offline Storage**: All data is stored locally using SQLite.

## Screenshots

![Screenshot](assets\images\img.jpeg)

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.4.3 or higher)
- [Dart](https://dart.dev/get-dart) SDK

### Installation

1. **Clone the repository**:
git clone https://github.com/riyasklb/expence_tracker

2. **Navigate to project directory**:
cd expence_tracker/

3. **Install dependencies**:
flutter pub get

4. **Run the app**:
flutter run

5. **Explore and modify**:
- Explore the project structure and modify the code to suit your needs.
- Customize UI, add features, or integrate additional packages as required.

## Dependencies

- [Get](https://pub.dev/packages/get): State management library for Flutter.
- [sqflite](https://pub.dev/packages/sqflite): SQLite plugin for Flutter.
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications): Plugin for displaying local notifications.
- [permission_handler](https://pub.dev/packages/permission_handler): Plugin for handling runtime permissions.
- [timezone](https://pub.dev/packages/timezone): Timezone handling for Flutter.

## Contributing

Contributions to this project are welcome! Feel free to open issues and pull requests to suggest improvements, report bugs, or add new features.

## License

This project is licensed under the MIT License 

## Folder Structure

lib
├── app
│   ├── data
│   │   ├── models
│   │   │   └── expense_model.dart
│   │   ├── repositories
│   │   │   └── expense_repository.dart
│   ├── domain
│   │   ├── entities
│   │   │   └── expense_entity.dart
│   │   ├── repositories
│   │   │   └── expense_repository.dart
│   │   ├── usecases
│   │       ├── add_expense.dart
│   │       ├── delete_expense.dart
│   │       ├── get_expenses.dart
│   │       ├── update_expense.dart
│   ├── presentation
│   │   ├── controllers
│   │   │   └── expense_controller.dart
│   │   ├── screens
│   │       ├── add_expense_page.dart
│   │       ├── expense_list_screen.dart
│   │       └── expense_summary_screen.dart
│   └── main.dart



## Contact

For any questions or inquiries about this project, please contact [riyasklb89@gmail.com].

