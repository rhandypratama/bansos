import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  final String images;
  final String title;
  final Color textcolor;
  final bool visibleBadge;
  final String totalBadge;
  final Function onTap;
  const MenuItem({
    Key key, 
    this.images, 
    this.title, 
    this.textcolor, 
    this.visibleBadge = false, 
    this.totalBadge = '', 
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 120,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(vertical: 20.0, ),
      
        child: Column(
        children: <Widget>[
          // SizedBox(height: 20),
          Material(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.blueAccent.withOpacity(0.1),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    images,
                    placeholderBuilder: (context) => CircularProgressIndicator(),
                    height: 120,
                    color: Colors.grey,
                  ),
                  color: Colors.teal,
                  onPressed: onTap
                ),
                Positioned(
                  top: 0.0,
                  left: 22.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 18.0,
                        width: 18.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: (visibleBadge) ? Colors.red : Colors.transparent
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                totalBadge,
                                style: TextStyle(
                                  color: (visibleBadge) ? Colors.white : Colors.transparent, 
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
          SizedBox(height: 10),
          // dynamicText(title, fontFamily: "Oswald"),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textcolor ?? Colors.black87,
              fontSize: 12.0,
              fontFamily: "Oswald"
              
            ),
          )
        ],
      ),
      
    );
  }
}