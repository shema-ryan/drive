import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './ForgotPassword.dart';
import 'package:drive/services/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';
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
  String imageUrl = '';
  File image;
  bool _loadingSpinner = false;
  bool loading = false;
  bool _visibility = true;
  bool _signState = false;
  bool _chx = false;
  // animation variables
  AnimationController _fade;
  Animation<double> _animation;
  //helper functions
  void _signOrSignUp(
      {bool login,
      String name,
      String password,
      String email,
      String telephone}) {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      if (login == false) {
        setState(() {
          _loadingSpinner = true;
        });
        Authentication.singIn(email: email, password: password).catchError((e) {
          setState(() {
            _loadingSpinner = false;
          });
          String message = '';
          if (e.contains('The password is invalid')) {
            message = 'password is incorrect';
          } else if (e.contains('may have been deleted.')) {
            message = 'No account detected consider creating one ';
          } else if (e.contains('A network error')) {
            message = 'Check the internet connection';
          } else {
            message = e;
          }
          _scaffold.currentState.showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(message),
          ));
        });
      } else {
        if (_chx && image != null) {
          setState(() {
            _loadingSpinner = true;
          });
          Authentication.signUp(
            password: password,
            email: email,
            username: name,
            phoneNumber: telephone,
            file: image,
          );
        } else {
          _scaffold.currentState.showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
                'please accept terms and conditions and provide a profile picture'),
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

  Future<void> _pickImageAndStore() async {
    ImagePicker _pick = ImagePicker();
    final pickedImage = await _pick.getImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedImage.path);
    });
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
                image: AssetImage('assets/images/open.jpg'),
              )),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.brown.withOpacity(0.4)),
              ),
            ),
            ListView(
              children: [
                SizedBox(
                  height: size.height * 0.13,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Welcome To',
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
                  height: size.height * 0.10,
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: _signState ? size.height * 0.65 : size.height * 0.39,
                  child: Card(
                    color: Colors.white54,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (_signState)
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Theme.of(context).primaryColor,
                                backgroundImage:
                                    image == null ? null : FileImage(image),
                                child: image != null
                                    ? null
                                    : IconButton(
                                        onPressed: _pickImageAndStore,
                                        icon: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                              ),
                            if (_signState)
                              FadeTransition(
                                opacity: _animation,
                                child: TextFormField(
                                  key: ValueKey('userName'),
                                  onSaved: (value) {
                                    userName = value;
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
                              onSaved: (value) {
                                email = value;
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
                                        onSaved: (value) {
                                          phoneNumber = captureCode + value;
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
                                    onSaved: (value) {
                                      password = value;
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
                                        ? Theme.of(context).primaryColor
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
                            if (!_signState)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            ForgetPassword.routeName);
                                      },
                                      child: Text(
                                        'forgot password ?',
                                        style: TextStyle(color: Colors.black45),
                                      )),
                                ],
                              ),
                            if (_signState)
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            _loadingSpinner
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _formKey.currentState.save();
                                          _signOrSignUp(
                                            email: email,
                                            password: password,
                                            login: _signState,
                                            name: userName,
                                            telephone: phoneNumber,
                                          );
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          height: size.height * 0.055,
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  style: BorderStyle.solid)),
                                          child: Text(
                                            !_signState ? 'LogIn' : 'SignUp',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          height: size.height * 0.055,
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'Use Google',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                            ),
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
                                      checkColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      'i agree to Terms and conditions ',
                                      style: GoogleFonts.aBeeZee().copyWith(
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (!_loadingSpinner)
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Theme.of(context).primaryColor),
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
