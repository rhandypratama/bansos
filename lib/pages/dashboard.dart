import 'package:bansos/pages/kelompok/home.dart';
import 'package:bansos/pages/penyaluran.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var f = NumberFormat('#,##0', 'id_ID');
  int _totalTransaksi = 0;
  int _totalPenerima = 0;
  // var _totalPenerimaKelompok = {
  //   'pondok jeruk kulon': 0,
  //   'siti': 0,
  //   'poniyem': 0,
  //   'sulastri': 0,
  //   'sumaiyah': 0,
  //   'non pkh': 0,
  // };
  // int _totalPenerimaSiti = 0;
  // int _totalPenerimaSumaiyah = 0;
  // int _totalPenerimaPoniyem = 0;
  // int _totalPenerimaSulastri = 0;
  // int _totalPenerimaNonPkh = 0;
  // int _totalPenerimaNonPdkJrkKulon = 0;

  // var date = DateTime.now().month.toString();
  // dateNew = DateTime.parse(DateTime.now().month.toString());
  // final DateFormat formatter = DateFormat('dd/MM/yyyy | hh:mm');
  // final formatted = formatter.format(dateNew);
  
  // CollectionReference totalPenyalurans = FirebaseFirestore.instance
  // QuerySnapshot totalPenyalurans = firestore.
  //   .collection('penyalurans')
  //   .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1));
  //   // .get();
  
  countPenerima() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('penerimas').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      _totalPenerima = _myDocCount.length; 
    });   // Count of Documents in Collection
  }

  // countPenerimaPdkJrkKulon() async {
  //   QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('penerimas').where('kelompok', isEqualTo: 'pondok jeruk kulon').get();
  //   List<DocumentSnapshot> _myDocCount = _myDoc.docs;
  //   setState(() {
  //     _totalPenerimaNonPdkJrkKulon = _myDocCount.length; 
  //   });
  // }

  countTransaksi() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('penyalurans').where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1)).get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      _totalTransaksi = _myDocCount.length; 
    });   // Count of Documents in Collection
  }

  List<dynamic> _kelompok = [];
  getKelompok() async {
    var dt = await FirebaseFirestore.instance
      .collection('kelompoks')
      .orderBy('nama')
      .get();
    setState(() {
      _kelompok = dt.docs.map((e) => e.data()['nama']).toList();
    });
    // print(_kelompok);
    // return "complete";
  }

  // Future<String> getData() async {
  //   QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('penyalurans').get();
  //   List<DocumentSnapshot> _myDocCount = _myDoc.docs;
  //   return _myDocCount.length.toString();
    
  // }

  @override
  void initState() {
    countPenerima();
    countTransaksi();
    getKelompok();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    countPenerima();
    countTransaksi();
    getKelompok();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset("assets/icons/user.svg", height: 30,),
              onPressed: () {
                // navigationManager(context, ProfileScreen(
                //   // googleSignIn: googleSignIn,
                //   // user: widget.user,
                // ), isPushReplaced: false);
              },
            ),
            // Container(
            //   width: 40,
            //   height: 40,
            //   margin: EdgeInsets.only(right: 10),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(5),
            //     child: Image.network(
            //       'https://i.pravatar.cc/100',
            //     ),
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Administrator',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   'Feb 25, 2018',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ],
        ),
        // actions: <Widget>[
        //   FlatButton(
        //     onPressed: () {},
        //     child: Stack(
        //       overflow: Overflow.visible,
        //       children: <Widget>[
        //         Container(
        //           width: 50,
        //           child: Icon(
        //             Icons.notifications,
        //             color: Colors.black87,
        //             size: 35,
        //           ),
        //         ),
        //         Positioned(
        //           top: 0,
        //           right: 0,
        //           width: 20,
        //           height: 20,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(25),
        //               color: Colors.red,
        //             ),
        //             width: 20,
        //             height: 20,
        //             child: Center(
        //               child: Text(
        //                 '03',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 9,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(14, 30, 14, 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   width: 70,
                //   height: 70,
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color: Theme.of(context).primaryColor.withAlpha(50),
                //   ),
                //   child: Image.asset(
                //     'assets/img/shoe.png',
                //     width: 60,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 30),
                // ),
                
                StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('penyalurans')
                    .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                    .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                    // if (!mounted) setState(() => _totalTransaksi = snapshot.data.docs.length);
                    return new Text(
                      f.format(snapshot.data.docs.length).toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 80,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold,
                      ),
                    );
                    // ListView(
                    //   children: snapshot.data.documents.map((DocumentSnapshot document) {
                    //     return new ListTile(
                    //       title: new Text(document.data()['full_name']),
                    //       subtitle: new Text(document.data()['company']),
                    //     );
                    //   }).toList(),
                    // );
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 0),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Text(
                          //   '0 penerima'.toUpperCase(),
                          //   style: TextStyle(
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          
                          StreamBuilder<QuerySnapshot>(
                            stream: firestore.collection('penerimas').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("TOTAL SELURUH PENERIMA 0");
                              }
                              if (!mounted) setState(() => _totalPenerima = snapshot.data.docs.length);
                              return Text(
                                'TOTAL SELURUH PENERIMA ${f.format(snapshot.data.docs.length).toString()}'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                      SizedBox(height: 10),
                      LinearPercentIndicator(
                        lineHeight: 8.0,
                        // percent: (_totalTransaksi >= _totalPenerima) ? 1.0 : double.parse((_totalTransaksi/_totalPenerima).toStringAsFixed(1)),
                        percent: (_totalTransaksi >= _totalPenerima) ? 1.0 : double.parse((_totalTransaksi/_totalPenerima).toString().substring(0,3)),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: Theme.of(context).accentColor.withAlpha(30),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70),
                      ),
                      Text(
                        // 'total ${(_totalTransaksi >= _totalPenerima) ? 1.0 : double.parse((_totalTransaksi/_totalPenerima).toStringAsFixed(1))} transaksi bulan ${DateFormat('MMMM yyyy').format(DateTime.now())}'.toUpperCase(),
                        // 'total ${double.parse((_totalTransaksi/_totalPenerima).toString().substring(0,3))} transaksi bulan ${DateFormat('MMMM yyyy').format(DateTime.now())}'.toUpperCase(),
                        'total transaksi bulan ${DateFormat('MMMM yyyy').format(DateTime.now())}'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Bebas',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      // Text(
                      //   'You walked 165 min today',
                      //   style: TextStyle(
                      //     color: Theme.of(context).accentColor,
                      //     fontSize: 16,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'SEMBAKO',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: firestore.collection('penyalurans')
                                .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                                .where('jenis', isEqualTo: 'sembako')
                                .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("0 transaksi");
                                }
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${f.format(snapshot.data.docs.length).toString()}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' transaksi',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'UANG TUNAI',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: firestore.collection('penyalurans')
                                .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                                .where('jenis', isEqualTo: 'uang tunai')
                                .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("0 transaksi");
                                }
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${f.format(snapshot.data.docs.length).toString()}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' transaksi',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'ESTIMASI TOTAL PENDAPATAN',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/up_red.png',
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: firestore.collection('penyalurans')
                            .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("RP 0");
                            }
                            // Map<String, dynamic> data = snapshot.data.docs;
                            var grandTotal = 0;
                            for(var dt in snapshot.data.docs) {
                              grandTotal += dt.data()['total'];
                            }
                            return Text(
                              'RP ${f.format(grandTotal)}',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        
                      ],
                    )
                  ],
                ),
                Container(
                  height: 220,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: 
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: firestore.collection('penyalurans')
                  //     .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                  //     .snapshots(),
                  //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Text('Something went wrong');
                  //     }
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Text("Loading");
                  //     }
                      
                  //     return ListView.builder(
                  //       physics: ClampingScrollPhysics(),
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: snapshot.data.docs.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         DocumentSnapshot document = snapshot.data.docs[index];
                  //         Map<String, dynamic> task = document.data();
                  //         print(task);
                  //         // if (!task.containsKey(task['penerima']['kelompok'])) {
                  //         //   print(task[task['penerima']['kelompok']] = 1);
                  //         // } else {
                  //         //   print(task[task['penerima']['kelompok']] += 1);
                  //         //   // map[element.data['name']] += 1;
                  //         // }
                  //         return StatCard(
                  //           title: task['penerima']['kelompok'],
                  //           achieved: 200,
                  //           total: 350,
                  //           color: Colors.orange,
                  //           image: Image.asset('assets/img/bolt.png', width: 20),
                  //         );
                  //       }
                  //     );

                  //   },
                  // ), 

                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _kelompok.length,
                    itemBuilder: (BuildContext context, int i) {
                      // var a = 0;
                      // if (_kelompok[i] == 'pondok jeruk kulon') {
                      //   countPenerimaPdkJrkKulon();
                      //   a = _totalPenerimaNonPdkJrkKulon;
                      // }
                      return StreamBuilder<QuerySnapshot>(
                        stream: firestore.collection('penyalurans')
                          .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                          .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // return Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: Container(
                            //     width: 20,
                            //     child: CircularProgressIndicator(),
                            //   ),
                            // );
                            return Text("Load.. ");
                          }
                          var no = 0;
                          for(var dt in snapshot.data.docs) {
                            if (dt.data()['penerima']['kelompok'] == _kelompok[i]) {
                              no++;
                            }
                          }
                          // countPenerimaKelompok(_kelompok[i]);
                          
                          // var _list = _totalPenerimaKelompok.values.toList();
                          // print(_list);
                          // print('$_kelompok[i] === ${_totalPenerimaKelompok[_kelompok[i]]}');
                          // return Text("");
                          
                          return StatCard(
                            title: _kelompok[i],
                            achieved: no,
                            total: 150,
                            color: Colors.orange,
                            image: Image.asset('assets/img/bolt.png', width: 20),
                          );
                        },
                      );
                    }
                  ),
                  
                  // ListView(
                  //   physics: ClampingScrollPhysics(),
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.horizontal,
                  //   children: <Widget>[
                  //     StreamBuilder<QuerySnapshot>(
                  //       stream: firestore.collection('penyalurans')
                  //         .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                  //         .snapshots(),
                  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //         if (snapshot.hasError) {
                  //           return Text('Something went wrong');
                  //         }
                  //         if (snapshot.connectionState == ConnectionState.waiting) {
                  //           return Text("Loading");
                  //         }
                  //         var no = 0;
                  //         for(var dt in snapshot.data.docs) {
                  //           if (dt.data()['penerima']['kelompok'] == 'poniyem') {
                  //             no++;
                  //           }
                  //         }
                  //         return StatCard(
                  //           title: 'poniyem',
                  //           achieved: no,
                  //           total: 100,
                  //           color: Colors.orange,
                  //           image: Image.asset('assets/img/bolt.png', width: 20),
                  //         );
                  //       },
                  //     ),
                  //     StreamBuilder<QuerySnapshot>(
                  //       stream: firestore.collection('penyalurans')
                  //         .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                  //         .snapshots(),
                  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //         if (snapshot.hasError) {
                  //           return Text('Something went wrong');
                  //         }
                  //         if (snapshot.connectionState == ConnectionState.waiting) {
                  //           return Text("Loading");
                  //         }
                  //         var no = 0;
                  //         for(var dt in snapshot.data.docs) {
                  //           if (dt.data()['penerima']['kelompok'] == 'non pkh') {
                  //             no++;
                  //           }
                  //         }
                  //         return StatCard(
                  //           title: 'non pkh',
                  //           achieved: no,
                  //           total: 100,
                  //           color: Colors.orange,
                  //           image: Image.asset('assets/img/bolt.png', width: 20),
                  //         );
                  //       },
                  //     ),
                  //     StreamBuilder<QuerySnapshot>(
                  //       stream: firestore.collection('penyalurans')
                  //         .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
                  //         .snapshots(),
                  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //         if (snapshot.hasError) {
                  //           return Text('Something went wrong');
                  //         }
                  //         if (snapshot.connectionState == ConnectionState.waiting) {
                  //           return Text("Loading");
                  //         }
                  //         var no = 0;
                  //         for(var dt in snapshot.data.docs) {
                  //           if (dt.data()['penerima']['kelompok'] == 'sulastri') {
                  //             no++;
                  //           }
                  //         }
                  //         return StatCard(
                  //           title: 'sulastri',
                  //           achieved: no,
                  //           total: no * 200000,
                  //           color: Colors.orange,
                  //           image: Image.asset('assets/img/bolt.png', width: 20),
                  //         );
                  //       },
                  //     ),
                  //     // StatCard(
                  //     //   title: 'non pkh',
                  //     //   achieved: 350,
                  //     //   total: 300,
                  //     //   // color: Theme.of(context).primaryColor,
                  //     //   color: Colors.orange,
                  //     //   // image: Image.asset('assets/img/fish.png', width: 20),
                  //     //   image: Image.asset('assets/img/bolt.png', width: 20),
                  //     // ),
                  //     // StatCard(
                  //     //   title: 'sulastri',
                  //     //   achieved: 100,
                  //     //   total: 200,
                  //     //   // color: Colors.green,
                  //     //   color: Colors.orange,
                  //     //   // image: Image.asset('assets/img/sausage.png', width: 20),
                  //     //   image: Image.asset('assets/img/bolt.png', width: 20),
                  //     // ),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.credit_card),
        onPressed: () {
          navigationManager(context, Penyaluran(), isPushReplaced: false);
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final int total;
  final int achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeKelompok(
            namaKelompok: title,
            totalPenerima: total,
            totalTransaksi: achieved,
          );
        }));
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Colors.blue.withOpacity(0.1),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            ),
            // achieved < total
            //     ? Image.asset(
            //         'assets/img/down_orange.png',
            //         width: 20,
            //       )
            //     : Image.asset(
            //         'assets/img/up_red.png',
            //         width: 20,
            //       ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 8.0,
              percent: achieved / (total < achieved ? achieved : total),
              circularStrokeCap: CircularStrokeCap.round,
              center: image,
              progressColor: color,
              backgroundColor: Theme.of(context).accentColor.withAlpha(30),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: achieved.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                TextSpan(
                  text: ' / $total',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  

}
