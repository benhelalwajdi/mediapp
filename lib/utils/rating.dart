import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mediapp/utils/const.dart';

class Rating {
  var success;
  List<Rates> rates;

  Rating({
    this.success,
    this.rates,
  });

  factory Rating.fromJson(Map<String, dynamic> rating, List<Rates> r) {
    return Rating(
      success: rating['success'] as String,
      rates: r,
    );
  }
}

class Rates {
  var id;
  var value;
  var user;
  var medicament;
  var createdAt;
  var updatedAt;

  Rates({
    this.id,
    this.value,
    this.user,
    this.medicament,
    this.createdAt,
    this.updatedAt,
  });

  factory Rates.fromJson(Map<String, dynamic> rates) {
    return Rates(
      id: rates['_id'] as String,
      value: rates['value'],
      user: rates['user'] as String,
      medicament: rates['medicament'] as String,
      createdAt: rates['createdAt'] as String,
      updatedAt: rates['updatedAt'] as String,
    );
  }
}

class RatesViewModel {
  // ignore: non_constant_identifier_names
  static List<Rates> Listrates = [];
  static String idPat ;
  static Future loadPlayers() async {
    var url =
        "http://"+Constants.url+":"+Constants.port+"/api/rates/ratesByUser/"+idPat.toString();
    http.get(url, headers: {"Content-Type": "application/json"}).then(
        (http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      String body = response.body;
      print(body);
      List<dynamic> listRates;

      Map<String,dynamic> parsedJson = json.decode(body);
      print(parsedJson["success"].toString());

      for (int i = 0; i < parsedJson["rates"].length; i++) {
        print(i);
        listRates = parsedJson["rates"];
        print(listRates[i].toString());
        Rates rates2 = new Rates.fromJson(listRates[i]);
        Listrates.add(rates2);
        print(rates2.value);
      }
    });
  }
}
