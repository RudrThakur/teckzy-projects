import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var switchValue = true;

    Widget switchButton = Column(
      children: [
        Text(
          "Cash Mode",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20.0),
        Transform.rotate(
          angle: -3.14 / 2, // -90 degree, vertical
          child: FlutterSwitch(
            width: 60.0,
            height: 30.0,
            valueFontSize: 0.0,
            toggleSize: 20.0,
            value: switchValue,
            borderRadius: 30.0,
            padding: 10.0,
            showOnOff: true,
            onToggle: (bool) {},
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Free Mode",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
      ],
    );

    Widget cups = Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Rs. ",
            style: TextStyle(
              fontSize: 10.0,
              color: Color(0xFF0969D0),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            " 2456",
            style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF0969D0),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Image.asset(
            "assets/Group 3632.png",
            height: 20.0,
            width: 20.0,
          ),
        ],
      ),
    );

    Widget appBar = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      decoration: BoxDecoration(
        color: Color(0xFF07126B),
        boxShadow: [new BoxShadow(blurRadius: 40.0)],
        borderRadius: new BorderRadius.vertical(
          bottom:
              new Radius.elliptical(MediaQuery.of(context).size.width, 50.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Colors.white,
            ),
            child: Icon(
              Icons.menu,
              size: 20.0,
              color: Color(0xFF0969D0),
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                child: Image.asset("assets/1. Background.png"),
                radius: 15.0,
              ),
              SizedBox(width: 5.0),
              Column(
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          switchButton,
          cups,
        ],
      ),
    );

    Widget header = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40.0),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xFFBCBCBC),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 10.0,
              ),
              onPressed: () {},
            ),
          ),
          Image.asset("assets/1-01.png",
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.30),
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xFFBCBCBC),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 10.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );

    Widget gameModeHeading = Container(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "SELECT GAME MODE",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    );

    Widget gameMode = Container(
      width: MediaQuery.of(context).size.width * 0.80,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF64B9DB), width: 2.0),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SOLO",
            style: TextStyle(
              color: Color(0xFFC7C7C9),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 10.0,
            ),
          ),
          Text(
            "VERSUS",
            style: TextStyle(
              color: Color(0xFFC7C7C9),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 10.0,
            ),
          ),
          Text(
            "TABLE",
            style: TextStyle(
              color: Color(0xFFC7C7C9),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );

    Widget gameType = Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                elevation: 18.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset(
                  "assets/1. Background.png",
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: 100.0,
                ),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(8.0),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                  color: Color(0xFF2F3593),
                ),
                child: Text(
                  'TYPE',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1. Background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 130.0,
                        child: header,
                      ),
                      Positioned(
                        top: 0.0,
                        child: appBar,
                      ),
                    ],
                  ),
                ),
                gameType,
                gameModeHeading,
                gameMode,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
