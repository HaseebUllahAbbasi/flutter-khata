import 'package:flutter/material.dart';
import 'package:khata_custom/src/app.dart';
import 'package:khata_custom/src/create_account_page.dart';
import 'package:khata_custom/src/home_screen.dart';
import 'package:khata_custom/src/settings/forgot_password_page.dart';

// import 'src/app.dart';
import 'src/login_page.dart'; // Import the LoginPage
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // Set LoginPage as the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/create_account': (context) => CreateAccount(),
        '/forgot_password': (context) => ForgotPasswordPage(),

        '/dashboard': (context) => HomeScreen(),

        // Add route for login page
        '/main': (context) => MainApp(
            settingsController:
                settingsController), // Add route for the main app
      },
    );
  }
}
