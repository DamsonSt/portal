import 'package:flutter/material.dart';
import 'package:portal/models/service.dart';
import 'package:portal/models/serviceDetailsFull.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:portal/screens/detail_screen.dart';
import 'package:portal/controllers/dbhelper.dart';

class ResultScreen extends StatefulWidget {
  final List<Service> services;
  final bool isCheckedHasElectronicView;
  final bool isCheckedOrganization;
  final bool isCheckedCategory;
  final bool isCheckedPaid;

  const ResultScreen({
    super.key,
    required this.services,
    required this.isCheckedHasElectronicView,
    required this.isCheckedOrganization,
    required this.isCheckedCategory,
    required this.isCheckedPaid,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

String modifyUrl(String originalUrl) {
  return originalUrl.contains('://') ? originalUrl : 'http:$originalUrl';
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, ServiceDetails> serviceDetailsMap = {};

  @override
  void initState() {
    super.initState();
    for (var service in widget.services) {
      getServiceDetailsFromDB(service.id);
    }
  }

 void getServiceDetailsFromDB(String serviceId) async {
  print("serviceDetails");
  var dbHelper = DBHelper();
  int id = int.tryParse(serviceId) ?? 0; // Convert string to int
  ServiceDetails? details = await dbHelper.getServiceDetailsById(id);
  if (mounted) { // Check if the widget is mounted before calling setState
    if (details != null) {
      setState(() {
        serviceDetailsMap[serviceId] = details;
      });
    } else {
      print('No service details found for ID: $id');
    }
  }
}

  @override
Widget build(BuildContext context) {
  if (widget.services == null || widget.services.isEmpty) {
    // If services list is null or empty, show loading circle with "Нет соединения" message
    return Scaffold(
      appBar: AppBar(
        title: const Text('Услуги'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Нет соединения',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  } else {
    // If services list is not null and not empty, show the GroupedListView
    return Scaffold(
      appBar: AppBar(
        title: const Text('Услуги'),
      ),
      body: GroupedListView<Service, dynamic>(
        elements: widget.services,
        groupBy: (element) => widget.isCheckedOrganization
            ? element.orgName
            : serviceDetailsMap[element.id]?.category,
        groupComparator: (value1, value2) {
          if (value1 == null && value2 == null) {
            return 0; // Consider both null values as equal
          } else if (value1 == null) {
            return 1; // Consider null as greater than any non-null value
          } else if (value2 == null) {
            return -1; // Consider null as less than any non-null value
          } else {
            return value2.compareTo(value1);
          }
        },
        itemComparator: (item1, item2) => item1.name.compareTo(item2.name),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (dynamic value) {
          if (value != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (BuildContext context, Service element) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(serviceId: element.id),
                ),
              );
            },
            child: Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: Image.network(
                    modifyUrl(element.iconLink),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(element.name),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
}
