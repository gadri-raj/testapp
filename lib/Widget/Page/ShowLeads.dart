import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../Config/CustomColors.dart';
import '../../Screens/ErrorScreen.dart';
import '../../Services/Services.dart';

class ShowLeads extends StatefulWidget {
  @override
  _ShowLeadsState createState() => _ShowLeadsState();
}

class _ShowLeadsState extends State<ShowLeads>
    with AutomaticKeepAliveClientMixin<ShowLeads> {
  final Color blueColor = CustomColor().blueColor;
  Map map = {};
  int i = 0;
  int totalpage = 0;
  bool hasMore = false;
  bool isloading = true;
  var isUpcoming = true;

  @override
  void initState() {
    NotaryServices().getToken();
    getData();
    super.initState();
  }

  getData() async {
    map.clear();
    setState(() {
      i = 0;
      isloading = true;
      hasMore = false;
    });
    map = await NotaryServices().getLeads("62421089c913294914a8a35f", i);
    print("map 41 amount.dart:");
    print(map.keys);

    // print("oooooo"+ map["leads"][0]);
    if (i == map['pageNumber']) {
      hasMore = true;
    }
    i += 1;

    setState(() {
      totalpage = map['pageNumber'];
      isloading = false;
    });
  }

  getmoreData() async {
    var response = await NotaryServices().getLeads("62421089c913294914a8a35f", i);
    // print("Inside getMore Data");
    // List payouts = map['payouts'];
    // print(payouts);
    if (map['leads'] != null) {
      response['lead'] != null
          ? map['leads'].addAll(response['lead'])
          : map['leads'];
    }
    if (response['pageCount'] == response['pageNumber']) {
      hasMore = true;
    } else {
      i = i + 1;
    }
    setState(() {});
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    print(" this is notaryID : ${"62421089c913294914a8a35f"}\n");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Leads List",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: !isloading
          ? LazyLoadScrollView(
          onEndOfPage: getmoreData,
          isLoading: hasMore,
          child: RefreshIndicator(
            color: Colors.black,
            onRefresh: () => getData(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: map['leads'].isNotEmpty
                    ? Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white24,
                  ),
                  Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Card(
                                color: Colors.grey,
                                child: Container(
                                  height: 110,
                                  width: 190,
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      // Image.asset("assets/brown.jpg",height: 110,width: 190,fit: BoxFit.fill,),

                                      Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Center(
                                                child: Text("Total Leads",
                                                    style: TextStyle(
                                                      fontSize: 26,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ))),
                                            Text(
                                              (map['leadCount']).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 31),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: 550,
                              padding: EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: map['leads'].length,
                                  itemBuilder: (context, index) {
                                    // print(map['leads'][index]['name']);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        highlightColor:
                                        Colors.transparent,
                                        child: Card(
                                          elevation: 2.5,
                                          // color: Colors.black54,
                                          shadowColor: Colors.blueGrey,
                                          // Color.fromARGB(255, 188, 188, 188),
                                          child: Container(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width -
                                                50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                // border: Border.all(
                                                //     color: Colors.black),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        3))),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    left: 75,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          map['leads']
                                                          [index]
                                                          ['name'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              22),
                                                        ),
                                                        SizedBox(
                                                            height: 12),
                                                        Text(
                                                          map['leads'][
                                                          index]
                                                          [
                                                          'PhoneNumber']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              16),
                                                        ),
                                                        SizedBox(
                                                            height: 8),
                                                        Text(
                                                          map['leads']
                                                          [index]
                                                          ['email'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              16),
                                                        ),
                                                      ],
                                                    )),
                                                Positioned(
                                                  top: 35,
                                                  left: 2,
                                                  child: Image.asset(
                                                    "assets/userr.png",
                                                    height: 60,
                                                    width: 65,
                                                  ),
                                                ),
                                                // Positioned(
                                                //
                                                //   right: 10,
                                                //   child: Chip(
                                                //     backgroundColor: Color.fromARGB(100, 169, 109, 190),
                                                //     label: Text(map['leads'][index]['type'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),),
                                                //   ),
                                                // ),
                                                Positioned(
                                                  top: 30,
                                                  right: 1,
                                                  child: IconButton(
                                                    splashColor: Colors
                                                        .lightBlueAccent,
                                                    onPressed: () {},
                                                    icon: Icon(Icons.call,
                                                        size: 18),
                                                    color:
                                                    Colors.blueAccent,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ],
                      ))
                ])
                    : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      56,
                  child: ErrorScreens("assets/user.png",
                      "No Leads found", "Create some lead", false),
                ),
              ),
            ),
          ))
          : Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 17,
              width: 17,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Please Wait ...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
