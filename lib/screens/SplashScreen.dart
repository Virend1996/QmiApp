
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/constant.dart';
import 'LoginScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    init();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences prefs = await _prefs;
   // finish(context);
    /*bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();

    if (isConnected && prefs.getBool('autoLogin') == true) {
      const Home().launch(context, isNewTask: true);
    } else {
      const OnBoard().launch(context, isNewTask: true);
    }*/
   
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));

  }

  @override
  Widget build(BuildContext context) {
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Lottie.asset(
                          'assets/images/splash_animation.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 350,
                            child: Text(
                              "Welcome to QMI App",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),

                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white70,
                              valueColor: AlwaysStoppedAnimation(appColor),
                              strokeWidth: 3,
                            ),
                          )
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
