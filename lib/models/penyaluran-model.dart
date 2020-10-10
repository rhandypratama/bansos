import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:travel_budget/credentials.dart';

// class Penyaluran {
//   String jenis;
//   DateTime startDate;
//   DateTime endDate;
//   double budget;
//   Map budgetTypes;
//   String travelType;
//   String photoReference;
//   String notes;
//   String documentId;
//   double saved;

//   Penyaluran(
//       this.title,
//       this.startDate,
//       this.endDate,
//       this.budget,
//       this.budgetTypes,
//       this.travelType
//       );

//   // formatting for upload to Firbase when creating the trip
//   Map<String, dynamic> toJson() => {
//     'title': title,
//     'startDate': startDate,
//     'endDate': endDate,
//     'budget': budget,
//     'budgetTypes': budgetTypes,
//     'travelType': travelType,
//     'photoReference': photoReference,
//   };

//   // creating a Trip object from a firebase snapshot
//   Penyaluran.fromSnapshot(DocumentSnapshot snapshot) :
//       title = snapshot['title'],
//       startDate = snapshot['startDate'].toDate(),
//       endDate = snapshot['endDate'].toDate(),
//       budget = snapshot['budget'],
//       budgetTypes = snapshot['budgetTypes'],
//       travelType = snapshot['travelType'],
//       photoReference = snapshot['photoReference'],
//       notes = snapshot['notes'],
//       documentId = snapshot.documentID,
//       saved = snapshot['saved'];

//   Map<String, Icon> types() => {
//     "car": Icon(Icons.directions_car, size: 50),
//     "bus": Icon(Icons.directions_bus, size: 50),
//     "train": Icon(Icons.train, size: 50),
//     "plane": Icon(Icons.airplanemode_active, size: 50),
//     "ship": Icon(Icons.directions_boat, size: 50),
//     "other": Icon(Icons.directions, size: 50),
//   };

  // return the google places image
  // Image getLocationImage() {
  //   final baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
  //   final maxWidth = "1000";
  //   final url = "$baseUrl?maxwidth=$maxWidth&photoreference=$photoReference&key=$PLACES_API_KEY";
  //   return Image.network(url, fit: BoxFit.cover);
  // }

  // int getTotalTripDays() {
  //   return endDate.difference(startDate).inDays;
  // }

  // int getDaysUntilTrip() {
  //   int diff = startDate.difference(DateTime.now()).inDays;
  //   if (diff < 0) {
  //     diff = 0;
  //   }
  //   return diff;
  // }
// }

class PenyaluranModel {
  String jenis;
  int total;
  String tanggalPengambilan;
  Penerima penerima;
  
  PenyaluranModel({
    this.jenis,
    this.total,
    this.tanggalPengambilan,
    this.penerima,
  });

  PenyaluranModel.fromSnapshot(DocumentSnapshot snapshot) :
    jenis = snapshot.data()['jenis'],
    total = snapshot.data()['total'],
    tanggalPengambilan = snapshot.data()['tanggal_pengambilan'].toDate(),
    penerima = snapshot.data()['penerima'];
      
  // factory PenyaluranModel.fromJson(Map<String, dynamic> json) => PenyaluranModel(
  //   jenis: json["jenis"] == null ? null : json["jenis"],
  //   total: json["total"] == null ? null : json["total"],
  //   tanggalPengambilan: json["tanggal_pengambilan"] == null ? null : json["tanggal_pengambilan"],
  //   penerima: json["penerima"] == null ? null : Penerima.fromJson(json["penerima"]),
  // );

  Map<String, dynamic> toJson() => {
    "jenis": jenis == null ? null : jenis,
    "total": total == null ? null : total,
    "tanggal_pengambilan": tanggalPengambilan == null ? null : tanggalPengambilan,
    "penerima": penerima == null ? null : penerima.toJson(),
  };
}

class Penerima {
  Penerima({
    this.nama,
    this.bank,
    this.idKartu,
    this.kelompok,
  });

  String nama;
  String bank;
  String idKartu;
  String kelompok;

  factory Penerima.fromJson(Map<String, dynamic> json) => Penerima(
    nama: json["nama"] == null ? null : json["nama"],
    bank: json["bank"] == null ? null : json["bank"],
    idKartu: json["id_kartu"] == null ? null : json["id_kartu"],
    kelompok: json["kelompok"] == null ? null : json["kelompok"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama == null ? null : nama,
    "bank": bank == null ? null : bank,
    "id_kartu": idKartu == null ? null : idKartu,
    "kelompok": kelompok == null ? null : kelompok,
  };
}
