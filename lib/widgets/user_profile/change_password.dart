import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/provider/auth_user.dart';

class ChangePasswordModal extends StatefulWidget {
  @override
  _ChangePasswordModalState createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final _passwordController = TextEditingController();
  FocusNode _passwordNode = FocusNode();

  void changePassword(
    String password,
  ) {
    FirebaseAuth.instance.currentUser!.updatePassword(password);
  }

  Color getColor(hasFocus) {
    if (hasFocus) {
      return Color(0XFF7DEA82);
    }
    return Theme.of(context).accentColor;
  }

  void _submitData() {
    if (_passwordController.text.isEmpty) {
      return;
    }
    final enteredPassword = _passwordController.text;

    if (enteredPassword.isEmpty || enteredPassword.length < 7) {
      return;
    }
    changePassword(enteredPassword);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Change Password',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              child: Text(
                'New Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: getColor(_passwordNode.hasFocus),
                  fontSize: 14,
                ),
              ),
            ),
            TextField(
              focusNode: _passwordNode,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: getColor(_passwordNode.hasFocus),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFF7DEA82),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              controller: _passwordController,
              onSubmitted: (_) => _submitData(),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: _submitData,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 30,
              minWidth: double.infinity,
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
