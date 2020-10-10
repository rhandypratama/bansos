import 'package:bansos/pages/kelompok/list-belum-proses.dart';
import 'package:bansos/pages/kelompok/list-proses.dart';
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
        length: 2,
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
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
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
                    width: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: dynamicText("SUDAH DI PROSES (${widget.totalTransaksi})", fontSize: 14)
                        )
                      ]
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          // child: dynamicText("BELUM MENGAMBIL", fontSize: 14)
                          child: dynamicText("KESIMPULAN", fontSize: 14)
                        )
                      ]
                    ),
                  ),
                ),
                           
              ]
            ),
          ),
          
          body: TabBarView(children: <Widget>[
            ListProses(kelompok: widget.namaKelompok),
            ListBelumProses(kelompok: widget.namaKelompok),
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