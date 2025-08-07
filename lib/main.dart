import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/BottomNavigationScreen.dart';
import 'package:quizapp/WelcomeScreen.dart';
import 'package:quizapp/onBoarding_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await SharedPreferences.getInstance();
  final onboarding = storage.getBool("isOnboarding") ?? false;
  final user = FirebaseAuth.instance.currentUser;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(ProviderScope(
    child: MyApp(onboarding: onboarding, user: user),
  ));
}

class MyApp extends ConsumerWidget {
  final bool onboarding;
  final User? user;

  const MyApp({super.key, required this.onboarding, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        Widget homeScreen;
        if (!onboarding) {
          homeScreen = OnBoarding();
        } else if (user != null) {
          homeScreen = BottomNavigationScreen(user: user);
        } else {
          homeScreen = WelcomeScreen();
        }

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),
          home: homeScreen,
        );
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(

      ),
    );
  }
}
