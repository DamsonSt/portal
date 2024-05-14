import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:portal/models/serviceDetailsFull.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_archive/flutter_archive.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, "service_details.db");
    String zipPath = join(documentsDirectory.path, "service_details.zip");

    bool dbExists = await io.File(dbPath).exists();
    print("InitDB $dbExists");

    if (!dbExists) {
      // Copy the zip file from assets
      ByteData zipData = await rootBundle.load('assets/service_details.zip');
      List<int> zipBytes = zipData.buffer.asUint8List(zipData.offsetInBytes, zipData.lengthInBytes);
      await io.File(zipPath).writeAsBytes(zipBytes, flush: true);

      print('Zip file copied to: $zipPath');

      // Unzip the file
      await ZipFile.extractToDirectory(
        zipFile: io.File(zipPath),
        destinationDir: io.Directory(documentsDirectory.path),
      );

      print('Zip file extracted to: ${documentsDirectory.path}');

      
    }

    return await openDatabase(dbPath, version: 1);
  }


  Future<List<ServiceDetails>> getServiceDetails() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM details');
    List<ServiceDetails> serviceDetails = [];
    for (int i = 0; i < list.length; i++) {
      serviceDetails.add(ServiceDetails(
        id: list[i]['id'],
        name: list[i]['name'],
        priority: list[i]['priority'],
        tags: list[i]['tags'],
        organization: list[i]['organization'],
        category: list[i]['category'],
        description: Description(
          receipt: Receipt(
            applyMethod: list[i]['description_receipt_apply_method'],
            getResultMethod: list[i]['description_receipt_get_result_method'],
            applyUrl: list[i]['description_receipt_apply_url'],
          ),
          payment: Payment(
            paymentType: list[i]['description_payment_payment_type'],
            paymentAmount: list[i]['description_payment_payment_amount'],
            paymentAmountUrgent: list[i]
                ['description_payment_payment_amount_urgent'],
            paymentAmountCoins: list[i]
                ['description_payment_payment_amount_coins'],
            paymentAmountUrgentCoins: list[i]
                ['description_payment_payment_amount_urgent_coins'],
            paymentAmountUl: list[i]['description_payment_payment_amount_ul'],
            paymentAmountUrgentUl: list[i]
                ['description_payment_payment_amount_urgent_ul'],
            paymentAmountCoinsUl: list[i]
                ['description_payment_payment_amount_coins_ul'],
            paymentAmountUrgentCoinsUl: list[i]
                ['description_payment_payment_amount_urgent_coins_ul'],
            paymentMethod: list[i]['description_payment_payment_method'],
          ),
          time: Time(
            maxExecutionTime: list[i]['description_time_max_execution_time'],
            maxRegisterTime: list[i]['description_time_max_register_time'],
            maxWaitTime: list[i]['description_time_max_wait_time'],
          ),
          recipientCategories: list[i]['description_recipient_categories'],
          serviceReason: list[i]['description_service_reason'],
          suspendReason: list[i]['description_suspend_reason'],
          denialReason: list[i]['description_denial_reason'],
          serviceResult: list[i]['description_service_result'],
          stateDutyPayment: StateDutyPayment(
            accountNumber: list[i]
                ['description_state_duty_payment_account_number'],
            taxCodes: TaxCodes(
              taxCodeTir: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_tir'],
              taxCodeBen: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_ben'],
              taxCodeRyb: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_ryb'],
              taxCodeKam: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_kam'],
              taxCodeDub: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_dub'],
              taxCodeGri: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_gri'],
              taxCodeSlo: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_slo'],
              taxCodeDne: list[i]
                  ['description_state_duty_payment_tax_codes_tax_code_dne'],
            ),
            accountNumbers: AccountNumbers(
              accountNumberDne: list[i][
                  'description_state_duty_payment_account_numbers_account_number_dne'],
              accountNumberBen: list[i][
                  'description_state_duty_payment_account_numbers_account_number_ben'],
              accountNumberRyb: list[i][
                  'description_state_duty_payment_account_numbers_account_number_ryb'],
              accountNumberKam: list[i][
                  'description_state_duty_payment_account_numbers_account_number_kam'],
              accountNumberDub: list[i][
                  'description_state_duty_payment_account_numbers_account_number_dub'],
              accountNumberGri: list[i][
                  'description_state_duty_payment_account_numbers_account_number_gri'],
              accountNumberSlo: list[i][
                  'description_state_duty_payment_account_numbers_account_number_slo'],

            ),
            article: list[i]['description_state_duty_payment_article'],
            incomesClassification: list[i]
                ['description_state_duty_payment_incomes_classification'],
          ),
          hasPublicServiceStatus: list[i]
              ['description_has_public_service_status'],
          needConfirmation: list[i]['description_need_confirmation'],
          hasElectronicView: list[i]['description_has_electronic_view'],
          hasElectronicForm: list[i]['description_has_electronic_form'],
          hideService: list[i]['description_hide_service'],
        ),
        extra: Extra(
          appealOrder: list[i]['extra_appeal_order'],
          organizations: list[i]['extra_organizations'],
          rightsAndDuties: list[i]['extra_rights_and_duties'],
          regulations: list[i]['extra_regulations'],
        ),
        serviceCanBeInvited: list[i]['serviceCanBeInvited'],
        step: list[i]['step'],
      ));
    }
    return serviceDetails;
  }

  Future<ServiceDetails?> getServiceDetailsById(int id) async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient!.rawQuery('SELECT * FROM details WHERE id = ?', [id]);
    if (list.isNotEmpty) {
      Map<String, dynamic> details = list.first;
      return ServiceDetails(
        id: details['id'],
        name: details['name'],
        priority: details['priority'],
        tags: details['tags'],
        organization: details['organization'],
        category: details['category'],
        description: Description(
          receipt: Receipt(
            applyMethod: details['description_receipt_apply_method'],
            getResultMethod: details['description_receipt_get_result_method'],
            applyUrl: details['description_receipt_apply_url'],
          ),
          payment: Payment(
            paymentType: details['description_payment_payment_type'],
            paymentAmount: details['description_payment_payment_amount'],
            paymentAmountUrgent:
                details['description_payment_payment_amount_urgent'],
            paymentAmountCoins:
                details['description_payment_payment_amount_coins'],
            paymentAmountUrgentCoins:
                details['description_payment_payment_amount_urgent_coins'],
            paymentAmountUl: details['description_payment_payment_amount_ul'],
            paymentAmountUrgentUl:
                details['description_payment_payment_amount_urgent_ul'],
            paymentAmountCoinsUl:
                details['description_payment_payment_amount_coins_ul'],
            paymentAmountUrgentCoinsUl:
                details['description_payment_payment_amount_urgent_coins_ul'],
            paymentMethod: details['description_payment_payment_method'],
          ),
          time: Time(
            maxExecutionTime: details['description_time_max_execution_time'],
            maxRegisterTime: details['description_time_max_register_time'],
            maxWaitTime: details['description_time_max_wait_time'],
          ),
          recipientCategories: details['description_recipient_categories'],
          serviceReason: details['description_service_reason'],
          suspendReason: details['description_suspend_reason'],
          denialReason: details['description_denial_reason'],
          serviceResult: details['description_service_result'],
          stateDutyPayment: StateDutyPayment(
            accountNumber:
                details['description_state_duty_payment_account_number'],
            taxCodes: TaxCodes(
              taxCodeTir: details[
                  'description_state_duty_payment_tax_codes_tax_code_tir'],
              taxCodeBen: details[
                  'description_state_duty_payment_tax_codes_tax_code_ben'],
              taxCodeRyb: details[
                  'description_state_duty_payment_tax_codes_tax_code_ryb'],
              taxCodeKam: details[
                  'description_state_duty_payment_tax_codes_tax_code_kam'],
              taxCodeDub: details[
                  'description_state_duty_payment_tax_codes_tax_code_dub'],
              taxCodeGri: details[
                  'description_state_duty_payment_tax_codes_tax_code_gri'],
              taxCodeSlo: details[
                  'description_state_duty_payment_tax_codes_tax_code_slo'],
              taxCodeDne: details[
                  'description_state_duty_payment_tax_codes_tax_code_dne'],
            ),
            accountNumbers: AccountNumbers(
              accountNumberDne: details[
                  'description_state_duty_payment_account_numbers_account_number_dne'],
              accountNumberBen: details[
                  'description_state_duty_payment_account_numbers_account_number_ben'],
              accountNumberRyb: details[
                  'description_state_duty_payment_account_numbers_account_number_ryb'],
              accountNumberKam: details[
                  'description_state_duty_payment_account_numbers_account_number_kam'],
              accountNumberDub: details[
                  'description_state_duty_payment_account_numbers_account_number_dub'],
              accountNumberGri: details[
                  'description_state_duty_payment_account_numbers_account_number_gri'],
              accountNumberSlo: details[
                  'description_state_duty_payment_account_numbers_account_number_slo'],
            ),
            article: details['description_state_duty_payment_article'],
            incomesClassification: details[
                'description_state_duty_payment_incomes_classification'],
          ),
          hasPublicServiceStatus:
              details['description_has_public_service_status'],
          needConfirmation: details['description_need_confirmation'],
          hasElectronicView: details['description_has_electronic_view'],
          hasElectronicForm: details['description_has_electronic_form'],
          hideService: details['description_hide_service'],
        ),
        extra: Extra(
          appealOrder: details['extra_appeal_order'],
          organizations: details['extra_organizations'],
          rightsAndDuties: details['extra_rights_and_duties'],
          regulations: details['extra_regulations'],
        ),
        serviceCanBeInvited: details['serviceCanBeInvited'],
        step: details['step'],
      );
    }
    return null; // Return null if no details found for the given ID
  }
}
