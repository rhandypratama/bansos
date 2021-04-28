import 'package:bansos/pages/kelompok/list-belum-proses.dart';
import 'package:bansos/pages/kelompok/list-proses.dart';
import 'package:bansos/pages/kelompok/list-semua.dart';
import 'package:bansos/utils/widget-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeKelompok extends StatefulWidget {
  final String namaKelompok;
  final int totalPenerima;
  final int totalTransaksi;

  const HomeKelompok({Key key, this.namaKelompok, this.totalPenerima, this.totalTransaksi}) : super(key: key);
  
  @override
  _HomeKelompokState createState() => _HomeKelompokState();
}

class _HomeKelompokState extends State<HomeKelompok> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: dynamicText("${widget.namaKelompok.toUpperCase()}", fontWeight: FontWeight.w600, fontSize: 20),
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/back.svg"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(top: 20, right: 10),
            //     child: dynamicText("${widget.totalPenerima}", color: Colors.blue, fontFamily: "Bebas", fontWeight: FontWeight.w600, fontSize: 24),
            //   )
            // ],
            bottom: TabBar(
              labelColor: Colors.black,
              isScrollable: true,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              // indicatorSize: TabBarIndicatorSize.label,
              
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.grey),
              labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              
              // indicator: BoxDecoration(
              //   borderRadius: BorderRadius.circular(80),
              //   color: Colors.yellow
              // ),
              tabs: [
                Tab(
                  child: Container(
                    // width: 290,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: dynamicText("TER-PROSES (${widget.totalTransaksi})", fontSize: 14)
                        )
                      ]
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 70,
                    child: dynamicText("SEMUA", fontSize: 14)
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 100,
                    child: dynamicText("KESIMPULAN", fontSize: 14)
                  ),
                ),
                
                           
              ]
            ),
          ),
          
          body: TabBarView(children: <Widget>[
            ListProses(kelompok: widget.namaKelompok),
            ListSemua(kelompok: widget.namaKelompok),
            ListBelumProses(kelompok: widget.namaKelompok, jmlTerproses: widget.totalTransaksi.toInt()),
            // BarangScreen(),
            // DaftarPesananScreen(),
          ])
          // body: ListProses(kelompok: widget.namaKelompok),
          // body: ListBelumProses(kelompok: widget.namaKelompok),
          
        ),
      ),
    );
  }
}