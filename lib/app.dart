import 'package:flutter/material.dart';
import 'package:votix/utils/constants/app_theme.dart';
import 'package:votix/views/dashboard.dart';
import 'package:votix/views/login_screen.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Votix',
      theme: VotixTheme.getLightTheme(),
      darkTheme: VotixTheme.getDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: "/dashboard",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/dashboard": (context) => const Dashboard(),
      },
    );
  }
}
