import 'package:bansos/pages/history.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bansos/pages/add-penerima.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:bansos/models/penerima-model.dart';
import 'package:bansos/utils/trip-card.dart';

class Penyaluran extends StatefulWidget {
  @override
  _PenyaluranState createState() => _PenyaluranState();
}

class _PenyaluranState extends State<Penyaluran> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _uangController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
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
    super.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _uangController.dispose();
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
      .where('tanggal_pengambilan', isLessThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 31))
      .get();
    setState(() {
      _totalPenerima = dt.docs.length;
    });
    // print(_totalPenerima);
    // return "complete";
  }

  Future<Null> _refreshPage() async {
    resultsLoaded = getUsersPastTripsStreamSnapshots();
    resultTotal = getTotal();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        // automaticallyImplyLeading: true,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 8),
          child: IconButton(
            // icon: SvgPicture.asset("assets/icons/back.svg"),
            icon: Icon(Icons.history_sharp, color: Colors.black54, size: 28),
            onPressed: () {
              navigationManager(context, History(), isPushReplaced: false);
            },
          ),
        ),
        title: dynamicText(
          "Transaksi bulan ${DateFormat('MMMM').format(DateTime.now())}",
          fontFamily: "Bebas",
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('penyalurans')
              .where('tanggal_pengambilan', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 1))
              .where('tanggal_pengambilan', isLessThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, 31))
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).primaryColor,
                  color: Colors.teal[400],
                )
              );
            },
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 20, top: 16),
          //   child: dynamicText(
          //     _totalPenerima.toString(),
          //     fontFamily: "Bebas",
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //     color: Theme.of(context).primaryColor,
          //   )
          // ),
        ],
      
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Container(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: <Widget>[
              // Text("Past Trips", style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: 
                searchField()
                // TextField(
                //   controller: _searchController,
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(Icons.search)
                    
                //   ),
                //   style: TextStyle(fontSize: 24),
                  
                // ),
              ),
              // dynamicText('${_resultsList.length}'),
              Expanded(
                child: 
                _resultsList.length > 0
                ? ListView.builder(
                    itemCount: _resultsList.length,
                    itemBuilder: (BuildContext context, int index) => buildTripCard(context, _resultsList[index], _uangController),
                  )
                : _searchController.text.length > 3
                  ? Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(60, 40, 60, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/img/bolt.png', width: 100),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: dynamicText("Oops, data tidak ditemukan", fontSize: 22),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: dynamicText("Periksa kembali penulisan nama. Jika masih tidak ditemukan, silahkan input datanya terlebih dulu", fontSize: 14, textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                  )
                  : Container(),

              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
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

  Widget searchField() {
    return TextFormField(
      controller: _searchController,
      autocorrect: false,
      textInputAction: TextInputAction.search,
      textCapitalization: TextCapitalization.none,
      focusNode: _searchFocus,
      onFieldSubmitted: (term) {
        _searchFocus.unfocus();
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        // labelText: "Nama Penerima",
        // labelStyle: TextStyle(fontSize: 20.0),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        prefixIcon: Icon(Icons.search, color: Colors.black54),
        suffixIcon: Icon(Icons.mic, color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          // borderSide: BorderSide(
          //   color: Color.fromRGBO(13, 186, 146, 1), 
          //   width: 1.0
          // ),
          borderSide: BorderSide(color: Colors.black54, width: 0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        // fillColor: Colors.red,
        // helperText: "Contoh : 0001234567890"
      ),
      style: TextStyle(fontSize: 22, color: Colors.black87),
      
      // decoration: textInputDecoration(Icons.person, "Email", snapshot, hintText: "Email"),
    );      
  }

}