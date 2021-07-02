import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      padding: const EdgeInsets.all(20.0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.60,
        color: const Color(0xFF44AF51),
        onPressed: () => {},
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 5.0,
            color: Color(0xFF8CDE77),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: const Text(
          "START GAME",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    Widget conditions = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const [
          Text(
            'CONDITIONS:',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "READ ALL CONDITIONS!",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 9.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      bottomNavigationBar: const NyxBottomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1. Background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const NyxAppBar(),
                conditions,
                const PricingBox(
                  rank: '1',
                  cost: '10',
                  bgcolor: 0xFFE8AD21,
                  isRank1: true,
                ),
                const PricingBox(
                  rank: '2',
                  cost: '8',
                  bgcolor: 0xFF919191,
                  isRank1: false,
                ),
                const PricingBox(
                  rank: '3',
                  cost: '6',
                  bgcolor: 0xFF4E3B10,
                  isRank1: false,
                ),
                const PricingBox(
                  rank: '4-10',
                  cost: '3',
                  bgcolor: 0xFF0969D0,
                  isRank1: false,
                ),
                const PricingBox(
                  rank: '10-20',
                  cost: '2',
                  bgcolor: 0xFF0969D0,
                  isRank1: false,
                ),
                const SizedBox(height: 20.0),
                button,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PricingBox extends StatelessWidget {
  final rank;
  final cost;
  final bgcolor;
  final isRank1;

  const PricingBox({Key? key, this.rank, this.cost, this.bgcolor, this.isRank1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(bgcolor),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.vertical(
            top: (isRank1 == true)
                ? const Radius.circular(25.0)
                : const Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Rank " + rank,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            "Rs. " + cost,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class NyxAppBar extends StatelessWidget {
  const NyxAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 25.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
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
                            width: MediaQuery.of(context).size.width * 0.25),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "SPORTS",
                          style: TextStyle(
                            color: Color(0xFF0B56C9),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0B56C9),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    "WATCH DEMO",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8.0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 60.0,
                                bottom: 20.0,
                                child: Icon(
                                  Icons.play_circle_fill_rounded,
                                  color: Colors.green,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.25,
              left: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4.0,
                    color: Colors.red,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Prize: ",
                      style: TextStyle(
                        color: Color(0xFF0B56C9),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rs. 150",
                      style: TextStyle(
                        color: Color(0xFF0B56C9),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.22,
              right: MediaQuery.of(context).size.width * 0.10,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4.0,
                      color: Colors.white,
                    ),
                    color: Color(0xFF0B56C9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Entry:",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " Rs. 30",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Divider(
                        height: 1.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Life Lines: 0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NyxBottomAppBar extends StatelessWidget {
  const NyxBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF064894),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: Colors.red),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: MediaQuery.of(context).size.height * 0.12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Special Pass',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Transform.scale(
                  scale: 2,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Image.asset(
                      "assets/Group 2723.png",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Leaderboard',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Transform.scale(
                  scale: 2,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Image.asset(
                      "assets/Group 2724.png",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Transform.scale(
                  scale: 2,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Image.asset(
                      "assets/Group 2730.png",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Features',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Transform.scale(
                  scale: 2,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Image.asset(
                      "assets/Group 2726.png",
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Game Types',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Transform.scale(
                  scale: 2,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Image.asset(
                      "assets/Group 2727.png",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
