import 'package:euclid/configs/ThemeColors.dart';
import 'package:euclid/screens/MoviesExplorer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool waiting = false;
  TextEditingController _emailCtrl, _passCtrl;
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    _emailCtrl = TextEditingController();
    _passCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 20.0,
            left: 15.0,
            right: 20.0,
          ),
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    inputField("Email", _emailCtrl),
                    inputField("Password", _passCtrl),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 40.0, 20.0, 0),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  alignment: Alignment(0.0, 0.0),
                  child: waiting
                      ? SpinKitWave(
                          size: 12.0,
                          color: Colors.white60,
                        )
                      : Text(
                          "Sign In",
                          style: TextStyle(
                            color: ThemeColors.shadowLight,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ThemeColors.gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.shadowLight,
                          blurRadius: 10.0,
                          offset: Offset(-10.0, -10.0),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(41, 72, 255, 0.3),
                          blurRadius: 15.0,
                          offset: Offset(10.0, 10.0),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.main,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: googleLogin,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Image.asset(
                        "assets/google.png",
                        height: 50.0,
                        width: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(name, ctrl) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20.0, 20.0, 0),
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    controller: ctrl,
                    obscureText: name == "Password",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration.collapsed(hintText: null),
                  ),
                  decoration: BoxDecoration(
                      color: ThemeColors.bg,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.shadowLight,
                          blurRadius: 5.0,
                          offset: Offset(-5.0, -5.0),
                        ),
                        BoxShadow(
                          color: ThemeColors.shadowDark,
                          blurRadius: 5.0,
                          offset: Offset(5.0, 5.0),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User user = authResult.user;

      print("\n\n\n");
      print(user);
      if (user == null) {
        throw Exception("Failed");
      }
      setState(() {
        waiting = false;
      });
      Navigator.of(context).pushReplacement(
        createRoute(MoviesExplorer()),
      );
    } catch (e) {
      print("\n\n\n");
      print(e);
      Fluttertoast.showToast(
        msg: "Authentication Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
      setState(() {
        waiting = false;
      });
    }
  }

  Future<void> login() async {
    setState(() {
      waiting = true;
    });
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailCtrl.text,
        password: _passCtrl.text,
      );
      if (user == null) {
        throw Exception("Failed");
      }
      setState(() {
        waiting = false;
      });
      Navigator.of(context).pushReplacement(
        createRoute(MoviesExplorer()),
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Authentication Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
      setState(() {
        waiting = false;
      });
    }
  }
}

Route createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
