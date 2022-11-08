import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';

class PageDetailCountries extends StatefulWidget {
  const PageDetailCountries({Key? key}) : super(key: key);
  @override
  _PageDetailCountriesState createState() => _PageDetailCountriesState();
}

class _PageDetailCountriesState extends State<PageDetailCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card List Countries"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildSuccessSection(CountriesModel data) {
  //   return ListView.builder(
  //     itemCount: data.countries?.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildItemCountries("${data.countries?[index].name}");
  //     },
  //   );
  // }

  Widget _buildSuccessSection(CountriesModel data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: data.countries?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${data.countries?[index].name}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "(${data.countries?[index].iso3})",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}