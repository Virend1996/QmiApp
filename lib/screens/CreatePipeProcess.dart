import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qmi_app/screens/AddRawMaterailCoil.dart';
import 'package:qmi_app/screens/AddSubPipes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/APIService.dart';
import '../../helpers/constant.dart';
import '../../services/BaseURL.dart';
import '../models/ItemGroupModel.dart';


class CreatePipeProcess extends StatefulWidget {


  const CreatePipeProcess({Key? key}) : super(key: key);

  @override
  _CreatePipeProcess createState() => _CreatePipeProcess();
}

class _CreatePipeProcess extends State<CreatePipeProcess> {

  bool checkTerms = false;
  bool _isLoading = true;

  String strLoginId = "";
  String strLoginUserType = "";
  String strToken='';
  String strUserID='';
  List<DataRow> _rowList = [];
  List<Map<String, dynamic>> itemData = [];
  late var itemName = TextEditingController();
  late var nextItemName = TextEditingController();
  late var currentStage = TextEditingController();
  late var currentStageQty = TextEditingController();
  late var nextStageQty = TextEditingController();
  String initialValue = '99';
  String userTypeId = 'Pipe Number';
  var itemListName = [
    '99',

  ];

  var itemListId = [
    'Pipe Number',

  ];


  String initialNext = '99';
  String nextId = 'Next Stage';
  var nextListName = [
    '99',
    '98',
    '97',
    '96',
    '95',
    '94',
    '93',

  ];

  var nextListId = [
    'Next Stage',
    'Initial',
    'Spiral',
    'Repair',
    'Bevelling',
    'Hydro',
    'Final'

  ];


  ItemGroupModel? itemGroupModel;
  @override
  void initState() {
    super.initState();

    getStringValuesSF();

  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    strToken= prefs.getString('userToken')??'';
    strUserID= prefs.getString('strUserID')??'';
  //  gettingItemValues();
    getItemCode();
    setState(() {

    });
  }



  Future<void> getItemCode() async {
    print(BaseURL.getPipeNo + 'sid=' + strToken);
    Dio dio = Dio();
    Response response = await dio.get(
      // BaseURL.getItemGroup+'Type=Role&PartyId='+strLoginId,
      BaseURL.getPipeNo + 'sid=' + strToken,
    );
    try {
      var resData = response.data['data'];
      var strStatus = resData['status'];
      print(strStatus);
      if (strStatus == 'Success') {
        itemGroupModel = ItemGroupModel.fromJson(response.data);
        setState(() {
          for (var i = 0; i < itemGroupModel!.data!.response!.length; i++) {
            itemListName.add(itemGroupModel?.data?.response?[i].label ?? '');
            itemListId.add(itemGroupModel?.data?.response?[i].value ?? '');
          }
        });
      } else {
        setState(() {});
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.response?.headers);
    }
  }

  Future<void> gettingItemValues() async {
    print(userTypeId);
    Dio dio = Dio();
    Response response = await dio.get(
      BaseURL.currentPipeStage + 'sid=' + strToken + '&user_id=' + strUserID + '&pipe_no=' + userTypeId,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON data
      Map<String, dynamic> responseData = response.data;
      currentStage.text = responseData['data']['response']['stage'];
      currentStageQty.text = responseData['data']['response']['length'].toString();


      setState(() {

      });

    } else {
      // Handle the case where the request was not successful
      print('Request failed with status code: ${response.statusCode}');
    }

  }

  Future<void> createItem() async {


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(appColor),
              strokeWidth: 3,
            ),
          );
        });

    var bodyCreate =  {

      "sid": strToken,
      "user_id": strUserID,
      "data":{
        "pipe_no": userTypeId,
        "length": nextStageQty.text,
        "stage": nextId,
      }
    };
    print(BaseURL.updatePipeStage);
    print(bodyCreate.toString());

    Dio dio = Dio();
    Response response = await dio.post(
        BaseURL.updatePipeStage,
        data:jsonEncode(bodyCreate),
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        )
    );
    try{

      Navigator.pop(context);
      var resData = response.data['data'];
      var strStatus = resData['status'];
      print(strStatus);
      if (strStatus == 'Success') {
        Fluttertoast.showToast(
          msg: 'Pipe Stage Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
          msg: resData['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
    on DioError catch (e) {
      print(e.response?.data);
      print(e.response?.headers);
    }

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
              'Pipe Process',
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

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: DropdownSearch<String>(
                              items: itemListId,
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownButtonProps: DropdownButtonProps(color: Colors.black,),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                textAlignVertical: TextAlignVertical.center,

                              ),
                              onChanged: (value) {
                                setState(() {
                                  userTypeId = value.toString();
                                  for(int i=0;i<itemListId.length;i++){
                                    if(userTypeId==itemListId[i]){
                                      initialValue=itemListName[i];
                                    }
                                  }

                                  print(initialValue);
                                  print(userTypeId);

                                  setState(() {
                                    itemName.text=initialValue;
                                    gettingItemValues();
                                  });

                                });
                              },
                              selectedItem: userTypeId,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: currentStage,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Current Stage'),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: currentStageQty,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Current Stage Qty'),
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          Container(

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: DropdownSearch<String>(
                              items: nextListId,
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownButtonProps: DropdownButtonProps(color: Colors.black,),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                textAlignVertical: TextAlignVertical.center,

                              ),
                              onChanged: (value) {
                                setState(() {
                                  nextId = value.toString();
                                  for(int i=0;i<nextListId.length;i++){
                                    if(nextId==nextListId[i]){
                                      initialNext=nextListName[i];
                                    }
                                  }

                                  print(initialNext);
                                  print(nextId);

                                  setState(() {
                                    nextItemName.text=initialNext;
                                  });

                                });
                              },
                              selectedItem: nextId,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: nextStageQty,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Next Stage Qty'),
                            ),
                          ),




                          const SizedBox(height: 20.0),
                          Visibility(
                            visible: true,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Container(
                                // Your Button
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  child: const Text(
                                    'Update',
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

                                    createItem();
                                  },
                                ),
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
