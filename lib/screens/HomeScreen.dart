

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qmi_app/screens/AddRawMaterialScreen.dart';
import 'package:qmi_app/screens/CoilListScreen.dart';
import 'package:qmi_app/screens/CreatePipeManufacturing.dart';
import 'package:qmi_app/screens/CreatePipeProcess.dart';
import 'package:qmi_app/screens/CreateSubPipes.dart';
import 'package:qmi_app/screens/HeatNosListScreen.dart';
import 'package:qmi_app/screens/RawMaterialListScreen.dart';
import '../Helpers/constant.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
              padding: const EdgeInsets.only(top: 30.0,left: 20,right: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 30),
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 40),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [

                              Padding(
                                  padding: EdgeInsets.only(left: 15, top: 10, right: 15,bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => CoilListScreen()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                   Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(140),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/items.svg',
                                                        // semanticsLabel: 'My SVG Image',
                                                        height: 150,
                                                        width: 150,
                                                      )
                                                   ),


                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Coil Nos',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),


                                      SizedBox(width: 20,),

                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => HeatNosListScreen()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(140),
                                                        border: Border.all(color: Colors.white, width: 4),
                                                      ),
                                                        child: SvgPicture.asset(
                                                          'assets/images/item_group.svg',
                                                          // semanticsLabel: 'My SVG Image',
                                                          height: 150,
                                                          width: 150,
                                                        )
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Heat Nos',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                              Padding(
                                  padding: EdgeInsets.only(left: 15, top: 10, right: 15,bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => CreatePipeManufacturing()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(140),
                                                          border: Border.all(color: Colors.white, width: 2),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(20),
                                                          child: SvgPicture.asset(
                                                            'assets/images/product_bundle.svg',
                                                            // semanticsLabel: 'My SVG Image',
                                                            height: 150,
                                                            width: 150,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Pipe Manufacturing',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),

                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => CreatePipeProcess()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(140),
                                                        border: Border.all(color: Colors.white, width: 4),
                                                      ),
                                                        child: SvgPicture.asset(
                                                          'assets/images/item_price.svg',
                                                          // semanticsLabel: 'My SVG Image',
                                                          height: 150,
                                                          width: 150,
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Pipe Process',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15, top: 10, right: 15,bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => RawMaterialListScreen()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(140),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                      ),
                                                        child: SvgPicture.asset(
                                                          'assets/images/shipping_rule.svg',
                                                          // semanticsLabel: 'My SVG Image',
                                                          height: 150,
                                                          width: 150,
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Raw Material',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),

                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                           Navigator.push(context,MaterialPageRoute(builder: (context) => CreateSubPipes()));
                                          },
                                          child: Material(
                                            elevation: 3,
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: kBgColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  ),
                                                ),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(140),
                                                        border: Border.all(color: Colors.white, width: 4),
                                                      ),
                                                        child: SvgPicture.asset(
                                                          'assets/images/price_rule.svg',
                                                          // semanticsLabel: 'My SVG Image',
                                                          height: 150,
                                                          width: 150,
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text('Sub Pipe',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: 'Roboto'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ),



                                    ],
                                  )
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }


}
