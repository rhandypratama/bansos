import 'package:cloud_firestore/cloud_firestore.dart';

class PenerimaModel {
  String bank;
  String idKartu;
  String kelompok;
  String nama;
  
  PenerimaModel({
    this.bank,
    this.idKartu,
    this.kelompok,
    this.nama,
  });

  PenerimaModel.fromSnapshot(DocumentSnapshot snapshot) :
    bank = snapshot.data()['bank'],
    idKartu = snapshot.data()['id_kartu'],
    kelompok = snapshot.data()['kelompok'],
    nama = snapshot.data()['nama'];
    
  Map<String, dynamic> toJson() => {
    "bank": bank == null ? null : bank,
    "idKartu": idKartu == null ? null : idKartu,
    "kelompok": kelompok == null ? null : kelompok,
    "nama": nama == null ? null : nama,
  };
}