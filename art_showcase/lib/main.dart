import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: ArtConnectApp(),
    ),
  );
}

class ArtConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.getTheme(),
      home: SplashScreen(),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;

  ThemeData getTheme() {
    return ThemeData(
      brightness: _isDarkMode
          ? Brightness.dark
          : Brightness.light, // Set brightness based on _isDarkMode
      primarySwatch: createMaterialColor(
          _primaryColor), // Generate a MaterialColor from _primaryColor
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(createMaterialColor(
                  _primaryColor)) // Set icon color for ElevatedButton
              )),
      appBarTheme: AppBarTheme(
          color: createMaterialColor(
              _primaryColor), // Set AppBar color based on _primaryColor
          iconTheme: IconThemeData(
              color: createMaterialColor(
                  Colors.white)), // Set icon color in AppBar
          titleTextStyle: TextStyle(
              color: createMaterialColor(
                  Colors.white), // Set title text color in AppBar
              fontSize: 25 // Set font size for AppBar title
              )),
    );
  }

  void toggleDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  void changePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
