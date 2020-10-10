import 'dart:io';
import 'package:bansos/pages/penyaluran.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPenerimaScreen extends StatefulWidget {
  final bool isEdit;
  final String documentId;
  final String kelompok;
  final String nama;
  final String idKartu;
  final String bank;

  AddPenerimaScreen({
    @required this.isEdit,
    this.documentId = '',
    this.nama = '',
    this.idKartu = '',
    this.kelompok = '',
    this.bank = 'bni',
  });

  @override
  _AddPenerimaScreenState createState() => _AddPenerimaScreenState();
}

class _AddPenerimaScreenState extends State<AddPenerimaScreen> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController controllerNama = TextEditingController();
  final TextEditingController controllerIdKartu = TextEditingController();
  
  double widthScreen;
  double heightScreen;
  DateTime date = DateTime.now().add(Duration(days: 1));
  bool isLoading = false;
  String currentCat = "";
  String initCat = "";
  // String currentUnit = "";
  // String initUnit = "";
  File imageFile;
  String fileName;
  String imgStr = "";

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

  showMessage(String msg) {
    showToast(msg,
      context: context,
      axis: Axis.horizontal,
      alignment: Alignment.center,
      position: StyledToastPosition.center
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // resultsLoaded = getUsersPastTripsStreamSnapshots();
    getKelompok();
  }

  @override
  void initState() {
    if (widget.isEdit) {
      // date = DateFormat('dd MMMM yyyy').parse(widget.date);
      controllerNama.text = widget.nama;
      controllerIdKartu.text = widget.idKartu;
      initCat = widget.kelompok;
      // initUnit = widget.bank;
      currentCat = widget.kelompok;
    }
    super.initState();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('penerimas');
  Future<void> addUser() {
    return users
      .add({
        'bank': 'bni',
        'id_kartu': controllerIdKartu.text,
        'kelompok': currentCat,
        'nama': controllerNama.text,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(docId) {
    return users
      .doc(docId)
      .update({'company': 'Stokes and Sons'})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;
    heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            // Navigator.pop(context);
            // Navigator.pop(context);
            navigationManager(context, Penyaluran(), isPushReplaced: true);
          },
        ),
        title: dynamicText(
          widget.isEdit ? "Edit data penerima" : "Tambah data penerima baru",
          fontFamily: "Bebas",
          fontSize: 20
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: widthScreen,
              height: heightScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // _buildWidgetFormPrimary(context),
                  _buildWidgetCategory(),
                  _buildWidgetFormSecondary(),
                  // _buildWidgetUnit(),
                  isLoading
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : _buildWidgetButtonCreateTask(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget _buildWidgetFormPrimary(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //           },
  //           child: Icon(
  //             Icons.arrow_back,
  //             color: Colors.grey[800],
  //           ),
  //         ),
  //         SizedBox(height: 16.0),
  //         Text(
  //           widget.isEdit ? 'Edit Barang' : 'Buat Barang Baru',
  //           style: TextStyle(fontSize: 24),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildWidgetFormSecondary() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controllerNama,
              decoration: InputDecoration(
                labelText: 'Nama Penerima',
                labelStyle: TextStyle(fontSize: 16),
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: controllerIdKartu,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID Kartu',
                labelStyle: TextStyle(fontSize: 16),
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            // SizedBox(height: 16.0),
            
            // TextField(
            //   keyboardType: TextInputType.text,
            //   controller: controllerPrice,
            //   decoration: InputDecoration(
            //     labelText: 'Bank',
            //     labelStyle: TextStyle(fontSize: 16),
            //   ),
            //   style: TextStyle(fontSize: 18.0),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          DropdownButtonFormField(
            hint: dynamicText("PILIH KELOMPOK"),
            value: (widget.isEdit) ? initCat : null,
            items: _kelompok.map((dynamic x) {
              return DropdownMenuItem<String>(
                value: x,
                child: Text("${x.toString().toUpperCase()}")
              );
            }).toList(), 
            onChanged: (newCat) {
              setState(() {
                currentCat = newCat;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonCreateTask(context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: dynamicText(widget.isEdit ? 'UPDATE' : 'SIMPAN',
          fontSize: 16,
          color: Colors.white
        )),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () async {
          // uploadImage();
          String nama = controllerNama.text;
          String idKartu = controllerIdKartu.text;
          if (currentCat.isEmpty) {
            showMessage('Pilih kelompok yang tersedia');
            return;
          } else if (nama.isEmpty) {
            showMessage('Nama penerima harus diisi');
            return;
          } 
          // else if (idKartu.isEmpty) {
          //   showMessage('ID Kartu harus diisi');
          //   return;
          // }
          setState(() => isLoading = true);
          if (widget.isEdit) {
            // await updateUser(widget.documentId);
            // navigationManager(context, Penyaluran(), isPushReplaced: true);

            DocumentReference documentTask = firestore.doc('penerimas/${widget.documentId}');
            firestore.runTransaction((transaction) async {
              DocumentSnapshot dt = await transaction.get(documentTask);
              if (dt.exists) {
                transaction.update(
                  documentTask,
                  <String, dynamic>{
                    'id_kartu': idKartu,
                    'kelompok': currentCat,
                    'nama': nama,
                  },
                );
                // Navigator.pop(context, true);
                // Navigator.pop(context, true);
                navigationManager(context, Penyaluran(), isPushReplaced: true);
              }
            });
          } else {
            CollectionReference product = firestore.collection('penerimas');
            DocumentReference result = await product.add(<String, dynamic>{
              'bank': 'bni',
              'id_kartu': idKartu,
              'kelompok': currentCat,
              'nama': nama,
            });
            // await addUser();
            if (result.id != null) {
              // Navigator.pop(context);
              // Navigator.pop(context, true);
              navigationManager(context, Penyaluran(), isPushReplaced: true);
            }
          }
        },
      ),
    );
  }

}