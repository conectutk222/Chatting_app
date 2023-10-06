import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff111B21),
        scaffoldBackgroundColor: Color(0xff111B21),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff00A884)
        )
      ),
      home: Welcomescreen(),
    );
  }
}
