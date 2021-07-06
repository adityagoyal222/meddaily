import 'package:flutter/material.dart';
import 'package:meddaily/utils/app_icons_icons.dart';
import 'package:meddaily/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _isLogin
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
        child: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.18,
          elevation: 0,
          title: Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isLogin ? "Login" : "Sign Up",
                  style: TextStyle(
                    color: _isLogin
                        ? Theme.of(context).primaryTextTheme.headline5!.color
                        : Theme.of(context).primaryTextTheme.headline6!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _isLogin
                      ? "Login with one of the following options"
                      : "Sign up with one of the following options",
                  style: TextStyle(
                    color: _isLogin
                        ? Theme.of(context).primaryTextTheme.headline5!.color
                        : Theme.of(context).primaryTextTheme.headline6!.color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(25),
          //     bottomRight: Radius.circular(25),
          //   ),
          // ),
          backgroundColor: _isLogin
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: _isLogin
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                      // top: MediaQuery.of(context).size.height * 0.04,
                    ),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Center(
                      child: Icon(
                        AppIcons.icons8_google,
                        color: _isLogin
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _isLogin
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                      // top: MediaQuery.of(context).size.height * 0.04,
                    ),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Center(
                      child: Icon(
                        AppIcons.icons8_facebook,
                        color: _isLogin
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _isLogin
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            AuthForm(_isLogin),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isLogin
                      ? "Don't have an account?"
                      : 'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: _isLogin
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? 'Sign Up' : 'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _isLogin
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
