import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/constant.dart';
import 'AccountScreen.dart';
import 'HomeScreen.dart';
import 'SettingsScreen.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class BottomNavScreen extends StatefulWidget {

 /* final drawerItems = [
    new DrawerItem("Dashboard", Icons.dashboard),
    new DrawerItem("Home", Icons.home_filled),
    new DrawerItem("Account", Icons.account_balance_wallet_rounded),
    new DrawerItem("Settings", Icons.settings),

  ];*/


  final drawerItems = [
    new DrawerItem("Home", Icons.home_filled),
    new DrawerItem("Account", Icons.account_balance_wallet_rounded),
    new DrawerItem("Settings", Icons.settings),

  ];
  @override
  _BottomNavScreen createState() => _BottomNavScreen();
}

class _BottomNavScreen extends State<BottomNavScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController? pageController;
  int rxIndex = 0;
  final List<String> appBarTitle = ["Home", "My Account", "Add Story","Levels","Leaderboard"];
  var Title = 'Home';

  int _selectedDrawerIndex = 0;

 /* _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new DashboardScreen();

      case 1:
        return new HomeScreen();

      case 2:
        return new AccountScreen();

      case 3:
        return new SettingsScreen();

      default:
        return new Text("Screen Not Found");
    }
  }*/



  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeScreen();

      case 1:
        return new AccountScreen();

      case 2:
        return new SettingsScreen();


      default:
        return new Text("Screen Not Found");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  @override
  void initState() {
    pageController = PageController(initialPage: 0, keepPage: true);
  //  getStringValuesSF();
    super.initState();
  }
  void bottomChange(index) {
    setState(() {
      print(index);
      pageController!.jumpToPage(index);
      rxIndex = index;
      Title=appBarTitle[index];
    });
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String strToken= prefs.getString('userToken')??'';
    String strUserID= prefs.getString('strUserID')??'';
    print(strToken);
    print(strUserID);

  }

  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ),

      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title:  Text(widget.drawerItems[_selectedDrawerIndex].title),
            backgroundColor: kBlackColor,
            elevation: 1,
          ),
          drawer:  Drawer(
            child:  Column(
              children: <Widget>[
                Container(
                  height: 300.0,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: kBlackColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),

                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10.0, 0.0, 0.0, 0),
                                child: Text(
                                    "Virend meena" ?? 'not found',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Poppins-Medium'))),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    15.0, 10.0, 0.0, 0),
                                child:  Text("Virendmeena1122@gmail.com" ?? 'not found',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromRGBO(
                                            202, 202, 206, 1.0),
                                        fontFamily: 'Poppins-Semibold'))),
                            SizedBox(
                              height: 26,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('0',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('Sales',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('0',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('Orders',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('0',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                          Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  15.0, 0.0, 0.0, 0),
                                              child: Text('Items',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Semibold'))),
                                        ]),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                new Column(children: drawerOptions,)
              ],
            ),
          ),
          body: _getDrawerItemWidget(_selectedDrawerIndex),

        ));
  }
}
