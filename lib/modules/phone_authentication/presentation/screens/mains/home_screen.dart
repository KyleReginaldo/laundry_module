import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final currentUser = FirebaseAuth.instance.currentUser;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(currentUser?.email ?? ''),
            CustomText(currentUser?.displayName ?? ''),
            CustomText(currentUser?.phoneNumber ?? ''),
          ],
        ),
      ),
    );
  }
}
