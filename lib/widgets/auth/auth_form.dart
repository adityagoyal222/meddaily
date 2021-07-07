import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(this.isLogin, this.submitfn, this.isLoading);
  final bool isLogin;
  final void Function(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) submitfn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  String _userEmail = '';
  String _name = '';
  String _userPassword = '';

  Color getColor(isLogin, hasFocus) {
    if (hasFocus) {
      return Color(0XFF7DEA82);
    }
    if (isLogin) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).accentColor;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitfn(
        _userEmail.trim(),
        _userPassword.trim(),
        _name.trim(),
        widget.isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Center(
        child: Form(
          key: _formKey,
          child: Container(
            height: widget.isLogin
                ? MediaQuery.of(context).size.height * 0.40
                : MediaQuery.of(context).size.height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isLogin)
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: getColor(widget.isLogin, nameNode.hasFocus),
                        fontSize: 16,
                      ),
                    ),
                  ),
                if (!widget.isLogin)
                  TextFormField(
                    focusNode: nameNode,
                    style: TextStyle(
                      color: widget.isLogin
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                    ),
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter atleast 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      // labelStyle: TextStyle(
                      //   color: getColor(
                      //     widget.isLogin,
                      //     nameNode.hasFocus,
                      //   ),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: getColor(widget.isLogin, false),
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
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Email',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: getColor(widget.isLogin, emailNode.hasFocus),
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFormField(
                  focusNode: emailNode,
                  style: TextStyle(
                    color: widget.isLogin
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                  ),
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // labelText: 'Email Address',
                    // labelStyle: TextStyle(
                    //   color: getColor(
                    //     widget.isLogin,
                    //     emailNode.hasFocus,
                    //   ),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: getColor(widget.isLogin, false),
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
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: getColor(widget.isLogin, passwordNode.hasFocus),
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFormField(
                  focusNode: passwordNode,
                  style: TextStyle(
                    color: widget.isLogin
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                  ),
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Password must be atleast 7 characters long";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    // labelStyle: TextStyle(
                    //   color: getColor(
                    //     widget.isLogin,
                    //     passwordNode.hasFocus,
                    //   ),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: getColor(widget.isLogin, false),
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
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ButtonTheme(
                    buttonColor: Color(0XFF7DEA82),
                    minWidth: double.infinity,
                    height: 55,
                    child: RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(
                        widget.isLogin ? 'Login' : 'Create Account',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
