import 'package:flutter/material.dart';
import 'package:flutter2/models/product1.dart';
import 'package:flutter2/utils/globalColors.dart';
import 'dart:ui';
import 'package:flutter2/view/MyHomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:timezone/timezone.dart';
import '../editprofile.dart';

TextEditingController productNameController = TextEditingController();
TextEditingController productImageURLController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productMarketController = TextEditingController();
TextEditingController productManufactureingController = TextEditingController();

late List<Product1> myList = [];

void _runFilter(String enteredKeyword) {
  List<Product1> results = [];

  results = myList;

  myList = results;
}

class cart03 extends StatefulWidget {
  const cart03({Key? key}) : super(key: key);
  @override
  _cart03State createState() => _cart03State();
}

class _cart03State extends State<cart03> {
  Timer? timer;
  int hours = 24;
  int minutes = 0;
  int seconds = 0;
  int _elapsedSeconds = 86400;
  int _countdown = 60;

  @override
  TextEditingController _textEditingController = TextEditingController();
  String text = "";

  @override
  void initState() {
    super.initState();

    // _startTimer();

    _textEditingController.text = text;
    myList = [];
    getPostsData();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (hours == 0 && minutes == 0 && seconds == 0) {
          timer.cancel();
        } else if (minutes == 0 && seconds == 0) {
          hours--;
          minutes = 59;
          seconds = 59;
        } else if (seconds == 0) {
          minutes--;
          seconds = 59;
        } else {
          seconds--;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  ScrollController controller = ScrollController();

  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  void getlistitem() async {
    myList = await fetch.viewbook();
  }

  void getPostsData() async {
    List<Widget> listItems = [];
    List<Product1> A = [];
    if (myList.isEmpty) myList = await fetch.viewbook();
    // future: wish(myList);
    myList.forEach((post) {
      listItems.add(Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: globalcolors.notetcolor,
              boxShadow: [
                BoxShadow(
                    color: globalcolors.notetcolor.withAlpha(100),
                    blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //         _formatDuration(Duration(seconds: _elapsedSeconds)),
                    //         style: TextStyle(fontSize: 17),
                    //       ),
                    Text(
                      post.productName + ", " + post.marketName,
                      // "product name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: globalcolors.maincolor,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "count: ${post.amount}, price: ${post.price} ₪",

                          // "count: 3",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: globalcolors.maincolor,
                          ),
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),

                    // Text(
                    //   post.marketName,
                    //   //"supermarket name",
                    //   style:  TextStyle(fontSize: 17,color: globalcolors.textcolor,),
                    // ),

                    // Text(
                    //   "price: ${post.price} ₪",
                    //   // "price:15 ₪",
                    //   style:  TextStyle(
                    //     fontSize: 17, fontWeight: FontWeight.bold,color: globalcolors.textcolor,),
                    // ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("are you sure delete this itme ?"),
                              titleTextStyle: TextStyle(
                                  color: globalcolors.textcolor, fontSize: 20),
                              backgroundColor: globalcolors.besiccolor,
                              actions: [
                                // const SizedBox(height:10),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            foregroundColor:
                                                globalcolors.maincolor,
                                            backgroundColor:
                                                globalcolors.notetcolor,
                                            minimumSize: Size(250, 50),
                                          ),
                                          child: Text(
                                            "delete",
                                            style: TextStyle(
                                                color: globalcolors.maincolor,
                                                fontSize: 25),
                                          ),
                                          onPressed: () {
                                            delete(post.id);
                                            getlistitem();
                                            getPostsData();
                                            Fluttertoast.showToast(
                                                msg:
                                                    "delete item done refrch to sure",
                                                textColor:
                                                    globalcolors.besiccolor);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // const SizedBox(height: 20),
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete_forever,
                      color: globalcolors
                          .textcolor), // The icon to display on the button.
                ),
                // Image.asset(post.image,width: 100,height: 100,),
                //  Image.asset('assets/images/p4.jpg',width: 100,height: 100,),
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    String timerText =
        '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    DateTime now = DateTime.now();
    // var time='${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    //print(time);
    var time = "remaining time 23:59:50";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            heightFactor: 1,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]);
                      })),
              Container(
                color:
                    Colors.white, // Set the background color of the container
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 260,
                      color: globalcolors.notetcolor,
                      padding: EdgeInsets.all(
                          10), // Optional: Add padding to the container
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Remaining Time = ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Text(
                            timerText,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Book now !'),
                          style: ElevatedButton.styleFrom(
                            primary: globalcolors.notetcolor,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () async {
                            book1();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void delete(int id) async {
    var res = await fetch.deleteitems(id);

    if (res != null) {
      Fluttertoast.showToast(
          msg: "delete id done refrch to sure",
          textColor: globalcolors.besiccolor);
    } else {}
  }

  void book1() {
    startTimer();
    // DateTime now = DateTime.now();
    //                          var time='${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    //                        print(time);
    //  _timer= Timer.periodic(Duration(seconds: 1), (Timer t) => _updateCountdown());
  }
}
