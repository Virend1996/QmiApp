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


class CreateSubPipes extends StatefulWidget {


  const CreateSubPipes({Key? key}) : super(key: key);

  @override
  _CreateSubPipes createState() => _CreateSubPipes();
}

class _CreateSubPipes extends State<CreateSubPipes> {

  bool checkTerms = false;
  bool _isLoading = true;

  String strLoginId = "";
  String strLoginUserType = "";
  DateTime selectedDate = DateTime.now();
  var transactionDate;
  String fromDate = 'Select Date';
  String strToken='';
  String strUserID='';
  List<DataRow> _rowList = [];
  List<Map<String, dynamic>> itemData = [];
  late var itemName = TextEditingController();
  late var pipeSize = TextEditingController();
  late var pipeLength = TextEditingController();
  late var remPipeLength = TextEditingController();
  String initialValue = '99';
  String userTypeId = 'Pipe Number';
  var itemListName = [
    '99',

  ];

  var itemListId = [
    'Pipe Number',

  ];
  ItemGroupModel? itemGroupModel;

  void _addRow() {
    // Built in Flutter Method.
    setState(() {
      itemData.add({
        "sub_pipe_no": "",
        "length": "",
        "weight": "",
      });

      _rowList.clear();
      setState(() {
        for (int i = 0; i < itemData.length; i++) {
          _rowList.add(DataRow(cells: <DataCell>[

            DataCell(Center(child: Text(i.toString()))), //s sno
            DataCell(Center(child: Text(itemData[i]['sub_pipe_no']))),
            DataCell(Center(child: Text(itemData[i]['length']))),
            DataCell(Center(child: Text(itemData[i]['weight']))),
            DataCell(showEditIcon: true, onTap: () async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('editAddOn', false);
              prefs.setBool('createAddOn', true);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddSubPipes(itemData: itemData, index: i),
                ),
              ).then((value) {
                setState(() {
                  updateList(i);
                });
              });
            }, Center(child: Text('Edit'))),
          ]));
        }
        print(_rowList.length);
      });

    });
  }
  updateList(int position) {
    print(itemData);




    setState(() {
      _rowList.clear();
      for (int i = 0; i < itemData.length; i++) {
        _rowList.add(DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(i.toString()))), //s sno
          DataCell(Center(child: Text(itemData[i]['sub_pipe_no']))),
          DataCell(Center(child: Text(itemData[i]['length']))),
          DataCell(Center(child: Text(itemData[i]['weight']))),
          DataCell(showEditIcon: true, onTap: () async {

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('editAddOn', true);
            prefs.setBool('createAddOn', false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddSubPipes(itemData: itemData, index: i),
              ),
            ).then((value) {
              setState(() {
                updateList(i);
              });
            });
          }, Center(child: Text('Edit'))),
        ]));
      }
    });
  }



  Future<void> _selectDate(BuildContext context, int status) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        transactionDate = formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
        print(transactionDate.toString());
        if(status==1){
          fromDate = transactionDate.toString();
        }
      });
    }
  }
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

    getItemCode();
    setState(() {

    });
  }


  Future<void> gettingItemValues() async {
    print(userTypeId);
    Dio dio = Dio();
    Response response = await dio.get(
      BaseURL.getPipeDetails + 'sid=' + strToken + '&user_id=' + strUserID + '&pipe_no=' + userTypeId,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON data
      Map<String, dynamic> responseData = response.data;
      pipeSize.text = responseData['data']['response']['pipe_size'];
      pipeLength.text = responseData['data']['response']['length'].toString();


      setState(() {

      });

    } else {
      // Handle the case where the request was not successful
      print('Request failed with status code: ${response.statusCode}');
    }

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
       /* "start_time": fromDate,*/
        "pipe_no": userTypeId,
        "pipe_size": pipeSize.text,
        "length": pipeLength.text,
        "sub_pipe": itemData,


      }
    };
    print(BaseURL.createSubPipes);
    print(bodyCreate.toString());

    Dio dio = Dio();
    Response response = await dio.post(
        BaseURL.createSubPipes,
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
          msg: 'Sub Pipe Created',
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
                          GestureDetector(
                            onTap: () {
                              _selectDate(context, 1);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.date_range,
                                          color: kBlackColor),
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: appColor)),
                                      labelText: fromDate),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
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
                              controller: pipeSize,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Pipe Size'),
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
                              controller: remPipeLength,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Remaining Pipe Length'),
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          Visibility(
                            visible: true,
                            child: Card(
                              elevation: 1,
                              //color: Colors.greenAccent[100],
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // height: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      //SizedBox
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Sub Pipes',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ), //Textstyle
                                        ),
                                      ), //Text
                                      const SizedBox(
                                        height: 10,
                                      ), //SizedBox
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                              showCheckboxColumn: false,
                                              sortAscending: true,
                                              border: const TableBorder(
                                                top:  BorderSide(width: 1,color: Colors.grey),
                                                left:  BorderSide(width: 1,color: Colors.grey),
                                                right:  BorderSide(width: 1,color: Colors.grey),
                                                bottom:  BorderSide(width: 1,color: Colors.grey),
                                                verticalInside:  BorderSide(width: 1,color: Colors.grey),

                                              ),
                                              columns: [
                                                DataColumn(
                                                  label: Text('No'),
                                                ),
                                                DataColumn(
                                                  label: Text('Pipe Number'),
                                                ),
                                                DataColumn(
                                                  label: Container(
                                                    child: Text('Pipe Length'),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text('Weight'),
                                                ),

                                                DataColumn(
                                                  label: IconButton(
                                                    iconSize: 20,
                                                    icon: const Icon(Icons.settings,color: Colors.black26,),
                                                    onPressed: () {
                                                      // ...
                                                    },
                                                  ),
                                                ),
                                              ],
                                              rows: _rowList)
                                      ),//Text
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Container(
                                              // Your Button
                                              height: 40,
                                              width: 110,
                                              child: ElevatedButton(
                                                child: const Text(
                                                  'Add',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  // primary: Colors.purple,
                                                  primary: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _addRow();
                                                  });

                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Container(
                                              // Your Button
                                              height: 40,
                                              width: 110,
                                              child: ElevatedButton(
                                                child: const Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  // primary: Colors.purple,
                                                  primary: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25)),
                                                ),
                                                onPressed: () {

                                                  setState(() {
                                                    _rowList.removeLast();
                                                    itemData.removeLast();

                                                  });

                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )//SizedBox

                                    ],
                                  ), //Column
                                ), //Padding
                              ), //SizedBox
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
                                    'Create',
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
