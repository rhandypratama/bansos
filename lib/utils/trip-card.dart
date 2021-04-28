import 'package:bansos/models/penerima-model.dart';
import 'package:bansos/pages/add-penerima.dart';
// import 'package:bansos/pages/penyaluran.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:intl/intl.dart';

Widget buildTripCard(BuildContext context, DocumentSnapshot document, TextEditingController _uangController) {
  final penerima = PenerimaModel.fromSnapshot(document);
  // final tripType = trip.types();
  // print(penerima);

  showMessage(String msg) {
    showToast(msg,
      context: context,
      axis: Axis.horizontal,
      alignment: Alignment.center,
      position: StyledToastPosition.center
    );
  }

  return Container(
    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.red[900],
      elevation: 8,
      child: InkWell(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        dynamicText(
                          "Nama Penerima",
                          fontSize: 11,
                          color: Colors.white
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 6, right: 0),
                    child: dynamicText(
                      "${penerima.nama.toUpperCase()}" ?? "",
                      fontSize: 24,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                dynamicText(
                                  "Nomor Kartu",
                                  fontSize: 11.0,
                                  color: Colors.white
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: [
                                    // Icon(Icons.credit_card, size: 16,),
                                    // SizedBox(width: 4),
                                    dynamicText(
                                      "XXXX XXXX ${penerima.idKartu.substring(0,4)} " ?? "", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.bold, 
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                    dynamicText(
                                      // "${penerima.idKartu}" ?? "", 
                                      "${penerima.idKartu.substring(4,8)}" ?? "", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.bold, 
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                dynamicText(
                                  "Kelompok",
                                  fontSize: 11.0,
                                  color: Colors.white
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                dynamicText(
                                  "${penerima.kelompok.toUpperCase()}" ?? "",
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          OutlineButton(
                            borderSide: BorderSide(
                              color: Colors.yellow[200],
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              child: dynamicText(
                                "SEMBAKO", 
                                fontSize: 12, 
                                color: Colors.yellow
                              )
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(40.0),
                                        topRight: const Radius.circular(40.0))),
                                    child: Padding(
                                    // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                                    padding: EdgeInsets.only(
                                        top: 6,
                                        left: 18,
                                        right: 18,
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top : 30, bottom: 40),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            dynamicText("Apakah yakin ${penerima.nama.toUpperCase()} - ${penerima.idKartu} akan menerima sembako?",
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.left
                                            ),
                                            SizedBox(height: 30.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                OutlineButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                                  borderSide: BorderSide(
                                                    color: Colors.red[200],
                                                    width: 1,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0)
                                                  )
                                                ),
                                                SizedBox(width: 10),
                                                OutlineButton(
                                                  onPressed: () async {
                                                    CollectionReference penyaluran = FirebaseFirestore.instance.collection('penyalurans');
                                                    DocumentReference result = await penyaluran.add(<String, dynamic>{
                                                      'jenis': 'sembako',
                                                      'penerima': {
                                                        'bank': penerima.bank,
                                                        'id_kartu': penerima.idKartu,
                                                        'kelompok': penerima.kelompok,
                                                        'nama': penerima.nama
                                                      },
                                                      'tanggal_pengambilan': DateTime.now(),
                                                      'total': 200000,
                                                    });
                                                    if (result.id != null) {
                                                      Navigator.pop(context);
                                                      showToast('Data berhasil disimpan',
                                                        context: context,
                                                        axis: Axis.horizontal,
                                                        alignment: Alignment.center,
                                                        position: StyledToastPosition.center);
                                                      // _showSnackBarMessage("Data berhasil disimpan");
                                                    } else {
                                                      CircularProgressIndicator();
                                                    }
                                                  },
                                                  child: dynamicText("PROSES", fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0)
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.green[300],
                                                    width: 1,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                  ));
                                });
                            },
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(30.0)
                            // )
                          ),
                          SizedBox(width: 10),
                          OutlineButton(
                            padding: EdgeInsets.all(10),
                            borderSide: BorderSide(
                              color: Colors.yellow[200],
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            child: dynamicText("UANG TUNAI", fontSize: 12, color: Colors.yellow),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _uangController.text = "";
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(40.0),
                                        topRight: const Radius.circular(40.0)
                                      )
                                    ),
                                    child: Padding(
                                    // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                                      padding: EdgeInsets.only(top: 0, left: 18, right: 18, bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top : 0, bottom: 40),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              controller: _uangController,
                                              autocorrect: false,
                                              onFieldSubmitted: (term) {
                                                // _nominalFocus.unfocus();
                                              },
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: "Nominal",
                                                labelStyle: TextStyle(fontSize: 20.0),
                                                contentPadding: EdgeInsets.symmetric(vertical: 20),
                                                helperText: "Contoh : 450000 (tanpa titik / koma / spasi)"
                                              ),
                                              style: TextStyle(fontSize: 28),
                                              // inputFormatters:[  MoneyInputFormatter(
                                              //       // trailingSymbol: MoneyInputFormatter.EURO_SIGN,
                                              //       // useSymbolPadding: true,
                                              //       // mantissaLength: 0,
                                              //       mantissaLength: 0,
                                              //       thousandSeparator: ThousandSeparator.Comma // the length of the fractional side
                                              //   )]
                                            ),
                                        SizedBox(height: 50),
                                            dynamicText("Apakah yakin ${penerima.nama.toUpperCase()} - ${penerima.idKartu} akan menerima uang tunai?",
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.left
                                            ),
                                            SizedBox(height: 50.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                OutlineButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                                  borderSide: BorderSide(
                                                    color: Colors.red[200],
                                                    width: 1,
                                                  ),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                                                ),
                                                SizedBox(width: 10),
                                                OutlineButton(
                                                  onPressed: () async {
                                                    if (_uangController.text == "") {
                                                      showToast('Nominal wajib diisi',
                                                        context: context,
                                                        axis: Axis.horizontal,
                                                        alignment: Alignment.center,
                                                        position: StyledToastPosition.center);
                                                    } else {
                                                      print(_uangController.text);
                                                      // CollectionReference penyaluran = FirebaseFirestore.instance.collection('penyalurans');
                                                      // DocumentReference result = await penyaluran.add(<String, dynamic>{
                                                      //   'jenis': 'uang tunai',
                                                      //   'penerima': {
                                                      //     'bank': penerima.bank,
                                                      //     'id_kartu': penerima.idKartu,
                                                      //     'kelompok': penerima.kelompok,
                                                      //     'nama': penerima.nama
                                                      //   },
                                                      //   'tanggal_pengambilan': DateTime.now(),
                                                      //   'total': int.parse(_uangController.text),
                                                      // });
                                                      // if (result.id != null) {
                                                      //   Navigator.pop(context);
                                                      //   showToast('Data berhasil disimpan',
                                                      //     context: context,
                                                      //     axis: Axis.horizontal,
                                                      //     alignment: Alignment.center,
                                                      //     position: StyledToastPosition.center);
                                                      //   // _showSnackBarMessage("Data berhasil disimpan");
                                                      // }
                                                    }
                                                  },
                                                  child: dynamicText("PROSES", fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                                  borderSide: BorderSide(
                                                    color: Colors.green[300],
                                                    width: 1,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                  ));
                                }
                              );
                              
                            },
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                          ),
                          
                        ],
                      ),

                      PopupMenuButton(
                        // icon: Icon(Icons.mode_edit, color: Colors.yellow),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(30.0),
                            //   border: Border.all(color: Colors.yellow)
                            // ),
                            // child: dynamicText("...", fontSize: 18, color: Colors.yellow),
                            child: Icon(Icons.menu, color: Colors.yellow),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                        itemBuilder: (BuildContext context) {
                          return List<PopupMenuEntry<String>>()
                            ..add(PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ))
                            ..add(PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Hapus'),
                            ));
                        },
                        onSelected: (String value) async {
                          if (value == 'edit') {
                            FocusScope.of(context).requestFocus(FocusNode());
                            bool result = await Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return AddPenerimaScreen(
                                  isEdit: true,
                                  documentId: document.id,
                                  nama: penerima.nama,
                                  kelompok: penerima.kelompok,
                                  idKartu: penerima.idKartu,
                                  bank: penerima.bank,
                                );
                              }),
                            );
                            if (result != null && result) {
                              showMessage('Data penerima berhasil diupdate');
                              // setState(() {});
                            }
                            // navigationManager(context, Penyaluran(), isPushReplaced: false);
                          } else if (value == 'delete') {
                            FocusScope.of(context).requestFocus(FocusNode());
                            showModalBottomSheet(
                              isScrollControlled: false,
                              context: context,
                              builder: (builder) {
                                return Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(40.0),
                                      topRight: const Radius.circular(40.0))),
                                  child: Padding(
                                  // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                                  padding: EdgeInsets.only(
                                      top: 6,
                                      left: 18,
                                      right: 18,
                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top : 30, bottom: 40),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          dynamicText("Apakah yakin akan menghapus data penerima ${penerima.nama.toUpperCase()} - ${penerima.idKartu}?",
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.left
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              OutlineButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                                borderSide: BorderSide(
                                                  color: Colors.red[200],
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                                              ),
                                              SizedBox(width: 10),
                                              OutlineButton(
                                                onPressed: () async {
                                                  await document.reference.delete();
                                                  Navigator.pop(context);
                                                  showMessage('Data penerima berhasil dihapus');
                                                },
                                                child: dynamicText("HAPUS", fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                                borderSide: BorderSide(
                                                  color: Colors.green[300],
                                                  width: 1,
                                                ),
                                              ),
                                            ],
                                          )
                                        ]
                                      ),
                                    ),
                                  ),
                                ));
                            });
                          }
                        },
                      )
                    ],
                  )
                  
                ],
              ),
            ),

            Positioned(
              top: -30,
              right: -30,
              child: Icon(Icons.motion_photos_pause, color: Colors.white12, size: 140),
            )

          ]
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => DetailTripView(trip: trip)),
          // );
        },
      ),
    ),
  );

}

Widget backgroundCard(BuildContext context) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -124,
        right: -128,
        child: Container(
          width: 256.0,
          height: 256.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9000),
            // color: appColor.colorTertiary,
            color: Colors.yellow[700],
          ),
        ),
      ),
      Positioned(
        top: -164,
        right: -8.0,
        child: Container(
          width: 256.0,
          height: 256.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9000),
            backgroundBlendMode: BlendMode.hardLight,
            color: Colors.yellowAccent.withOpacity(0.8),
          ),
        ),
      )
    ],
  );
}