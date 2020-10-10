import 'package:bansos/utils/widget-model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListBelumProses extends StatefulWidget {
  final String kelompok;

  const ListBelumProses({Key key, this.kelompok}) : super(key: key);

  @override
  _ListBelumProsesState createState() => _ListBelumProsesState();
}

class _ListBelumProsesState extends State<ListBelumProses> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var f = NumberFormat('#,##0', 'id_ID');
  String kel;
  List pel = [];
  // List _belum = [];
  int countBelumProses = 0;

  void showSnackBarMessage(String message) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // getProses();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;
    setState(() => kel = widget.kelompok);

    FirebaseFirestore.instance
      .collection('penyalurans')
      .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
      .get()
      .then((QuerySnapshot documentSnapshot) {
        if (documentSnapshot.docs.length > 0) {
          pel = [];
          documentSnapshot.docs.forEach((element) {
            if (element.data()['penerima']['kelompok'] == widget.kelompok) pel.add(element.data()['penerima']['nama']);
          });
          // setState(() {
          //   _belum = pel;
          // });
        } else {
          print('Document does not exist on the database');
        }
      });

    return Scaffold(
      key: scaffoldState,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildWidgetListTodo(widthScreen, heightScreen, context),
          ],
        ),
      ),
      
    );
  }

  Container _buildWidgetListTodo(double widthScreen, double heightScreen, BuildContext context) {
    return Container(
      width: widthScreen,
      height: heightScreen,
      child: 

      // Container()
      
      StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('penerimas')
          .where('kelompok', isEqualTo: widget.kelompok)
          .orderBy('nama')
          .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // return Card(
          //   elevation: 1,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 8, bottom: 8),
          //     child: ListTile(
          //       title: Row(
          //         children: [
          //           Icon(Icons.person_outline, size: 24,),
          //           SizedBox(width: 6,),
          //           dynamicText("total penerima = ${snapshot.data.docs.length}".toUpperCase(), fontWeight: FontWeight.w600, fontSize: 18)
          //         ]),
          //       subtitle: Padding(
          //         padding: const EdgeInsets.only(top: 10),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
                      
          //             SizedBox(height: 2),
          //             Row(
          //               children: [
          //                 Icon(Icons.credit_card, size: 16,),
          //                 SizedBox(width: 4),
          //                 // dynamicText("${doc.data()['penerima']['id_kartu']}" ?? "", fontSize: 12, fontWeight: FontWeight.normal),
          //                 SizedBox(width: 10),
          //                 Icon(Icons.calendar_today, size: 16,),
          //                 SizedBox(width: 4),
          //                 // dynamicText("$formatted WIB", fontSize: 12),
          //               ]
          //             ),
                      
          //           ],
          //         ),
          //       ),
          //       // isThreeLine: true,
                
          //     ),
          //   ),
          // );
          
          return Padding(
            // color: Colors.white,
            padding: EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dynamicText('Total penerima = ${snapshot.data.docs.length}'.toUpperCase(), fontWeight: FontWeight.bold, fontSize: 16),
                    SizedBox(height: 10),
                    dynamicText('Total yang sudah diproses = ${pel.length}'.toUpperCase(), fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                    SizedBox(height: 10),
                    dynamicText('Total yang belum mengambil = ${snapshot.data.docs.length - pel.length}'.toUpperCase(), fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
                  ],
                ),
              ),
            ),
          );

          // return ListView.builder(
          //   padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
          //   itemCount: snapshot.data.docs.length,
          //   itemBuilder: (BuildContext context, int ind) {
          //     DocumentSnapshot doc = snapshot.data.docs[ind];
          //     Map<String, dynamic> task = doc.data();
          //     print('total penyaluran ${pel.length}');
          //     // print(task['nama']);
          //     print('total penerima ${snapshot.data.docs.length}');
          //     // var numbers = task['nama'];
          //     // print(numbers.contains(pel)); // => true
          //     // countBelumProses = 0;
          //     if (pel.length > 0) {
          //       for (var u in pel) {
          //         print('penyaluran $u');
          //         print(task['nama']);
          //         // print(numbers.contains(u));
          //         if (u != task['nama']) {
          //         //   return Container();
          //         // }else {
          //           // print(u);
          //           // countBelumProses++;
          //           return Card(
          //             elevation: 1,
          //             child: Padding(
          //               padding: const EdgeInsets.only(top: 0, bottom: 0),
          //               child: ListTile(
          //                 title: dynamicText("${task['nama'].toString().toUpperCase()}", fontWeight: FontWeight.w600, fontSize: 18),
          //                 subtitle: Padding(
          //                   padding: const EdgeInsets.only(top: 4),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: <Widget>[
          //                       Row(
          //                         children: [
          //                           Icon(Icons.credit_card, size: 16,),
          //                           SizedBox(width: 4),
          //                           dynamicText("${task['id_kartu']}", fontSize: 12, fontWeight: FontWeight.normal),
          //                         ]
          //                       ),
                                
          //                     ],
          //                   ),
          //                 ),
                          
          //               ),
          //             ),
          //           );
          //         } else {
          //           return Container();
          //         }
          //       }
          //     } else {
          //       return Card(
          //         elevation: 1,
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 0, bottom: 0),
          //           child: ListTile(
          //             title: dynamicText("${task['nama'].toString().toUpperCase()}", fontWeight: FontWeight.w600, fontSize: 18),
          //             subtitle: Padding(
          //               padding: const EdgeInsets.only(top: 4),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: <Widget>[
          //                   Row(
          //                     children: [
          //                       Icon(Icons.credit_card, size: 16,),
          //                       SizedBox(width: 4),
          //                       dynamicText("${task['id_kartu']}", fontSize: 12, fontWeight: FontWeight.normal),
          //                     ]
          //                   ),
                            
          //                 ],
          //               ),
          //             ),
                      
          //           ),
          //         ),
          //       );
          //     }

          //     return Container();
              
          //   },
          // );
        },
      ),
      
      
    );
  }
}