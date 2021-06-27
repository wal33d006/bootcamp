import 'dart:convert';
import 'package:bootcamp/helpers/global.dart';
import 'package:bootcamp/models/country_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  Future<List<Country>> fetchCountries() async {
    http.Response response = await getCall(Urls.countries);
    var list = jsonDecode(response.body) as List;
    var countryList = list.map((e) => Country.fromJson(e)).toList();
    return countryList;
  }

  Future<Country> fetchCountryByName(String countryName) async {
    http.Response response = await getCall('${Urls.countries}/$countryName');
    var country = jsonDecode(response.body);
    return Country.fromJson(country);
  }

  Future<http.Response> getCall(String link) async {
    var url = Uri.parse(link);
    var response = await http.get(url);
    return response;
  }
}
