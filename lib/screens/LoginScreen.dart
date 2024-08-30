import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/constant.dart';
import '../services/BaseURL.dart';
import 'BottomNavScreen.dart';
import 'ForgotPassword.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late var userEmailController = TextEditingController(text: 'administrator');
  late var passwordController = TextEditingController(text: 'qerp@123');
  Color darkBlue = Color.fromARGB(255, 18, 32, 47);
  bool checkTerms = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  loginAPI(String email, String password) async {

   print(email);
   print(password);


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

    print(email);
    print(password);
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        BaseURL.userlogin,
        data: {
          "usr": email,
          "pwd": password,
        },
      );

      var strReply = response.data['message'];
      print(strReply);

      Navigator.pop(context);
      if (strReply == 'Logged In') {
        var strHeader = response.headers['Set-Cookie'];
        var strUserID = response.data['full_name'];
        var strSplit = strHeader?[0].split(';');
        var strToken = strSplit?[0];
        var one = strToken?.substring(0, 6);
        var two = strToken?.substring(4, 5);
        var finalstr = strToken?.substring(3);
        var removeQual = finalstr?.split('=');
        var getToken = removeQual?[1];

        print(getToken);
        print(strUserID);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userToken', getToken.toString());
        prefs.setString('strUserID', strUserID.toString());
        prefs.setString('company', "QMI Mobile App");
       Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()),
            ModalRoute.withName("/HOME"));
      } else {
        setState(() {
          Navigator.pop(context);
        });
        Fluttertoast.showToast(
          msg: strReply,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } on DioError catch (e) {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
        msg: "Invalid Credentials",
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
          Container(),
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
              padding: const EdgeInsets.only(top: 30),
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
                          "Login Your Account",
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
                          controller: userEmailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: appColor)),
                              labelText: 'Email'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    /*  Container(
                        height: 50,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: appColor)),
                              labelText: 'Password'),
                        ),
                      ),*/

                      Container(
                        height: 50,
                        child: TextField(
                          obscureText: !_isPasswordVisible,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: appColor),
                            ),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                // Toggle the visibility of the password
                                // You can implement your logic here setState(() {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Theme(
                            data: ThemeData(
                                unselectedWidgetColor: Colors.blueAccent),
                            child: Expanded(
                                child: CheckboxListTile(
                              checkColor: Colors.blueAccent,
                              activeColor: Colors.transparent,
                              title: Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: checkTerms,
                              onChanged: (newValue) {
                                setState(() {
                                  checkTerms = newValue ?? true;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: TextButton(
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: appColor,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          // Your Button
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            child: Text(
                              'Login',
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
                              String strPassword = passwordController.text;
                              loginAPI(strEmail, strPassword);
                               //Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNavScreen()));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("New Member?",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w700,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: TextButton(
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                 /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));*/
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
