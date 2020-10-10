import 'dart:async';

// import 'package:personel/utils/api-response.dart';
// import 'package:project_boilerplate/riwayat_kerja/data/riwayat_kerja_response.dart';
// import 'package:project_boilerplate/utils/constants/strings.dart';
// import 'package:project_boilerplate/utils/widgets/api_response.dart';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
    } else {
      final RegExp emailRegEx = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!emailRegEx.hasMatch(email)) {
        sink.addError('Format penulisan email tidak valid');
      } else {
        sink.add(email);
      }
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length < 6 && password.length != 0) {
      sink.addError('Password harus lebih dari 6 karakter');
    } else {
      sink.add(password);
    }
  });

  final validatePricing =
      StreamTransformer<String, String>.fromHandlers(handleData: (price, sink) {
    if (price.length != 0) {
      price = price.replaceAll(new RegExp(r'[^\w\s]+'), '');
      print("price: $price");
      if (price.length < 4) {
        if (int.parse(price) == 0) {
          sink.addError("Total Harga tidak boleh 0");
        } else {
          sink.addError("Total Harga tidak boleh kurang dari 1000");
        }
      } else {
        sink.add(price);
      }
    }
  });

  final validateInputTxt = StreamTransformer<String, String>.fromHandlers(
      handleData: (content, sink) {
    if (content.length == 0) {
      sink.addError('Tulis Pesanmu');
    } else {
      sink.add(content);
    }
  });

  // final sortData = StreamTransformer<ApiResponse<List<Data>>, ApiResponse<List<Data>>>.fromHandlers(
  //     handleData: (content, sink) {
  //      content.data.sort((a,b) => b.attributes.shift.date_active.compareTo(a.attributes.shift.date_active));
  //      sink.add(content);
  //     });
}
