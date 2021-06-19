import 'dart:convert';

import 'package:bootcamp/country_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  final String name;
  final VoidCallback onPressed;

  SecondScreen({
    required this.name,
    required this.onPressed,
  });

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Country> countries = <Country>[];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                var country = countries[index];
                var firstLetter = country.country![0];
                return ListTile(
                  title: Text(country.country!),
                  subtitle: Text(country.cases.toString()),
                  leading: CircleAvatar(
                    child: Text(firstLetter),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onPressed();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _fetchCountries() async {
    isLoading = true;
    setState(() {});
    try {
      var url = Uri.parse('https://coronavirus-19-api.herokuapp.com/countries');
      var response = await http.get(url);
      print(response.body);
      var list = jsonDecode(response.body) as List;
      var countryList = list.map((e) => Country.fromJson(e)).toList();
      countries.addAll(countryList);
    } catch (ex) {
      print(ex);
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}
