import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/constant.dart';
import '../../services/BaseURL.dart';
import '../models/ItemGroupModel.dart';

class AddSubPipes extends StatefulWidget {
  List<Map<String, dynamic>> itemData = [];
  final int? index;
  AddSubPipes({Key? key,required this.itemData, @required this.index}) : super(key: key);

  @override
  _AddSubPipes createState() => _AddSubPipes(this.itemData, this.index);
}

class _AddSubPipes extends State<AddSubPipes> {

  List<Map<String, dynamic>> itemData = [];
  int? index;
  _AddSubPipes(this.itemData, this.index);
  late var itemName = TextEditingController();
  late var pipeNumber = TextEditingController();
  late var pipeLength = TextEditingController();
  late var pipeweight = TextEditingController();
  var itemNumber;
  String strToken = '';
  String strUserID = '';
  bool strEditAddOn=false;
  bool strCreateAddOn=false;





  @override
  void initState() {
    super.initState();
    getStringValuesSF();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    strToken = prefs.getString('userToken') ?? '';
    strUserID = prefs.getString('strUserID') ?? '';
    strEditAddOn = prefs.getBool('editAddOn')??false;
    strCreateAddOn = prefs.getBool('createAddOn') ?? false;
    itemNumber = index?.toInt() ?? 0;
    if(strEditAddOn==true){

      pipeNumber.text=itemData[itemNumber]['sub_pipe_no'];
      pipeLength.text=itemData[itemNumber]['length'].toString();
      pipeweight.text=itemData[itemNumber]['weight'].toString();

    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            centerTitle: true,
            backgroundColor: kBlackColor,
            leading: InkWell(
                customBorder: new CircleBorder(),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/back_icon.png',
                    color: Colors.white,
                    height: 15.0,
                    width: 10.0,
                  ),
                )),
            title: Text(
              'Sub Pipes',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Column(children: [




                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: pipeNumber,

                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Pipe Number'),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: pipeLength,

                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Pipe Length'),
                            ),
                          ),

                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: pipeweight,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Pipe Weight'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Container(
                              // Your Button
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                child: const Text(
                                  'Save',
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
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                onPressed: () {

                                  for (int i = 0; i < itemData.length; i++) {
                                    if(i==index){
                                      (itemData[i]['sub_pipe_no']=pipeNumber.text);
                                      (itemData[i]['length']=pipeLength.text);
                                      (itemData[i]['weight']=pipeweight.text);
                                    }
                                  }

                                  Navigator.pop(context);

                                },
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
