import 'package:flutter/material.dart';
import 'package:todo/ui/Home/home_screen.dart';
import 'package:todo/ui/login/login_screen.dart';
import 'package:todo/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'database/firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
          ),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black
          )
        ),

        scaffoldBackgroundColor: Color(0xFFDFECDB),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      routes: {
        RegisterScreen.routeName : (_) => RegisterScreen(),
        LoginScreen.routeName : (_) => LoginScreen(),
        HomeScreen.routeName : (_) => HomeScreen(),
      },

      initialRoute: RegisterScreen.routeName,
    );
  }
}

