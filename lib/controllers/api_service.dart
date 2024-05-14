import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal/controllers/local_database.dart';
import 'package:portal/models/service.dart';
import 'package:portal/models/serviceDetailsFull.dart';

class ApiService {
  static const String _baseUrl = 'https://uslugi.gospmr.org/';
  static const bool _devMode = false;

  // Fetches services from the API
  Future<List<Service>> fetchServices() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/?option=com_uslugi&view=gosuslugi&task=getUslugi'));
      if (response.statusCode == 200) {
        String responseData = response.body;
        if (_devMode == true) {
          responseData = trimmer(responseData);
        }
        final jsonData = json.decode(responseData);
        final List<dynamic> serviceData = jsonData['ulist'];
        final services =
            serviceData.map((data) => Service.fromJson(data)).toList();
        return services;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print('Error fetching services: $e');
      return [];
    }
  }

  // Trims unnecessary data from the response
  String trimmer(String responseData) {
    String trimmedBody = responseData.trim();
    int endIndex = trimmedBody.indexOf('<meta charset');
    int startIndex = trimmedBody.indexOf('<body><p>') + 9;
    String fullTrimmedBody = trimmedBody.substring(startIndex, endIndex);
    responseData = fullTrimmedBody;
    return responseData;
  }

  // Fetches details of a service by its ID
  Future<ServiceDetails?> fetchServiceDetails(String serviceId) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/?option=com_uslugi&view=usluga&task=getUsluga&uslugaId=$serviceId'));
      if (response.statusCode == 200) {
        String responseData = response.body;
        if (_devMode == true) {
          responseData = trimmer(responseData);
        }
        final jsonData = json.decode(responseData);
        final service = ServiceDetails.fromJson(jsonData);
        return service;
      } else {
        throw Exception('Failed to load service details ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching service details: $e');
      return null;
    }
  }

  // Fetches service details and inserts them into the local database
  Future<bool> fetchServiceDetailsToDatabase(String serviceId) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/option_com_uslugi_view_usluga_task_getUsluga_uslugaId_$serviceId.html'));
      if (response.statusCode == 200) {
        String responseData = response.body;
        if (_devMode == true) {
          responseData = trimmer(responseData);
        }
        final jsonData = json.decode(responseData);
        final serviceDetails = ServiceDetails.fromJson(jsonData);
        LocalDatabase.insertDetails(serviceDetails);
        return true;
      } else {
        throw Exception('Failed to load service details ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching service details to database: $e');
      return false;
    }
  }

  // Fetches service categories by service ID
  Future<ServiceDetails?> fetchServiceCategories(String serviceId) async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/option_com_uslugi_view_usluga_task_getUsluga_uslugaId_$serviceId'));
      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          final jsonData = json.decode(response.body);
          final service = ServiceDetails.fromJson(jsonData['data']);
          return service;
        } else {
          final jsonData = json.decode(response.body);
          final service = ServiceDetails.fromJson(jsonData);
          return service;
        }
      } else {
        throw Exception('Failed to load service details ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching service categories: $e');
      return null;
    }
  }
}
