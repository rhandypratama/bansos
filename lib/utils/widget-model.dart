import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';

dynamicText(String text,
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight,
    FontStyle fontStyle = FontStyle.normal,
    TextOverflow overflow,
    TextAlign textAlign,
    bool price = false,
    bool number = false,
    String fontFamily = "OpenSans",
    int maxLines,
    TextDecoration textDecoration}) {
  
  return Text(
    text != null ? text : "",
    style: TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
    ),
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

navigationManager(context, Widget pageScreen, {isPushReplaced = false}) {
  // print('${pageScreen.toString()}');
  isPushReplaced
    ? Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => pageScreen,
        settings: RouteSettings(name: '${pageScreen.toString()}')))
    : Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageScreen,
        settings: RouteSettings(name: '${pageScreen.toString()}')));
}

// SAVE LOCAL DATA STORAGE
savePreferences(String key,
  {bool boolValue,
  int intValue,
  double doubleValue,
  List<String> listValue,
  String stringValue}) async {
  var ref = await SharedPreferences.getInstance();
  if (boolValue != null) {
    ref.setBool(key, boolValue);
  } else if (intValue != null) {
    ref.setInt(key, intValue);
  } else if (doubleValue != null) {
    ref.setDouble(key, doubleValue);
  } else if (stringValue != null) {
    ref.setString(key, stringValue);
  } else if (listValue != null) {
    ref.setStringList(key, listValue);
  }
}

//GET LOCAL DATA STORAGE
getPreferences(String key, {kType}) async {
  var ref = await SharedPreferences.getInstance();
  var value;

  if (kType == 'int') {
    value = ref.getInt(key);
  } else if (kType == 'double') {
    value = ref.getDouble(key);
  } else if (kType == 'string') {
    value = ref.getString(key);
  } else if (kType == 'bool') {
    value = ref.getBool(key);
  } else if (kType == 'list') {
    value = ref.getStringList(key);
  }
  return value;
}

Widget maintenancePage(String message, String subMessage) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // SizedBox(height: 100.0),
  //       SvgPicture.asset(
  //         'assets/images/cart.svg',
  //         placeholderBuilder: (context) => CircularProgressIndicator(),
  //         height: 130,
  // //            color: Colors.white,
  //       ),
        Image.asset(
          'assets/images/cart.png', 
          // fit: BoxFit.contain
          height: 170,
        ),
  //       SvgPicture.asset(
  //         'assets/images/cart.svg',
  //         placeholderBuilder: (context) => CircularProgressIndicator(),
  //         height: 130,
  // //            color: Colors.white,
  //       ),
        // SizedBox(height: 20.0),
        dynamicText(
          message,
          fontSize: 34.0,
          color: Colors.black54,
        ),
  //      SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Text(
            subMessage,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
      ]
    ),
  );
}

Widget noDeviceLocation(BuildContext context, String appBarTitle, String message, String subMessage) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dynamicText(appBarTitle, color: Colors.black),
        ],
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          // 'assets/images/destination_map_marker.png', 
          'assets/gifs/map.gif', 
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain
          // height: 150,
        ),
    //       SvgPicture.asset(
    //         'assets/images/cart.svg',
    //         placeholderBuilder: (context) => CircularProgressIndicator(),
    //         height: 130,
    // //            color: Colors.white,
    //       ),
        SizedBox(height: 20.0),
        dynamicText(
          message,
          fontSize: 20.0,
          color: Colors.black87,
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Text(
            subMessage,
            style: TextStyle(fontSize: 14.0, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
      ]
    ),
  );
}

Widget defaultLoading() {
  return Center(
    child: Container(
      // color: Colors.white,
      child: Image.asset('assets/gifs/loader_circle.gif', width: 34)),
  );
}

Widget googleSignInButton(BuildContext context, Function onPress) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: onPress,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/google-logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Masuk dengan Akun Google',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget googleSignedInInfo(BuildContext context) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/google-logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Masuk dengan Akun Google',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget specUnit(String title, String value, Color fontColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        color: Colors.yellow,
        padding: const EdgeInsets.only(left: 30, bottom: 5, top: 5),
        width: 170,
        // child: dynamicText(title, fontSize: 14, color: fontColor, fontFamily: 'Oswald', fontWeight: FontWeight.w100),
        child: dynamicText(title, fontSize: 12, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
      ),
      // Container(
      //   padding: const EdgeInsets.only(left: 0, bottom: 5),
      //   width: 10,
      //   child: dynamicText(':', fontSize: 14, color: fontColor),
      // ),
      Expanded(
        child: Container(
          color: Colors.yellow[700],
          padding: const EdgeInsets.only(right: 30, bottom: 5, top: 5),
          // width: 100,
          // child: dynamicText('${value ?? "-"}', fontSize: 14, color: fontColor, fontFamily: 'Oswald', fontWeight: FontWeight.w100),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: dynamicText('${value ?? "-"}', fontSize: 12, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
          )
        ),
      ),
    ],
  );
}

//DEFAULT BUTTON
defaultButton(BuildContext context, String label, {Function onPress}) {
  // return RaisedButton(
  //   shape: RoundedRectangleBorder(
  //     borderRadius: new BorderRadius.circular(8.0),
  //   ),
  //   child: Padding(
  //     padding: const EdgeInsets.all(0.0),
  //     child: dynamicText(label, color: Colors.white, fontSize: 16.0),
  //   ),
  //   color: Colors.redAccent,
  //   onPressed: onPress,
  // );

  return SizedBox(
    height: 50,
    child: FlatButton(
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow[800]),
        borderRadius: new BorderRadius.circular(8),
      ),
      color: kKuning,
      onPressed: onPress,
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          // color: Colors.white,
        ),
      ),
    ),
  );
}

fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.55),
      radius: const Radius.elliptical(40.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

defaultAlert(BuildContext context, Function btnPress) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color.fromRGBO(255, 205, 5, 1)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 60.0, bottom: 60.0),
                  child: Image.asset('assets/images/cart.png', height: 100,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: dynamicText("Persiapan dalam order barang",
                    fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "1. Pastikan WhatsApp sudah terinstall di smartphone kalian",
                    fontSize: 14.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "2. Jangan merubah isi / format pesan di WhatsApp, karena itu akan menjadi bukti pesanan kalian",
                    fontSize: 14.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "3. Tunggu konfirmasi berikutnya yang akan di kirim ke WhatsApp kalian",
                    fontSize: 14.0,
                    color: Colors.black45),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                // padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: new BorderRadius.circular(8),
                    ),
                    child: dynamicText('Lanjutkan Pesanan',
                        color: Colors.black87, fontSize: 16),
                    onPressed: btnPress),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    },
  );


}

confirmStnk(BuildContext context, Function btnPress) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color.fromRGBO(255, 205, 5, 1)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: Image.asset('assets/images/authority.png', height: 100,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: dynamicText("Persiapan dalam perpanjang pajak STNK Kendaraan",
                    fontSize: 18.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "1. Pastikan WhatsApp sudah terinstall di smartphone kalian",
                    fontSize: 12.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "2. Jangan merubah isi / format pesan di WhatsApp, karena itu akan menjadi bukti pesanan kalian",
                    fontSize: 12.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "3. Tunggu konfirmasi berikutnya yang akan di kirim ke WhatsApp kalian",
                    fontSize: 12.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "4. Pastikan KTP dan STNK Asli sudah siap",
                    fontSize: 12.0,
                    color: Colors.black45),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: dynamicText(
                    "5. Kami hanya melayani perpanjang pajak STNK Tahunan",
                    fontSize: 12.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                // padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: new BorderRadius.circular(8),
                      ),
                      child: dynamicText('Batal',
                        color: Colors.black87, fontSize: 16),
                      onPressed: () => Navigator.pop(context)
                    ),
                    SizedBox(width: 10),
                    FlatButton(
                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: new BorderRadius.circular(8),
                      ),
                      child: dynamicText('Lanjutkan',
                        color: Colors.black87, fontSize: 16),
                      onPressed: btnPress
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    },
  );
}