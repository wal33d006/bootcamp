import 'package:bootcamp/controllers/api_controller.dart';
import 'package:bootcamp/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  final String countryName;

  CountryDetail({required this.countryName});

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  Country? country;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCountryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(country!.country!),
                    subtitle: Text(country!.cases!.toString()),
                  ),
                  Text(country!.cases!.toString()),
                  Text(country!.recovered!.toString()),
                  Text(country!.deaths!.toString()),
                  Text(country!.active!.toString()),
                  Text(country!.casesPerOneMillion!.toString()),
                  Text(country!.critical!.toString()),
                  Text(country!.deathsPerOneMillion!.toString()),
                  Text(country!.testsPerOneMillion!.toString()),
                  Text(country!.totalTests!.toString()),
                  Text(country!.todayCases!.toString()),
                  Text(country!.todayDeaths!.toString()),
                ],
              ),
      ),
    );
  }

  void _fetchCountryDetails() async {
    isLoading = true;
    setState(() {});
    ApiController api = ApiController();
    var countryDetails = await api.fetchCountryByName(widget.countryName);
    country = countryDetails;
    isLoading = false;
    setState(() {});
  }
}
