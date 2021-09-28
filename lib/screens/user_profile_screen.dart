import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meddaily/provider/auth_user.dart';
import 'package:meddaily/widgets/user_profile/change_password.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _showBottomSheet(BuildContext ctx, Widget yourWidget) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: ctx,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: yourWidget,
              ),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<AuthUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'My Account',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: Image.network(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80'),
                  ),
                ),
                Text(
                  '${currUser.name}',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 50,
                )
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
              decoration: BoxDecoration(
                color: Color(0xFFDFE8ED),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Display name',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${currUser.name}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${currUser.email}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 15),
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 30,
                        onPressed: () {
                          print("executed change password");
                          _showBottomSheet(context, ChangePasswordModal());
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
              decoration: BoxDecoration(
                color: Color(0xFFDFE8ED),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    currUser.address != null
                        ? '${currUser.address!.locality}, ${currUser.address!.city}, ${currUser.address!.district}'
                        : 'No information provided',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    currUser.contact == "" || currUser.contact == null
                        ? 'No Information Provided'
                        : '${currUser.contact}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Center(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      height: 30,
                      onPressed: () {},
                      child: Text(
                        'Change',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: FlatButton(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                height: 50,
                onPressed: () async {
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  try {
                    await googleSignIn.signOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("error"),
                        backgroundColor: Theme.of(context).errorColor,
                      ),
                    );
                  }
                },
                child: Text(
                  'Sign out',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
