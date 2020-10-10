import 'package:bansos/utils/widget-model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListProses extends StatefulWidget {
  final String kelompok;

  const ListProses({Key key, this.kelompok}) : super(key: key);

  @override
  _ListProsesState createState() => _ListProsesState();
}

class _ListProsesState extends State<ListProses> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var f = NumberFormat('#,##0', 'id_ID');

  void showSnackBarMessage(String message) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  List _dtProses = [];
  getProses() async {
    var dt = await FirebaseFirestore.instance
      .collection('penyalurans')
      .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
      .get();
    setState(() {
      _dtProses = dt.docs;
      // _dtProses = dt.docs.map((e) => e.data()['nama']).toList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProses();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

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
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
        itemCount: _dtProses.length,
        itemBuilder: (BuildContext context, int index) {
          DocumentSnapshot doc = _dtProses[index];
          // print(doc.data()['penerima']['kelompok']);

          if (doc.data()['penerima']['kelompok'] == widget.kelompok) {
            var dateNew = DateTime.parse(doc.data()['tanggal_pengambilan'].toDate().toString());
            final DateFormat formatter = DateFormat('dd/MM/yyyy H:mm');
            final formatted = formatter.format(dateNew);

            return Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: ListTile(
                  title: dynamicText("${doc.data()['penerima']['nama'].toString().toUpperCase()}", fontWeight: FontWeight.w600, fontSize: 18),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            // Icon(Icons.category, size: 16,),
                            // SizedBox(width: 4),
                            doc.data()['jenis'] == 'sembako' 
                              ? dynamicText("${doc.data()['jenis'].toString().toUpperCase()}", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange[600])
                              : dynamicText("${doc.data()['jenis'].toString().toUpperCase()} RP ${f.format(doc.data()['total'])}", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                          ]
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.credit_card, size: 16,),
                            SizedBox(width: 4),
                            dynamicText("${doc.data()['penerima']['id_kartu']}" ?? "", fontSize: 12, fontWeight: FontWeight.normal),
                            SizedBox(width: 10),
                            Icon(Icons.calendar_today, size: 16,),
                            SizedBox(width: 4),
                            dynamicText("$formatted WIB", fontSize: 12),
                          ]
                        ),
                        
                      ],
                    ),
                  ),
                  // isThreeLine: true,
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return List<PopupMenuEntry<String>>()
                        ..add(PopupMenuItem<String>(
                          value: 'batal',
                          child: Text('Batalkan Transaksi'),
                        ));
                        
                    },
                    onSelected: (String value) async {
                      if (value == 'batal') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Apakah yakin akan membatalkan transaksi ini ?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('TIDAK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('PROSES'),
                                  onPressed: () {
                                    doc.reference.delete().then((value) {
                                      Navigator.pop(context);
                                      showSnackBarMessage("Transasi berhasil dibatalkan");
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ),
            );
          }

          return Container();
          
        },
      ),
    );
  }
}