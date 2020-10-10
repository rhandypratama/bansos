// import 'dart:async';
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:toko_romi/blocs/auth-service.dart';
// import 'package:toko_romi/screens/home/homescreen.dart';
// import 'widget-model.dart';
// // import 'package:uuid/uuid.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthService _auth = AuthService();
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   bool isSignIn = false;
//   bool cek;

//   Future<void> isGoogleSignIn() async {
//     cek = await googleSignIn.isSignedIn();
//     // if (mounted) {
//     setState(() {
//       isSignIn = cek;
//     });
//     // }
//     print('CEK LOGIN :: $cek');
//     if (cek) {
//       Timer(Duration(seconds: 4), () {
//         navigationManager(context, HomeScreen(), isPushReplaced: true);
//       });
//     }
//   }

//   Future<String> getSettings() async {
//     DocumentSnapshot querySnapshot = await Firestore.instance
//         .collection('settings')
//         .document('v95naiHwl0OSEdNwSYOk')
//         .get();
//     // if (querySnapshot.exists &&
//     //     querySnapshot.data.containsKey('favorites') &&
//     //     querySnapshot.data['favorites'] is List) {
//     //   // Create a new List<String> from List<dynamic>
//     //   return List<String>.from(querySnapshot.data['favorites']);
//     // }
//     if (querySnapshot.exists) {
//       await savePreferences('username',
//           stringValue: querySnapshot.data['username']);
//       await savePreferences('password',
//           stringValue: querySnapshot.data['password']);
//       await savePreferences('admin-utama',
//           stringValue: querySnapshot.data['adminUtama']);
//       await savePreferences('admin-test',
//           stringValue: querySnapshot.data['adminTest']);
//       await savePreferences('admin-makanan',
//           stringValue: querySnapshot.data['adminMakanan']);
//       await savePreferences('promos',
//           stringValue: json.encode(querySnapshot.data['promo']));
//       // await savePreferences('promos', listValue: querySnapshot.data['promo'].map((document) {
//       //   return document;
//       // }).toList());
//       print("=== DATA SETTING BERHASIL DISIMPAN ===");
//     } else {
//       print("=== DATA SETTING MASIH KOSONG ===");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getSettings();
//     isGoogleSignIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: MediaQuery.of(context).size.width / 3.5,
//               // decoration: BoxDecoration(
//               //   borderRadius: BorderRadius.circular(100.0),
//               //   border: Border.all(
//               //     color: Colors.black12,
//               //     style: BorderStyle.solid,
//               //     width: 6.0,
//               //   ),
//               //   // image: DecorationImage(
//               //   //   image: AssetImage("assets/images/logo/logo.png"),
//               //   //   fit: BoxFit.cover,
//               //   // ),
//               // ),
//               padding: EdgeInsets.all(0),
//               child: Image.asset('assets/images/toko.png'),
//             ),
//             Container(
//                 padding: EdgeInsets.all(1),
//                 width: MediaQuery.of(context).size.width,
//                 child: dynamicText("Agen Romi",
//                     color: Colors.black38,
//                     textAlign: TextAlign.center,
//                     fontSize: 26)),
//             Container(
//                 padding: EdgeInsets.all(0),
//                 width: MediaQuery.of(context).size.width,
//                 child: dynamicText("Belanja semakin lebih mudah",
//                     color: Colors.black38,
//                     textAlign: TextAlign.center,
//                     fontSize: 12)),
//             (!isSignIn)
//                 ? Container(
//                     padding: EdgeInsets.only(top: 40),
//                     child: googleSignInButton(context, () async {
//                       // _auth.handleSignIn().whenComplete(() {
//                       //   navigationManager(context, HomeScreen(), isPushReplaced: true);
//                       // });
//                       await _auth.handleSignIn().then((value) =>
//                           navigationManager(context, HomeScreen(),
//                               isPushReplaced: true));
//                       // var res = await _auth.handleSignIn();
//                       // print(res.photo);
//                     }),
//                   )
//                 : Container(),
//             // Container(
//             //   padding: EdgeInsets.only(top: 40),
//             //   child: googleSignInButton(context, () async {
//             //     var res = await _auth.handleSignIn();
//             //     print(res);
//             //   }),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
