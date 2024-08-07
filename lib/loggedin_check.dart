import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInCheck extends StatefulWidget {
  const LoggedInCheck({super.key});

  @override
  State<LoggedInCheck> createState() => _LoggedInCheckState();
}

class _LoggedInCheckState extends State<LoggedInCheck> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (mounted) {
      if (accessToken != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/splash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
