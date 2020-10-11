import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/home_page.dart';
import 'package:pharm_pfe/authentification/signup_page.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Liste d'utilisateurs dans la base de donneé
  List<User> users = [];

  //La clé pour acceder aux formulaire
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //le controller de les deux champ de saisie (textFormField)
  TextEditingController usernameController, passwordController;

  //Décoration des text field
  InputDecoration _inputDecoration(String lable, IconData icon) {
    return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Style.darkBackgroundColor,
          size: 20,
        ),
        labelText: lable,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //Theme.of(context).textTheme.caption,
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
    DatabaseHelper.init();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(100),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/Capture.PNG")),
                      borderRadius: BorderRadius.circular(360)),
                  height: 200,
                  width: 200,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                          controller: usernameController,
                          cursorColor: Style.accentColor,
                          // ignore: missing_return
                          validator: (input) {
                            if (input.trim().length < 4 ||
                                input.trim().length > 20) {
                              return "Please enter a username";
                            }
                          },
                          decoration:
                              _inputDecoration("Username", Icons.person)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
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
                          decoration:
                              _inputDecoration("Password", Icons.vpn_key)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
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
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () {
                                  _validate();
                                },
                                child: Text("Log in",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: Style.primaryColor)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(builder: (contex) {
                              return SignupPage();
                            }));
                          },
                          child: Text("No account? Signup!",
                              style: //Theme.of(context).textTheme.caption
                                  TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validate() {
    if (_formKey.currentState.validate()) {
      DatabaseHelper.loginWithUsernameAndPassword(
              username: usernameController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        if (value.isEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  elevation: 2,
                  title: Text("Username or password incorrect!",
                      style: Theme.of(context).textTheme.caption),
                  actions: [
                    FlatButton(
                      splashColor: Style.lightBackgroundColor,
                      child: Text(
                        "Try again",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        } else {
          Navigator.of(context)
              .pushReplacement(CupertinoPageRoute(builder: (contex) {
            print(value[0]["user_id"]);
            return HomePage(
              userid: User.fromMap(value[0]).id,
            );
          }));
        }
      });
    }
  }
}
