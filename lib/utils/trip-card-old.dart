import 'package:bansos/models/penerima-model.dart';
import 'package:bansos/pages/add-penerima.dart';
// import 'package:bansos/pages/penyaluran.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  return new Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: Card(
      color: Colors.red[100],
      elevation: 8,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 140,
                    padding: const EdgeInsets.only(top: 0, bottom: 0.0, right: 0),
                    child: Row(children: <Widget>[
                      dynamicText(
                        "${penerima.nama.toUpperCase()}" ?? "",
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 0),
                    child: Row(
                      children: <Widget>[
                        dynamicText(
                          "${penerima.kelompok.toUpperCase()}" ?? "",
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600]
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.credit_card, size: 16,),
                            SizedBox(width: 4),
                            dynamicText("${penerima.idKartu}" ?? "", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
                          ]
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
              Row(
                children: [
                  OutlineButton(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: dynamicText("SEMBAKO", fontSize: 12, color: Colors.orange[700])
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
                                padding: const EdgeInsets.only(top : 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    dynamicText("Apakah yakin ${penerima.nama.toUpperCase()} - ${penerima.idKartu} akan menerima sembako?",
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.left),
                                    SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlineButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)
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
                                            borderRadius: BorderRadius.circular(30.0)
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                  SizedBox(width: 10),
                  OutlineButton(
                    padding: EdgeInsets.all(0),
                    child: dynamicText("UANG TUNAI", fontSize: 12, color: Colors.red),
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
                                topRight: const Radius.circular(40.0)
                              )
                            ),
                            child: Padding(
                            // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                              padding: EdgeInsets.only(top: 0, left: 18, right: 18, bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top : 0, bottom: 20),
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
                                    ),
                                SizedBox(height: 50),
                                    dynamicText("Apakah yakin ${penerima.nama.toUpperCase()} - ${penerima.idKartu} akan menerima uang tunai?",
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.left),
                                    SizedBox(height: 50.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlineButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)
                                          )
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
                                              CollectionReference penyaluran = FirebaseFirestore.instance.collection('penyalurans');
                                              DocumentReference result = await penyaluran.add(<String, dynamic>{
                                                'jenis': 'uang tunai',
                                                'penerima': {
                                                  'bank': penerima.bank,
                                                  'id_kartu': penerima.idKartu,
                                                  'kelompok': penerima.kelompok,
                                                  'nama': penerima.nama
                                                },
                                                'tanggal_pengambilan': DateTime.now(),
                                                'total': int.parse(_uangController.text),
                                              });
                                              if (result.id != null) {
                                                Navigator.pop(context);
                                                showToast('Data berhasil disimpan',
                                                  context: context,
                                                  axis: Axis.horizontal,
                                                  alignment: Alignment.center,
                                                  position: StyledToastPosition.center);
                                                // _showSnackBarMessage("Data berhasil disimpan");
                                              }
                                            }
                                          },
                                          child: dynamicText("PROSES", fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  ),
                  PopupMenuButton(
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
                                  padding: const EdgeInsets.only(top : 20, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      dynamicText("Apakah yakin akan menghapus ${penerima.nama.toUpperCase()} - ${penerima.idKartu}?",
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.left),
                                      SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          OutlineButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: dynamicText("TIDAK", fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                            color: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                            )
                                          ),
                                          SizedBox(width: 10),
                                          OutlineButton(
                                            onPressed: () async {
                                              await document.reference.delete();
                                              Navigator.pop(context);
                                              showMessage('Data penerima berhasil dihapus');
                                            },
                                            child: dynamicText("HAPUS", fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
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