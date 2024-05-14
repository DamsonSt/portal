import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:portal/controllers/api_service.dart';
import 'package:portal/controllers/dbhelper.dart';
import 'package:portal/models/serviceDetailsFull.dart';
import 'package:connectivity/connectivity.dart';

class DetailScreen extends StatefulWidget {
  final String serviceId;

  const DetailScreen({super.key, required this.serviceId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService _apiService = ApiService();

  late Future<ServiceDetails?> _futureServiceDetails;
  ServiceDetails? serviceDetails;
  bool isLoading = true;

  void getServiceDetailsFromDB(String serviceId) async {
    print("serviceDetails");
    var dbHelper = DBHelper();
    int id = int.tryParse(serviceId) ?? 0; // Convert string to int
    ServiceDetails? details = await dbHelper.getServiceDetailsById(id);
    if (details != null) {
      setState(() {
        serviceDetails = details;
        isLoading = false;
      });
    } else {
      print('No service details found for ID: $id');
      ServiceDetails? fetchedDetails =
          await _apiService.fetchServiceDetails(widget.serviceId);
      setState(() {
        serviceDetails = fetchedDetails;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getServiceDetailsFromDB(widget.serviceId);
    if (serviceDetails?.name == null) {
      print("serviceDetails null");
      checkInternetAndFetchServiceDetails();
    }
  }

  Future<void> checkInternetAndFetchServiceDetails() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      print('No internet connection');
      // Handle no internet connection scenario
    } else {
      // Internet connection available
      print('Internet connection available');
      // Fetch service details from the API
      _futureServiceDetails = _apiService.fetchServiceDetails(widget.serviceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробности услуги'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HtmlWidget(
                    _replaceLineBreaks(serviceDetails?.name ?? ''),
                    textStyle: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (serviceDetails?.name != null &&
                      serviceDetails!.name!.isNotEmpty)
                    HtmlWidget('Услуга: ${serviceDetails?.name}'),
                  const SizedBox(height: 16),
                  if (serviceDetails?.category != null &&
                      serviceDetails!.category!.isNotEmpty)
                    HtmlWidget('Категория: ${serviceDetails?.category}'),
                  if (serviceDetails?.priority != null)
                    HtmlWidget('Приоритет: ${serviceDetails?.priority}'),
                  if (serviceDetails?.organization != null &&
                      serviceDetails!.organization!.isNotEmpty)
                    HtmlWidget('Организация: ${serviceDetails?.organization}'),
                  if (serviceDetails?.description?.serviceReason != null &&
                      serviceDetails!.description!.serviceReason!.isNotEmpty)
                    HtmlWidget(
                        'Причина услуги: ${serviceDetails?.description?.serviceReason}'),
                  if (serviceDetails?.description?.serviceResult != null &&
                      serviceDetails!.description!.serviceResult!.isNotEmpty)
                    HtmlWidget(
                        'Результат услуги: ${serviceDetails?.description?.serviceResult}'),
                  const SizedBox(height: 16),
                  if (serviceDetails?.description?.receipt?.applyMethod !=
                          null ||
                      serviceDetails?.description?.receipt?.getResultMethod !=
                          null ||
                      serviceDetails?.description?.receipt?.applyUrl != null)
                    const HtmlWidget(
                      'Информация о получении услуги:',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 8),
                  if (serviceDetails?.description?.receipt?.applyMethod !=
                          null &&
                      serviceDetails!
                          .description!.receipt!.applyMethod!.isNotEmpty)
                    HtmlWidget(
                        'Метод подачи заявки: ${serviceDetails?.description?.receipt?.applyMethod}'),
                  if (serviceDetails?.description?.receipt?.getResultMethod !=
                          null &&
                      serviceDetails!
                          .description!.receipt!.getResultMethod!.isNotEmpty)
                    HtmlWidget(
                        'Метод получения результата: ${serviceDetails?.description?.receipt?.getResultMethod}'),
                  if (serviceDetails?.description?.receipt?.applyUrl != null &&
                      serviceDetails!
                          .description!.receipt!.applyUrl!.isNotEmpty)
                    HtmlWidget(
                        'URL для подачи заявки: ${serviceDetails?.description?.receipt?.applyUrl}'),
                  const SizedBox(height: 16),
                  if (_hasPaymentDetails()) // Check if any payment details exist
                    const HtmlWidget(
                      'Информация об оплате:',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 8),
                  _buildPaymentField('Тип оплаты',
                      serviceDetails?.description?.payment?.paymentType),
                  _buildPaymentField(
                      'Сумма оплаты',
                      serviceDetails?.description?.payment?.paymentAmount
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (срочная)',
                      serviceDetails?.description?.payment?.paymentAmountUrgent
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (монеты)',
                      serviceDetails?.description?.payment?.paymentAmountCoins
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (срочная, монеты)',
                      serviceDetails
                          ?.description?.payment?.paymentAmountUrgentCoins
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (условные единицы)',
                      serviceDetails?.description?.payment?.paymentAmountUl
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (срочная, условные единицы)',
                      serviceDetails
                          ?.description?.payment?.paymentAmountUrgentUl
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (монеты, условные единицы)',
                      serviceDetails?.description?.payment?.paymentAmountCoinsUl
                          ?.toString()),
                  _buildPaymentField(
                      'Сумма оплаты (срочная, монеты, условные единицы)',
                      serviceDetails
                          ?.description?.payment?.paymentAmountUrgentCoinsUl
                          ?.toString()),
                  _buildPaymentField('Метод оплаты',
                      serviceDetails?.description?.payment?.paymentMethod),
                ],
              ),
            ),
    );
  }

  String _replaceLineBreaks(String text) {
    // Replace occurrences of </br> and </br></br> with new lines
    return text.replaceAllMapped(RegExp(r'<\/?br\s?\/?>', caseSensitive: false),
        (match) {
      return '\n';
    });
  }

  Widget _buildPaymentField(String label, String? value) {
    if (value != null && value.isNotEmpty) {
      return HtmlWidget('$label: $value');
    } else {
      return Container();
    }
  }

  bool _hasPaymentDetails() {
    final payment = serviceDetails?.description?.payment;
    return payment != null &&
        (payment.paymentType != null ||
            payment.paymentAmount != null ||
            payment.paymentAmountUrgent != null ||
            payment.paymentAmountCoins != null ||
            payment.paymentAmountUrgentCoins != null ||
            payment.paymentAmountUl != null ||
            payment.paymentAmountUrgentUl != null ||
            payment.paymentAmountCoinsUl != null ||
            payment.paymentAmountUrgentCoinsUl != null ||
            payment.paymentMethod != null);
  }
}
