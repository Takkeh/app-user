import 'package:takkeh/model/registration/countries_model.dart';
import 'package:takkeh/network/registration/countries.dart';

class CountriesController {
  static CountriesModel? countriesModel;
  static late Future<CountriesModel?> countriesData;

  static Future<CountriesModel?> fetchCountriesData() async {
    countriesModel = await CountriesApi.data();
    return countriesModel;
  }
}
