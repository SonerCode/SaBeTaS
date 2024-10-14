
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'provider/firebase_diyetisyen_provider.dart';
import 'provider/firebase_provider.dart';
import 'provider/firebaseauth_service.dart';
import 'provider/firebasedata_provider.dart';
import 'provider/firebasefoods.dart';
import 'provider/firebaseistatik_provide.dart';
import 'provider/firebaseprofil_provider.dart';
import 'screen/diyetisyen/dnavigasyonbari.dart';
import 'screen/homescreen/navigation_bar.dart';
import 'screen/onboard/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FireFood()),
        ChangeNotifierProvider(create: (_) => FireData()),
        ChangeNotifierProvider(create: (_) => FireProfil()),
        ChangeNotifierProvider(create: (_) => FireIstatik()),
        ChangeNotifierProvider(create: (_) => FirebaseProvider()),
        ChangeNotifierProvider(create: (_) => FireDiyetisyen()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isLoggedIn = false;
  bool rolum = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool? rolune = prefs.getBool('rolune');

    Future<bool> loginFunction(
        String email, String password, bool rolune) async {
      try {
        rolum = rolune;
        await FirebaseGiris().signIn(
          context: context,
          email: email,
          password: password,
          rolune: rolune,
        );
        return true;
      } catch (e) {

        return false;
      }
    }

    if (email != null && password != null) {

      bool loginSuccessful = await loginFunction(email, password, rolune!);

      if (loginSuccessful && mounted) {
        setState(() {
          _isLoggedIn = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return rolum ? const MNavigationBarim() : const DNavigasyon();
    } else {
      return const OnboardingScreen();
    }
  }
}
