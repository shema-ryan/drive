import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'drive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: Colors.brown,
        accentColor: Colors.brown[100],
      ),
      home: HomePage(),
      routes: {},
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _form = GlobalKey<FormState>();
  GlobalKey _scaffold = GlobalKey<ScaffoldState>();
  String userName = '';
  String password = '';
  int phoneNumber = 0;
  String email = '';
  bool _visibility = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffold,
      body: Stack(
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
          Center(
            child: Container(
              height: 450,
              child: Card(
                color: Colors.white54,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            onSaved: (String username) {
                              userName = username;
                            },
                            validator: (String username) {
                              if (username.isEmpty || username.length < 4) {
                                return 'characters  must be greater than 4';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'username',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
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
                          TextFormField(
                            onSaved: (String phoneNumberText) {
                              phoneNumber = int.parse(phoneNumberText);
                            },
                            validator: (String phoneNumberDigits) {
                              if (!phoneNumberDigits.startsWith('+')) {
                                return 'number must start with a country code ';
                              }
                              return null;
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'phoneNumber',
                              prefixIcon: Icon(Icons.phone),
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
                              onPressed: () {},
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
                                    'SignUp',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already Have an account ?',
                                style: TextStyle(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                },
                                child: Text(
                                  'Sign Up',
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
            ),
          ),
        ],
      ),
    );
  }
}
