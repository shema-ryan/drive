import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './ForgotPassword.dart';
import 'package:drive/services/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Interface - variables .
  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  String userName = '';
  String password = '';
  String phoneNumber = '';
  String captureCode = '';
  String email = '';
  bool _visibility = true;
  bool _signState = false;
  bool _chx = false;
  // animation variables
  AnimationController _fade;
  Animation<double> _animation;
  //helper functions
  Future<void> _signOrSignUp(
      {bool login,
      String name,
      String password,
      String email,
      String telephone}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (login == false) {
        Authentication.singIn(email: email, password: password).catchError((e) {
          _scaffold.currentState.showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(e),
          ));
        });
      } else {
        if (_chx) {
          print(phoneNumber);
          Authentication.signUp(
            password: password,
            email: email,
            username: name,
            phoneNumber: telephone,
          );
        } else {
          _scaffold.currentState.showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text('please accept terms and conditions'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _fade, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();
    _fade.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffold,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://www.turbinebd.com/wp-content/uploads/2020/01/ooo-1.jpg'))),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
            ),
            ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Welcome To ',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      TextSpan(
                          text: 'Drive',
                          style: GoogleFonts.peralta().copyWith(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      TextSpan(
                          text: '\n The easier transportation',
                          style: GoogleFonts.lato()
                              .copyWith(fontSize: 16, letterSpacing: 1)),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: _signState ? 470 : 300,
                  child: Card(
                    color: Colors.white54,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (_signState)
                              FadeTransition(
                                opacity: _animation,
                                child: TextFormField(
                                  key: ValueKey('userName'),
                                  onSaved: (String username) {
                                    userName = username;
                                  },
                                  validator: (String username) {
                                    if (username.isEmpty ||
                                        username.length < 4) {
                                      return 'characters  must be greater than 4';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'username',
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                            TextFormField(
                              key: ValueKey('email'),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String emailText) {
                                email = emailText;
                              },
                              validator: (String emailText) {
                                if (emailText.isEmpty ||
                                    !emailText.contains('@')) {
                                  return 'please Enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'email',
                                prefixIcon: Icon(Icons.mail),
                              ),
                            ),
                            if (_signState)
                              FadeTransition(
                                opacity: _animation,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: [
                                    CountryCodePicker(
                                      initialSelection: 'UG',
                                      onInit: (CountryCode countryCode) {
                                        captureCode = countryCode.dialCode;
                                      },
                                      onChanged: (CountryCode countryCode) {
                                        captureCode = countryCode.dialCode;
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        key: ValueKey('phoneNumber'),
                                        onSaved: (String phoneNumberText) {
                                          phoneNumber =
                                              captureCode + phoneNumberText;
                                        },
                                        validator: (String phoneNumberDigits) {
                                          if (phoneNumberDigits.length < 6) {
                                            return 'Incorrect phoneNumber ';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        decoration: InputDecoration(
                                          labelText: 'phoneNumber',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (String passwordText) {
                                      password = passwordText;
                                    },
                                    obscureText: _visibility,
                                    validator: (String passwordText) {
                                      if (passwordText.isEmpty ||
                                          passwordText.length < 6) {
                                        return 'password must be of 8 characters in length ';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'password',
                                      prefixIcon: Icon(Icons.vpn_key_sharp),
                                    ),
                                    key: ValueKey('passwd'),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _visibility
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    color: _visibility
                                        ? Colors.brown
                                        : Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _visibility = !_visibility;
                                    });
                                  },
                                ),
                              ],
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ForgetPassword.routeName);
                                },
                                child: Text(
                                  'forgot password ?',
                                  style: TextStyle(color: Colors.black45),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    _signOrSignUp(
                                      email: email,
                                      password: password,
                                      login: _signState,
                                      name: userName,
                                      telephone: phoneNumber,
                                    );
                                    phoneNumber = '';
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: size.height * 0.07,
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.brown,
                                            style: BorderStyle.solid)),
                                    child: Text(
                                      !_signState ? 'LogIn' : 'SignUp',
                                      style: TextStyle(color: Colors.brown),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: size.height * 0.07,
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.white54,
                                        )),
                                    child: Text(
                                      'Use Google',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_signState)
                              FadeTransition(
                                opacity: _animation,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      onChanged: (bool value) {
                                        setState(() {
                                          _chx = value;
                                        });
                                      },
                                      value: _chx,
                                      checkColor: Colors.brown,
                                    ),
                                    Text('i agree to Terms and conditions ')
                                  ],
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  !_signState
                                      ? 'Create an account ?'
                                      : 'Already Have an account ?',
                                  style: TextStyle(fontSize: 14),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      _signState = !_signState;
                                    });
                                    _fade.forward();
                                    if (_signState == false) {
                                      _fade.reverse();
                                    }
                                  },
                                  child: Text(
                                    _signState ? 'Sign In' : 'Sign Up',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
