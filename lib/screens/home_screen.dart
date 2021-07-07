import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();
              try {
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("error"),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
              }
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
