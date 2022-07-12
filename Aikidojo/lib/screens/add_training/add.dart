import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';

import 'dart:convert';
import 'package:stage/Entities/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/components/form_error.dart';
import 'package:stage/config/public_vars.dart';
import 'package:stage/screens/add_training/utils.dart';
import 'package:stage/screens/add_training/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stage/screens/profile/UIprofil.dart';


import '../../constants.dart';
class addScreen extends StatefulWidget {
  static String routeName = "/addstage";

@override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<addScreen> {
  SharedPreferences sharedPreferences;
  Position cl;

  int _radioValue = 0;
  final _formKey = GlobalKey<FormState>();
  Position AdressStage;

  var latstage;
  var longstage;
  var lat;
  String madina = "";
  String country = "Select Your Adress From Map";
  String local = "";
  String Result;
  Color resultat_color;
  String title1;
  final List<String> errors = [];
  TextEditingController _tit = TextEditingController();
  TextEditingController _catego = TextEditingController();
  var long;
  String id_user;
  String categorie1;
  String sensei1;
  List<Place> place;
  List<Stage> stage;
  GoogleMapController gmc;

  Set <Marker> mymarker = {

    Marker(
        onTap: () {
          print("");
        },
        draggable: true,
        onDragEnd: (LatLng t) {
          print("end drag");
          print(t.longitude);
          print(t.latitude);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(
            title: "",
            onTap: () {
              print("1");
            }),
        position: LatLng(777, 777)),

  };

  CameraPosition _kGooglePlex;
  DateTime dateTime = DateTime.now();
  var date_selected = DateFormat('yyyy/MM/dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) => initWidget();


  Future<User> addstage(List <Stage>stage) async {
    final response = await http.put(
      Uri.parse(baseUrl + '/user/stage/add/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <dynamic, dynamic>{
            'title': _tit.text,
            'category': "International",
            'sensei': _catego.text,
            'date': date_selected,
            'longitude': long,
            'latitude': lat,
            'id': id_user
          }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.


    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("not logged");
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      throw Exception('Failed to create product.');
    }
  }


  Widget initWidget() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(168, 40, 40, 1,),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, ProfileUI2.routeName)
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)),
                  color: Color.fromRGBO(168, 40, 40, 1),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(168, 40, 40, 1),
                    Color.fromRGBO(168, 40, 40, 1),
                  ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Image.asset(
                              'assets/images/aa.png',
                              height: 175,
                              width: 200,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, top: 10),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "New Seminar",

                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
              forume(),
              SingleChildScrollView(

                  child: Column(
                      children: [


                          _kGooglePlex == null
                              ? CircularProgressIndicator(
                              color: Color.fromRGBO(200, 25, 25, 0.5))
                              : Container(
                            margin: EdgeInsets.only(left: 0, right: 0, top: 5),

                            width: 400,
                            height: 400,
                            child: GoogleMap(
                              markers: mymarker,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onTap: (LatLng t) async {
                                List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    t.latitude, t.longitude);
                                print(placemarks[0].country);
                                print(placemarks[0].administrativeArea);
                                print(placemarks[0].locality);
                                print(placemarks[0].subLocality);
                                print(placemarks[0].postalCode);
                                print(placemarks[0].street);

                                setState(() {
                                  country = placemarks[0].country;
                                  local = placemarks[0].administrativeArea;
                                  madina = placemarks[0].subLocality;
                                });

                                mymarker.remove(
                                    Marker(markerId: MarkerId("1")));
                                mymarker.add(Marker(markerId: MarkerId("1"),
                                    position: t,
                                    infoWindow: InfoWindow(
                                        title: placemarks[0].country + "," +
                                            placemarks[0].administrativeArea +
                                            "," + placemarks[0].locality
                                    )));
                                LatLng latlang = LatLng(
                                    t.latitude, t.longitude);
                                gmc.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(target: latlang,
                                            zoom: 10,
                                            tilt: 20)));
                                var xy = awai t gmc.getLatLng(
                                    ScreenCoordinate(x: 100, y: 100));
                                var zo = await gmc.getZoomLevel();
                                print(xy);
                                print(zo);
                                // votreAdress = await getLatAndLong();
                                // print(cl.latitude);
                                // print(cl.longitude);

                              },
                              onMapCreated: (
                                  GoogleMapController controller) async {
                                gmc = controller;
                              },
                            ),
                          ),


                        GestureDetector(
                          onTap: () async {
                            print("hhhh");
                            print(_tit.text);
                            print(_catego.text);
                            print(title1);
                            print(date_selected);
                            print(country);
                            print(long);
                            User u = await addstage(stage);
                            print(u);
                            Fluttertoast.showToast(
                                msg: "Training created successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },


                          child: Container(

                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(238, 58, 58, 1),
                                Color.fromRGBO(188, 29, 29, 1)
                              ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 50,
                                    color: Color(0xffEEEEEE)),
                              ],
                            ),
                            child: Text(
                              "Add Training",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),


                        ),
                      ]
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget buildDatePicker() =>
      SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 1920,
          maximumYear: DateTime
              .now()
              .year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Future getPermission() async {
    bool service;
    LocationPermission permission;
    service = await Geolocator.isLocationServiceEnabled();
    print(service);
    if (service == false) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          title: "services",
          body: Text("Services Not enable"))
        ..show();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // if(permission == LocationPermission.always){
    //   getLatAndLong();
    // }
    return permission;
  }

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 10,
    );

    setState(() {});
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  //Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    getSharedPrefs();
    getPermission();
    getLatAndLong();

    super.initState();
  }

  Widget forume() =>
      Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)
                  ),
                ],
              ),
              child: TextFormField(
                controller: _tit,

                onSaved: (newValue) {
                  return title1 = _tit.text;
                },
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),

                decoration: InputDecoration(
                  // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
                  icon: Icon(
                    Icons.work,
                    color: Color.fromRGBO(200, 25, 25, 0.5),
                  ),
                  hintText: "Title",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,

                ),
                // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)
                  ),
                ],
              ),
              child: TextFormField(
                controller: _catego,
                onSaved: (newValue) {
                  return title1 = _tit.text;
                },
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                //
                decoration: InputDecoration(
                  // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
                  icon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(200, 25, 25, 0.5),
                  ),
                  hintText: "Sensei",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,

                ),
                // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
              ),
            ),
            // Container(
            //   alignment: Alignment.topRight,
            //   margin: EdgeInsets.only(left: 0, right: 20 , top: 10),
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   height: 40,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(50),
            //     color: Color(0xfffEEE),
            //     boxShadow: [
            //       BoxShadow(
            //           offset: Offset(0, 20),
            //           blurRadius: 50,
            //           color: Color(0xffEEEEEE)
            //       ),
            //     ],
            //
            //   ),
            //   // child: Row(
            //   //   children: [
            //   //     Radio(value: 1, groupValue: _radioValue, onChanged: (value){
            //   //       setState(() {
            //   //
            //   //         _radioValue = value;
            //   //       });
            //   //     }),
            //   //     Text("International"),
            //   //     Radio(value: 2,
            //   //         groupValue: _radioValue,
            //   //
            //   //         onChanged: (value){
            //   //       setState(() {
            //   //
            //   //         _radioValue = value;
            //   //       });
            //   //     }),
            //   //     Text("National")
            //   //   ],
            //   // ),
            //
            // ),

            Container(


              child: Row(

                children: [
                  ButtonWidget(
                    text: date_selected,
                    onClicked: () =>
                        Utils.showSheet(
                          context,

                          child: buildDatePicker(),
                          onClicked: () async {
                            final value = DateFormat('yyyy/MM/dd').format(
                                dateTime);
                            // Utils.showSnackBar(context, 'Selected "$value"');


                            setState(() {
                              date_selected = value;
                            });


                            Navigator.pop(context);
                          },
                        ),

                  ),


                ],
              ),


            ),

            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(left: 20, right: 5, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)
                  ),
                ],
              ),


              child: Row(

                children: [
                  IconButton(onPressed: () {}, icon: Icon(
                    Icons.add_location_alt,
                    color: Color.fromRGBO(200, 25, 25, 0.5),
                  ),),
                  Container(


                    child: new Text(
                      '$country' + ' ' + '$local' + ' ' + '$madina',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),


                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      );

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id_user = prefs.getString("id");
    });
  }
}