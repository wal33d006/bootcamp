import 'package:bootcamp/views/country_detail.dart';
import 'package:bootcamp/models/country_model.dart';
import 'package:flutter/material.dart';

import '../controllers/api_controller.dart';

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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CountryDetail(countryName: country.country!),
                      ),
                    );
                  },
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
      ApiController api = ApiController();
      var list = await api.fetchCountries();
      countries.addAll(list);
    } catch (ex) {
      print(ex);
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}
