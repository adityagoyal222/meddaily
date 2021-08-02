import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meddaily/db/user_db.dart';
import 'package:meddaily/utils/app_icons_icons.dart';
import 'package:meddaily/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLogin = false;
  var _isLoading = false;

  Future<void> submitAuthForm(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          _isLoading = false;
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user_db = UserDatabaseService();
        user_db.addUser({
          "id": authResult.user!.uid,
          "email": email,
          "name": name,
        });
        setState(() {
          _isLoading = false;
        });
      }
    } on PlatformException catch (err) {
      var message = "An error occurred, please check your credentials!";

      if (err.message != null) {
        message = err.message!;
      }
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  Future<bool> isNewUser(User user) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance
          .doc("users/${user.uid}")
          .get()
          .then((doc) {
        if (doc.exists)
          exists = false;
        else
          exists = true;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<String?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      if (await isNewUser(_auth.currentUser!)) {
        final user_db = UserDatabaseService();
        user_db.addUser({
          "id": _auth.currentUser!.uid,
          "email": _auth.currentUser!.email.toString(),
          "name": _auth.currentUser!.displayName.toString(),
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future<String?> _signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    AuthCredential authCredential =
        FacebookAuthProvider.credential(facebookAccessToken.token);
    User fbUser;
    fbUser = (await _auth.signInWithCredential(authCredential)).user!;
    if (await isNewUser(fbUser)) {
      await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).set({
        "name": fbUser.displayName.toString(),
        "email": fbUser.email.toString(),
      });
      final user_db = UserDatabaseService();
      user_db.addUser({
        "id": fbUser.uid,
        "email": fbUser.displayName.toString(),
        "name": fbUser.email.toString(),
      });
    }
  }

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
                  onTap: _signInWithGoogle,
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
                  onTap: _signInWithFacebook,
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
            AuthForm(_isLogin, submitAuthForm, _isLoading),
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
