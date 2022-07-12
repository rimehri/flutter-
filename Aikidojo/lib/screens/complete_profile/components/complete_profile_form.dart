import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stage/components/custom_surfix_icon.dart';
import 'package:stage/components/default_button.dart';
import 'package:stage/components/form_error.dart';
import 'package:stage/screens/otp/otp_screen.dart';
import 'package:stage/screens/profile/profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:stage/screens/add_training/utils.dart';
import 'package:stage/screens/add_training/button_widget.dart';
import 'package:intl/intl.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  DateTime dateTime = DateTime.now();
  var date_selected = DateFormat('yyyy/MM/dd').format(DateTime.now());
  var lat;
  String madina = "";
  String country = "Select Your Adress ";
  String local = "";
  Position cl;
  var long;
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
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
String Natinality;
  TextEditingController _nation = TextEditingController();
  TextEditingController _phone = TextEditingController();
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 0, right: 0, top: 20),
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
              controller: _nation,

              onSaved: (newValue) {
                return Natinality = _nation.text;
              },
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),

              decoration: InputDecoration(
                // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
                icon: Icon(
                  Icons.flag,
                  color: Color.fromRGBO(200, 25, 25, 0.5),
                ),
                hintText: "Nationality",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

              ),
              // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(0)),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 0, right: 0, top: 20),
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
              controller: _phone,

              onSaved: (newValue) {
                return phoneNumber = _phone.text;
              },
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),

              decoration: InputDecoration(
                // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
                icon: Icon(
                  Icons.phone,
                  color: Color.fromRGBO(200, 25, 25, 0.5),
                ),
                hintText: "Phone Number",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

              ),
              // cursorColor:Color.fromRGBO(200, 25, 25, 0.5),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 5, right: 5, top: 20),
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

                Icon( Icons.add_location_alt,
                  color: Color.fromRGBO(200, 25, 25, 0.5),),
                const SizedBox(width: 20),
                Container(



                  child: new Text(
                    '$country' + ' ' + '$local' + ' ' + '$madina',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),



                  ),
                ),

                //
              ],
            ),
          ),
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
                var xy = await gmc.getLatLng(
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
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }



  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Nationality",
        hintText: "Enter your Nationality",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
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
  @override
  void initState() {

    getPermission();
    getLatAndLong();

    super.initState();
  }
}
