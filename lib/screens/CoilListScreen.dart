import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qmi_app/models/CoilListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/APIService.dart';
import '../../services/BaseURL.dart';
import '../Helpers/constant.dart';


class CoilListScreen extends StatefulWidget {

  const CoilListScreen({Key? key,}) : super(key: key);

  @override
  _CoilListScreen createState() => _CoilListScreen();
}

class _CoilListScreen extends State<CoilListScreen>{

  String strLoginId = "";
  String strLoginUserType = "";
  bool _isLoading = true;
  bool itemNotFound = false;
  CoilListModel? itemListModel;
  String strToken='';
  String strUserID='';

  TextEditingController searchController = TextEditingController();


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
    print(strToken);
    print(strUserID);
    getCoilList();

  }

  Future<void> getCoilList() async {
    print(BaseURL.coilList);
    Dio dio = Dio();
    Response response = await dio.post(
        BaseURL.coilList+'sid='+strToken,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        )
    );
    try {
      itemListModel = CoilListModel.fromJson(response.data);
      //Navigator.pop(context);
      setState(() {
        print(itemListModel?.data?.response?.length);
        if(itemListModel?.data?.response?.length!=0&&itemListModel?.data?.response?.length!=null){
          _isLoading = false;
          itemNotFound = true;
        }
        else{
          _isLoading = false;
          itemNotFound = false;
        }

      });

    } on DioError catch (e) {
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
              'Coils',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
              actions: <Widget>[
             InkWell(
                customBorder: new CircleBorder(),
                onTap: () async {


                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('editStatus', false);
                  prefs.setBool('createStatus', true);

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateItemScreen(),
                    ),
                  ).then((value) {
                    getItemsList();
                  });*/
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.add),
                )
      )
  ]
    ),
          body: _isLoading?
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 20),
              Text('Loading',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold,
                      fontFamily:
                      'Poppins-Semibold')),
            ],
          ) : itemNotFound==true?

          AnimationLimiter(
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0.0),
                              topLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(0.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0,
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0),
                          child: Column(children: [
                            SizedBox(height: 10.0),
                           /* Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (value) {
                                   // getFilterList();
                                  },
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 22,
                                      color: Colors.black,
                                    ),
                                    isDense: true,
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w700),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                            SizedBox(height: 20.0),
                            Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: itemListModel?.data?.response?.length,
                                  itemBuilder: (context, index) {

                                    return InkWell(
                                        onTap: () async {


                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setBool('editStatus', true);
                                          prefs.setBool('createStatus', false);

                                         /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CreateItemScreen(itemListModel: itemListModel,index:index),
                                            ),
                                          ).then((value) {
                                            getItemsList();
                                          });*/
                                        },

                                        child: AnimationConfiguration.staggeredList(
                                          position: 4,
                                          duration: const Duration(milliseconds: 300),
                                          child: SlideAnimation(
                                            verticalOffset: 44.0,
                                            child: FadeInAnimation(
                                              child: Container(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 10.0,bottom: 10,left: 10,right: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[

                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text('Coil Number :',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.black,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(itemListModel?.data?.response?[index].heatNo??'',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[

                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text('Weight :',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.black,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(itemListModel?.data?.response?[index].tcWeight.toString()??'',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[

                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text('Thickness :',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.black,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(itemListModel?.data?.response?[index].coilWidth.toString()??'',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[

                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text('Width :',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.black,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(itemListModel?.data?.response?[index].coilLength.toString()??'',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[

                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text('Avl Quantity :',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.black,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(itemListModel?.data?.response?[index].avlQty.toString()??'',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                      ],

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )


                                    );
                                  },
                                )
                            ),
                            SizedBox(height: 40.0),
                          ]

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ):

              Column(
                children: [
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left:20, right: 20, top: 30),
                    child: /*Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                       //   getFilterList();
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 22,
                            color: Colors.black,
                          ),
                          isDense: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 20,)
                  ),
                  Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20,right: 20, top: 40,bottom: 40),
                        child: Text(
                          'Coils not found',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Semibold'),
                        )),

                  ),
                ],
              )

      ),
    );
  }
}
