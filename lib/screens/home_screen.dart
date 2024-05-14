import 'package:flutter/material.dart';
import 'package:portal/controllers/dbhelper.dart';
import 'package:portal/screens/result_screen.dart';
import 'package:portal/models/service.dart';
import 'package:portal/controllers/api_service.dart';

import 'package:portal/models/serviceDetailsFull.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool? _isCheckedHasElectronicView = false;
  bool? _isCheckedOrganization = true;
  bool? _isCheckedCategory = false;
  bool? _isCheckedPaid = false;

  String _currText = '';

  List<String> text = [
    "Доступны для заказа в электронной форме ",
    "Отобразить перечень услуг по ведомству ",
    "Отобразить перечень услуг по категориям",
    "Отобразить платные услуги"
  ];

  final ApiService _apiService = ApiService();

  
  // List<ServiceDetails> details = [];
  List<Service> serviceList = [];
  List<ServiceDetails> serviceDetailsList = [];
  bool isLoading = true;

    // getDetails() async {
    //   var time = await LocalDatabase.getSaveTime();
    //   setState(() {
    //     savedTime = time;
    //   });
    // }

    // read data from local database
  makeDatabase() async {
      print("fetching the api");
      var uslugi = await _apiService.fetchServices();
      print("fetching the api ${uslugi.length}");
      for (var i = 0; i < uslugi.length; i++) {
        print("fetching $i");
        // printDB();
        try{
          var isApifetching = await _apiService.fetchServiceDetailsToDatabase(uslugi[i].id);
          if (isApifetching) {
            // getDetailsFromDB();
            print("fetching");

          }else{

            print("not fetching");
          }
        }
        catch (e)
        {
          print("error $e");
        }
      }
  }
          

  void getServices() async {
    print("getServices");
    // var dbHelper = DBHelper();
    List<Service> _serviceList = await _apiService.fetchServices();
    setState(() {
      serviceList = _serviceList;
    });
    // testData(serviceList);
  }


  void getServiceDetailsFromDB() async {
    print("serviceDetails");
    var dbHelper = DBHelper();
    List<ServiceDetails> _serviceDetailsList = await dbHelper.getServiceDetails();
    setState(() {
      serviceDetailsList = _serviceDetailsList;
    });
    // testData(serviceDetailsList);
  }

  void testData(List<ServiceDetails> serviceListToTest) async {
    for(int i=0; i < serviceListToTest.length; i++)
    {
      print(serviceListToTest[i].name);
    }
    
  }

   @override
  void initState() {
    // makeDatabase();
    getServices();
    getServiceDetailsFromDB();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Портал"),
      ),
      body: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(_currText,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                      height: 350.0,
                      child: Column(children: [
                        // Text(
                        //     serviceList != null && serviceList.isNotEmpty
                        //         ? "${serviceList.length}"
                        //         : "nan",
                        //   ),
                        CheckboxListTile(
                          title: Text(text[0]),
                          value: _isCheckedHasElectronicView,
                          onChanged: (val) {
                            setState(() {
                              _isCheckedHasElectronicView = val;
                              if (val == true) {
                                // _currText = t;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(text[1]),
                          value: _isCheckedOrganization,
                          onChanged: (val) {
                            setState(() {
                              _isCheckedOrganization = val;
                              _isCheckedCategory = !_isCheckedOrganization!;
                              if (val == true) {
                                // _currText = t;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(text[2]),
                          value: _isCheckedCategory,
                          onChanged: (val) {
                            setState(() {
                              _isCheckedCategory = val;
                              _isCheckedOrganization = !_isCheckedCategory!;
                              if (val == true) {
                                // _currText = t;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(text[3]),
                          value: _isCheckedPaid,
                          onChanged: (val) {
                            setState(() {
                              _isCheckedPaid = val;
                              if (val == true) {
                                // _currText = t;
                              }
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: ()  {
                            final filteredServices = _applyFilters(serviceList, serviceDetailsList, _isCheckedHasElectronicView, _isCheckedPaid);
                            // print(filteredServices);
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                services: filteredServices,
                                isCheckedHasElectronicView:
                                    _isCheckedHasElectronicView!,
                                isCheckedOrganization: _isCheckedOrganization!,
                                isCheckedCategory: _isCheckedCategory!,
                                isCheckedPaid: _isCheckedPaid!,
                              ),
                            ),
                          );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(25),
                            child: const Center(
                                child: Text(
                              "Отобразить",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ])),
                ),
              ],
            ),
    );
  }

List<Service> _applyFilters(List<Service> services, List<ServiceDetails> serviceDetailsList, bool? isCheckedHasElectronicView, bool? isCheckedPaid) {
  List<Service> filteredServices = List.from(services); // Create a copy of the original list

  // Apply filter based on isCheckedHasElectronicView
  if (isCheckedHasElectronicView != null) {
    if (isCheckedHasElectronicView) {
      filteredServices.removeWhere((service) => service.hasElectronicView == 0);
    } else {
      filteredServices.removeWhere((service) => service.hasElectronicView != 0);
    }
  }

  // Apply filter based on isCheckedPaid
  if (isCheckedPaid != null) {
    List<int?> idsToRemove = [];
    List<String> paymentKeywords = [
      'безвозмездно',
      'бесплатно',
      'без оплаты',
      'не взимается',
      'не взимается.',
      'не взимаются',
      'не предусмотрен',
    ];

    for (ServiceDetails? details in serviceDetailsList) {
      bool containsKeyword = false;
      if (details != null &&
          details.description != null &&
          details.description?.payment != null) {
        String? paymentType = details.description?.payment?.paymentType;
        String? paymentMethod = details.description?.payment?.paymentMethod;
        String? paymentAmount = details.description?.payment?.paymentAmount;

        // Search in paymentType, paymentMethod, and paymentAmount
        if (paymentType != null || paymentMethod != null || paymentAmount != null) {
          for (String keyword in paymentKeywords) {
            if ((paymentType?.contains(keyword) ?? false) ||
                (paymentMethod?.contains(keyword) ?? false) ||
                (paymentAmount?.contains(keyword) ?? false)) {
              containsKeyword = true;
              break;
            }
          }
        }
      }

      if ((isCheckedPaid && containsKeyword) || (!isCheckedPaid && !containsKeyword)) {
        idsToRemove.add(details?.id);
      }
    }

    // Remove services with matching IDs
    filteredServices.removeWhere((service) => idsToRemove.contains(int.tryParse(service.id)));
  }

  // Remove services with no corresponding ID in serviceDetailsList
  filteredServices.removeWhere((service) => serviceDetailsList.every((detail) => detail.id != int.tryParse(service.id)));

  return filteredServices;
}






}
