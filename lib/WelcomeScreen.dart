import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/AuthenticationServices.dart';
import 'package:quizapp/DashBoard.dart';
import 'package:quizapp/LottieState.dart';

final IsLoadingprovider = StateProvider<bool>((ref) => false);

class WelcomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final auth = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(IsLoadingprovider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2addee), Color(0xff8edbfc)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Let's get Started!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            if (loading)
              Lottie.asset("assets/lottie/loadinganimation.json",
              width: 200,
              height: 200)
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/search.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        ref.read(IsLoadingprovider.notifier).state = true;
                        await auth.loginWithGoogle(context);
                        ref.read(IsLoadingprovider.notifier).state = false;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
