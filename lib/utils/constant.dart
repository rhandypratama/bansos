import 'package:flutter/material.dart';
import 'widget-model.dart';

const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const kKuning = Color.fromRGBO(255, 205, 5, 1);

const kDefaultPaddin = 20.0;
const defaultImage = "https://lh3.googleusercontent.com/proxy/FbqqgxWEowm8-lror2n3OIbot7H7CIlLQWc2TB9oiqthUdbo5EyXPu2Jz5A_1GJ6rLgW8tOQ6Shb4SbuhQnU5pfZA-R8";
// const adminNumber = "+6283104597023";
// const adminNumber = "+6283104597023";
var adminTest = () async => await getPreferences('admin-test', kType: 'string');
var adminUtama = () async => await getPreferences('admin-utama', kType: 'string');
var adminMakanan = () async => await getPreferences('admin-makanan', kType: 'string');

