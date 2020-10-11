import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/home_page.dart';
import 'package:pharm_pfe/authentification/login_page.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController,
      passwordController,
      passwordConfirmationController;

  InputDecoration _inputDecoration(String lable, IconData icon) {
    return InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          icon,
          color: Style.darkBackgroundColor,
          size: 20,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        // Theme.of(context).textTheme.caption,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.darkBackgroundColor),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.darkBackgroundColor),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.accentColor),
          borderRadius: BorderRadius.circular(30),
        ));
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   backgroundColor: Style.accentColor,
      //   title: Text(
      //     "Phahrme signup",
      //     style: Theme.of(context)
      //         .textTheme
      //         .bodyText2
      //         .copyWith(color: Style.darkBackgroundColor),
      //   ),
      // ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.teal[300], Colors.blue[900]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: usernameController,
                      // ignore: missing_return
                      validator: (input) {
                        if (input.trim().length < 4 ||
                            input.trim().length > 20) {
                          return "Please enter a username";
                        }
                      },
                      cursorColor: Style.accentColor,
                      decoration: _inputDecoration("Username", Icons.person)),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: passwordController,
                      // ignore: missing_return
                      validator: (input) {
                        if (input.trim().length < 4 ||
                            input.trim().length > 20) {
                          return "Please enter a password";
                        }
                      },
                      obscureText: true,
                      cursorColor: Style.accentColor,
                      decoration: _inputDecoration("Password", Icons.vpn_key)),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                      controller: passwordConfirmationController,
                      // ignore: missing_return
                      validator: (input) {
                        if (input.trim().length < 4 ||
                            input.trim().length > 20 ||
                            passwordController.text.trim() != input.trim()) {
                          return "Please confirm password";
                        }
                      },
                      obscureText: true,
                      cursorColor: Style.accentColor,
                      decoration:
                          _inputDecoration("Confirm Password", Icons.replay)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: ButtonTheme(
                    //minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: FlatButton(
                            color: Style.darkBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              _validate();
                            },
                            child: Text("Register",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Style.primaryColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(builder: (contex) {
                          return LoginPage();
                        }));
                      },
                      child: Text(
                        "Already have account? Login!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        // Theme.of(context).textTheme.caption
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validate() {
    if (_formKey.currentState.validate()) {
      DatabaseHelper.insertUser(User(
              id: null,
              password: passwordController.text.trim(),
              username: usernameController.text.trim()))
          .then((value) {
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (contex) {
          return HomePage(userid: value);
        }));
      }).catchError((onError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 2,
                title: Text("Username already exists!",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Style.redColor)),
                actions: [
                  FlatButton(
                    splashColor: Style.lightBackgroundColor,
                    child: Text(
                      "Ok",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }
}
