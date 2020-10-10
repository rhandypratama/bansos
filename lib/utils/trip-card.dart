import 'package:bansos/models/penerima-model.dart';
import 'package:bansos/pages/add-penerima.dart';
import 'package:bansos/pages/penyaluran.dart';
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
    child: Card(
      elevation: 1,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 0),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: Text('Are You Sure'),
                            content: Text('Apakah yakin ${penerima.nama.toUpperCase()} akan menerima sembako?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('TIDAK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('PROSES'),
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
                              ),
                            ],
                          );
                        },
                      );
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: Text('Are You Sure'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                SizedBox(height: 20),
                                Text('Apakah yakin ${penerima.nama.toUpperCase()} akan menerima uang tunai?'),
                                
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('TIDAK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('PROSES'),
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
                              ),
                            ],
                          );
                        },
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // title: Text('Are You Sure'),
                              content: Text('Apakah yakin akan menghapus ${penerima.nama.toUpperCase()}?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('TIDAK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('HAPUS'),
                                  onPressed: () async {
                                    await document.reference.delete();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    navigationManager(context, Penyaluran(), isPushReplaced: false);
                                    showMessage('Data penerima berhasil dihapus');
                                  },
                                ),
                              ],
                            );
                          },
                        );
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