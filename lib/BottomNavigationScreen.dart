import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/DashBoard.dart';
import 'package:quizapp/ProfileScreen.dart';
import 'package:quizapp/ScoresScreen.dart';

final screenIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationScreen extends ConsumerStatefulWidget {
  final User? user;

  const BottomNavigationScreen({Key? key, required this.user})
    : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(screenIndexProvider);
    final screens = [
      DashBoard(user: widget.user!),
      ScoresScreen(user: widget.user!),
      ProfileScreen(user: widget.user!),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: currentIndex,
        onTap: (Tap) {
          ref.watch(screenIndexProvider.notifier).state = Tap;
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/score.png"),
            label: 'Score',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/profile.png"),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
