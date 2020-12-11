import 'package:drive/services/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Drive is humbled To Have you here \n Please verify the authenticity ',
              style: GoogleFonts.aBeeZee().copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 200.0,
            ),
            RaisedButton(
              color: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Drive has sent you an email'),
                            SizedBox(
                              height: 40,
                            ),
                            FlatButton(
                              onPressed: () {
                                Authentication.signOut();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                // _scaffold.currentState.showBottomSheet(
                //   (context) => Container(
                //     height: 300,
                //     child: Column(
                //       children: [
                //         Text('Drive has sent you an email '),
                //         SizedBox(
                //           height: 40,
                //         ),
                //         FlatButton(
                //           onPressed: () {
                //             Authentication.signOut();
                //           },
                //           child: Text('Ok'),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
              child: Text(
                'Verify',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
