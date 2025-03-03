import 'dart:async';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _doctorName = TextEditingController();
  String _message = ""; // Initialisation pour éviter l'erreur

  @override
  void initState() {
    super.initState();
    _doctorName = TextEditingController();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _message,
              style: GoogleFonts.lato(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 55),
            IconButton(
              splashRadius: 20,
              icon: Icon(Icons.notifications_active),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationList()),
                );*/
              },
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Hello User",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 25),
              child: Text(
                "Let's Find Your\nDoctor",
                style: GoogleFonts.lato(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                controller: _doctorName,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200]!,
                  hintText: 'Search doctor',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900]!.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      splashRadius: 20,
                      color: Colors.white,
                      icon: Icon(FontAwesomeIcons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                onFieldSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchList(searchKey: value),
                      ),
                    );*/
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "We care for you",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.blue[800]!,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Specialists",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.blue[800]!,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Top Rated",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.blue[800]!,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
