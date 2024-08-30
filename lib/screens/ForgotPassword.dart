import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/constant.dart';
import '../services/BaseURL.dart';
import 'LoginScreen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late var userEmailController = TextEditingController();
  Color darkBlue = Color.fromARGB(255, 18, 32, 47);

  @override
  void initState() {
    super.initState();
  }

  forgotPasswordAPI(String email) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Stack(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Icon(Icons.accessibility_rounded),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      // Change this value to update the progress
                    ),
                  ),
                ],
              ));
        });
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        BaseURL.userlogin,
        data: {
          "usr": email,
        },
      );
      var strReply = response.data['message'];


      print(strReply);

      Navigator.pop(context);
      if (strReply == 'Logged In') {
        var strtoken = response.headers['Set-Cookie'];
        print(strtoken);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userToken', strtoken.toString());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName("/Login"));
      } else {
        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: strReply,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } on DioError catch (e) {
      setState(() {  Navigator.pop(context); });
      Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(

              ),
              /*Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 15, left: 10),
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back_icon.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),*/
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:  const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login_top_icon.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                    child: Container(
                      height: 480,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0, left: 0),
                            child: Text(
                              "Forgot Your Password",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Container(
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: appColor)),
                                  labelText: 'Email'),
                            ),
                          ),
                          const SizedBox(height: 20.0),


                          Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Container(
                              // Your Button
                              width: double.infinity,
                              height: 45,
                              child:  ElevatedButton(
                                child:  Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  // primary: Colors.purple,
                                    primary: kBlackColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25))),
                                onPressed: () {
                                  String strEmail = userEmailController.text;
                                  forgotPasswordAPI(strEmail);

                                },
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[



                                Padding(padding: EdgeInsets.only(left: 5),
                                  child: TextButton(
                                    child: const Text(
                                      'Back to Login',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent,
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
