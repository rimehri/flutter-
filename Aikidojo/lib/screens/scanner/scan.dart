
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:stage/Home_aikidoka/home_screen.dart';
//import 'package:TunCoinWallet/pages/menu.dart';

class Scan extends StatefulWidget {
  static String routeName = "/Scan";
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qrResult = "Not yet Scanned";
  //String routeName ="/scan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Scan"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff001a33),
          ),
           onPressed: () => Navigator.of(context)
               .pushReplacement(MaterialPageRoute(builder: (context) => Home_aikido())),
        ),
        backgroundColor: Color.fromRGBO(168, 40, 40, 1,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code_scanner_rounded),
            color: Color(0xff001a33),
            onPressed: () {
              print("");
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "ID EVENT ",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff001a33)),
              textAlign: TextAlign.center,
            ),
            Text(
              qrResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: Color(0xff001a33)),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () async {
                String scaning = await BarcodeScanner.scan();

                setState(() {
                  this.qrResult = scaning;
                });
              },
              child: Text('SCAN QR CODE',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Color(0xff001a33),
                  )),
              textColor: Color(0xff001a33),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color(0xff001a33),
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
      ),
    );
  }
}
