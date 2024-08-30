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

class AddRawMaterailCoil extends StatefulWidget {
  List<Map<String, dynamic>> itemData = [];
  final int? index;
  AddRawMaterailCoil({Key? key,required this.itemData, @required this.index}) : super(key: key);

  @override
  _AddRawMaterailCoil createState() => _AddRawMaterailCoil(this.itemData, this.index);
}

class _AddRawMaterailCoil extends State<AddRawMaterailCoil> {

  List<Map<String, dynamic>> itemData = [];
  int? index;
  _AddRawMaterailCoil(this.itemData, this.index);
  late var itemName = TextEditingController();
  late var heatNos = TextEditingController();
  late var quantity = TextEditingController();
  var itemNumber;
  String strToken = '';
  String strUserID = '';
  String initialValue = '99';
  String userTypeId = 'Coil';
  bool strEditAddOn=false;
  bool strCreateAddOn=false;

  var itemListName = [
    '99',
  ];

  var itemListId = [
    'Coil',
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
    strToken = prefs.getString('userToken') ?? '';
    strUserID = prefs.getString('strUserID') ?? '';
    strEditAddOn = prefs.getBool('editAddOn')??false;
    strCreateAddOn = prefs.getBool('createAddOn') ?? false;
    itemNumber = index?.toInt() ?? 0;
    if(strEditAddOn==true){

      userTypeId=itemData[itemNumber]['coil_no'];
      heatNos.text=itemData[itemNumber]['heat_no'];
      quantity.text=itemData[itemNumber]['avl_qty'].toString();

    }

    getItemCode();
    setState(() {});
  }


  Future<void> getItemCode() async {
    Dio dio = Dio();
    Response response = await dio.get(
      // BaseURL.getItemGroup+'Type=Role&PartyId='+strLoginId,
      BaseURL.coilNoDropDown + 'sid=' + strToken,
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
    Dio dio = Dio();
    Response response = await dio.get(
      BaseURL.coilIdDetail +
          'sid=' +
          strToken +
          '&name=' +
          userTypeId,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON data
      Map<String, dynamic> responseData = response.data;
      heatNos.text = responseData['data']['response']['heat_no'];
      quantity.text = responseData['data']['response']['avl_qty'].toString();

      setState(() {

      });

    } else {
      // Handle the case where the request was not successful
      print('Request failed with status code: ${response.statusCode}');
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
              'Coil Data',
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
                                  });
                                  gettingItemValues();
                                });
                              },
                              selectedItem: userTypeId,
                            ),
                          ),
                          /*const SizedBox(height: 20.0),

                          Container(
                            height: 50,
                            child: TextField(
                              readOnly: true,
                              controller: itemName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Item Name'),
                            ),
                          ),*/


                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: heatNos,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Heat Nos'),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: quantity,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: kBlackColor)
                                  ),
                                  labelText: 'Avl Quantity'),
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
                                      (itemData[i]['coil_no']=userTypeId);
                                      (itemData[i]['heat_no']=heatNos.text);
                                      (itemData[i]['avl_qty']=quantity.text);
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
