import 'package:bansos/pages/add-penerima.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bansos/models/penerima-model.dart';
import 'package:bansos/utils/trip-card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Penyaluran extends StatefulWidget {
  @override
  _PenyaluranState createState() => _PenyaluranState();
}

class _PenyaluranState extends State<Penyaluran> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _uangController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var f = NumberFormat('#,##0', 'id_ID');

  Future resultsLoaded;
  Future resultTotal;
  List _allResults = [];
  List _resultsList = [];
  int _totalPenerima = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _uangController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
    resultTotal = getTotal();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];
    if (_searchController.text != "" && _searchController.text.length > 3) {
      for(var tripSnapshot in _allResults){
        var nama = PenerimaModel.fromSnapshot(tripSnapshot).nama.toLowerCase();
        if(nama.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }

    } else {
      // showResults = List.from(_allResults);
      showResults = [];
      // print(showResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
      .collection('penerimas')
      .orderBy('nama')
      .get();
    setState(() {
      _allResults = data.docs;
      // print(_allResults.length);
    });
    searchResultsList();
    return "complete";
  }

  getTotal() async {
    var dt = await FirebaseFirestore.instance
      .collection('penyalurans')
      .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
      .get();
    setState(() {
      _totalPenerima = dt.docs.length;
    });
    // print(_totalPenerima);
    // return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: dynamicText(
          "Total Penerima Bantuan bulan ini",
          fontFamily: "Bebas",
          fontSize: 20
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('penyalurans')
              .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
              .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('n/a');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("0");
              }
              return Padding(
                padding: EdgeInsets.only(right: 20, top: 16),
                child: dynamicText(
                  f.format(snapshot.data.docs.length).toString(),
                  fontFamily: "Bebas",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                )
              );
            },
          ),
          
        ],
      
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: Column(
          children: <Widget>[
            // Text("Past Trips", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search)
                  
                ),
                style: TextStyle(fontSize: 24),
                
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _resultsList.length,
                  itemBuilder: (BuildContext context, int index) => buildTripCard(context, _resultsList[index], _uangController),
              )

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPenerimaScreen(isEdit: false)));
          if (result != null && result) {
            scaffoldState.currentState.showSnackBar(SnackBar(
              content: Text('Data penerima berhasil disimpan'),
            ));
            setState(() {});
          }
          // navigationManager(context, Penyaluran(), isPushReplaced: false);
        },
      ),
    );
  }
}