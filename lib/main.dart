// import 'package:bansos/pages/add-penerima.dart';
// import 'package:bansos/pages/dashboard.dart';
import 'package:bansos/pages/penyaluran.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'utils/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await savePreferences('selectedMonth', intValue: DateTime.now().month.toInt());
  await savePreferences('selectedYear', intValue: DateTime.now().year.toInt());
  await Firebase.initializeApp();
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // theme: ThemeData.dark(),
      // home: Welcome()
      // home: Dashboard()
      // home: AddPenerimaScreen(isEdit: false),
      home: Penyaluran(),
    ),
  );
}