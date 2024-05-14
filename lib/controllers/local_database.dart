import 'package:portal/models/serviceDetailsFull.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // create or open a new database
  static Future<Database> createDatabase() async {
    return await openDatabase(
      "service_details.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            // 'CREATE TABLE news (id INTEGER PRIMARY KEY,title TEXT, url TEXT, author VARCAR(255), updatedAt TEXT)'
            """CREATE TABLE [details] (
                  [id] INTEGER PRIMARY KEY,
                  [name] TEXT,
                  [priority] TEXT,
                  [tags] TEXT,
                  [organization] TEXT,
                  [category] TEXT,
                  [description_receipt_apply_method] TEXT,
                  [description_receipt_get_result_method] TEXT,
                  [description_receipt_apply_url] TEXT,
                  [description_payment_payment_type] TEXT,
                  [description_payment_payment_amount] TEXT,
                  [description_payment_payment_amount_urgent] TEXT,
                  [description_payment_payment_amount_coins] TEXT,
                  [description_payment_payment_amount_urgent_coins] TEXT,
                  [description_payment_payment_amount_ul] TEXT,
                  [description_payment_payment_amount_urgent_ul] TEXT,
                  [description_payment_payment_amount_coins_ul] TEXT,
                  [description_payment_payment_amount_urgent_coins_ul] TEXT,
                  [description_payment_payment_method] TEXT,
                  [description_time_max_execution_time] TEXT,
                  [description_time_max_register_time] TEXT,
                  [description_time_max_wait_time] TEXT,
                  [description_recipient_categories] TEXT,
                  [description_service_reason] TEXT,
                  [description_suspend_reason] TEXT,
                  [description_denial_reason] TEXT,
                  [description_service_result] TEXT,
                  [description_digital_signature_certificate_imprint] TEXT,
                  [description_state_duty_payment_account_number] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_tir] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_ben] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_ryb] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_kam] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_dub] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_gri] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_slo] TEXT,
                  [description_state_duty_payment_tax_codes_tax_code_dne] TEXT,
                  [description_state_duty_payment_account_numbers_account_number] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_ben] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_ryb] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_kam] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_dub] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_gri] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_slo] TEXT,
                  [description_state_duty_payment_account_numbers_account_number_dne] TEXT,
                  [description_state_duty_payment_article] TEXT,
                  [description_state_duty_payment_incomes_classification] TEXT,
                  [description_has_public_service_status] INT,
                  [description_need_confirmation] INT,
                  [description_has_electronic_view] INT,
                  [description_has_electronic_form] INT,
                  [description_hide_service] INT,
                  [documents_apply] TEXT,
                  [documents_result] TEXT,
                  [documents_blank] TEXT,
                  [documents_reglament_name] TEXT,
                  [documents_reglament_file] TEXT,
                  [contacts_name] TEXT,
                  [contacts_boss] TEXT,
                  [contacts_address] TEXT,
                  [contacts_phone] TEXT,
                  [contacts_fax] TEXT,
                  [contacts_site] TEXT,
                  [contacts_schedule] TEXT,
                  [extra_appeal_order] TEXT,
                  [extra_organizations] TEXT,
                  [extra_rights_and_duties] TEXT,
                  [extra_regulations] TEXT,
                  [service_information_form_scheme] TEXT,
                  [service_information_rospih_scheme] TEXT,
                  [service_information_additional_scheme] TEXT,
                  [service_information_service_steps] TEXT,
                  [service_information_xml_template] TEXT,
                  
                  [serviceCanBeInvited] INT,
                  [step] TEXT
                  )""");

        // [access_canUserOrder] BIT,
        // [access_requireErnValidation] BIT,
        // [access_fiz_only] BIT,
        // [access_ur_only] BIT,

        // await db.execute(
        //     'CREATE TABLE saved_time (page_no INTEGER PRIMARY KEY, lastSavedTime DATETIME)');
      },
    );
  }

  static Future insertDetails(ServiceDetails serviceDetails) async {
    var db = await createDatabase();
// "payment_amount_coins":"0","payment_amount_urgent_coins":"0"
    print("insertDetails");
    return await db.insert(
        "details",
        {
          "id": serviceDetails.id,
          "name": serviceDetails.name,
          "priority": serviceDetails.priority,
          "tags": serviceDetails.tags,
          "organization": serviceDetails.organization,
          "category": serviceDetails.category,
          "description_receipt_apply_method":
              serviceDetails.description?.receipt?.applyMethod,
          "description_receipt_get_result_method":
              serviceDetails.description?.receipt?.getResultMethod,
          "description_receipt_apply_url":
              serviceDetails.description?.receipt?.applyUrl,
          "description_payment_payment_type":
              serviceDetails.description?.payment?.paymentType,
          "description_payment_payment_amount":
              serviceDetails.description?.payment?.paymentAmount,
          "description_payment_payment_amount_urgent":
              serviceDetails.description?.payment?.paymentAmountUrgent,
          "description_payment_payment_amount_coins":
              serviceDetails.description?.payment?.paymentAmountCoins,
          "description_payment_payment_amount_urgent_coins":
              serviceDetails.description?.payment?.paymentAmountUrgentCoins,
          "description_payment_payment_amount_ul":
              serviceDetails.description?.payment?.paymentAmountUl,
          "description_payment_payment_amount_urgent_ul":
              serviceDetails.description?.payment?.paymentAmountUrgentUl,
          "description_payment_payment_amount_coins_ul":
              serviceDetails.description?.payment?.paymentAmountCoinsUl,
          "description_payment_payment_amount_urgent_coins_ul":
              serviceDetails.description?.payment?.paymentAmountUrgentCoinsUl,
          "description_payment_payment_method":
              serviceDetails.description?.payment?.paymentMethod,
          "description_time_max_execution_time":
              serviceDetails.description?.time?.maxExecutionTime,
          "description_time_max_register_time":
              serviceDetails.description?.time?.maxRegisterTime,
          "description_time_max_wait_time":
              serviceDetails.description?.time?.maxWaitTime,
          "description_recipient_categories":
              serviceDetails.description?.recipientCategories,
          "description_service_reason":
              serviceDetails.description?.serviceReason,
          "description_suspend_reason":
              serviceDetails.description?.suspendReason,
          "description_denial_reason": serviceDetails.description?.denialReason,
          "description_service_result":
              serviceDetails.description?.serviceResult,

          "description_state_duty_payment_account_number":
              serviceDetails.description?.stateDutyPayment?.accountNumber,
          "description_state_duty_payment_tax_codes_tax_code_tir":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeTir,
          "description_state_duty_payment_tax_codes_tax_code_ben":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeBen,
          "description_state_duty_payment_tax_codes_tax_code_ryb":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeRyb,
          "description_state_duty_payment_tax_codes_tax_code_kam":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeKam,
          "description_state_duty_payment_tax_codes_tax_code_dub":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeDub,
          "description_state_duty_payment_tax_codes_tax_code_gri":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeGri,
          "description_state_duty_payment_tax_codes_tax_code_slo":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeSlo,
          "description_state_duty_payment_tax_codes_tax_code_dne":
              serviceDetails
                  .description?.stateDutyPayment?.taxCodes?.taxCodeDne,
          "description_state_duty_payment_account_numbers_account_number":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberDne,
          "description_state_duty_payment_account_numbers_account_number_ben":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberBen,
          "description_state_duty_payment_account_numbers_account_number_ryb":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberRyb,
          "description_state_duty_payment_account_numbers_account_number_kam":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberKam,
          "description_state_duty_payment_account_numbers_account_number_dub":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberDub,
          "description_state_duty_payment_account_numbers_account_number_gri":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberGri,
          "description_state_duty_payment_account_numbers_account_number_slo":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberSlo,
          "description_state_duty_payment_account_numbers_account_number_dne":
              serviceDetails.description?.stateDutyPayment?.accountNumbers
                  ?.accountNumberDne,
          "description_state_duty_payment_article":
              serviceDetails.description?.stateDutyPayment?.article,
          "description_state_duty_payment_incomes_classification":
              serviceDetails
                  .description?.stateDutyPayment?.incomesClassification,
          "description_has_public_service_status":
              serviceDetails.description?.hasPublicServiceStatus,
          "description_need_confirmation":
              serviceDetails.description?.needConfirmation,
          "description_has_electronic_view":
              serviceDetails.description?.hasElectronicView,
          "description_has_electronic_form":
              serviceDetails.description?.hasElectronicForm,
          "description_hide_service": serviceDetails.description?.hideService,

          "extra_appeal_order": serviceDetails.extra?.appealOrder,
          "extra_organizations": serviceDetails.extra?.organizations,
          "extra_rights_and_duties": serviceDetails.extra?.rightsAndDuties,
          "extra_regulations": serviceDetails.extra?.regulations,

          // "access_canUserOrder": serviceDetails.access?.canUserOrder,
          // "access_requireErnValidation": serviceDetails.access?.requireErnValidation,
          // "access_fiz_only": serviceDetails.access?.fizOnly,
          // "access_ur_only": serviceDetails.access?.urOnly,
          "serviceCanBeInvited": serviceDetails.serviceCanBeInvited,
          "step": serviceDetails.step

          // "description_digital_signature_certificate_imprint": serviceDetails.description?.digitalSignature,
          // "documents_apply": serviceDetails.documents?.apply,
          // "documents_result": serviceDetails.documents?.result,
          // "documents_blank": serviceDetails.documents?.blank,
          // "documents_reglament_name": serviceDetails.documents?.reglament?.name,
          // "documents_reglament_file": serviceDetails.documents?.reglament?.file,

          // "contacts_name": serviceDetails.contacts?.name,
          // "contacts_boss": serviceDetails.contacts?.boss,
          // "contacts_address": serviceDetails.contacts?.address,
          // "contacts_phone": serviceDetails.contacts?.phone,
          // "contacts_fax": serviceDetails.contacts?.fax,
          // "contacts_site": serviceDetails.contacts?.site,
          // "contacts_schedule": serviceDetails.contacts?.schedule,
          // "id": serviceDetails.id,
          // "description_receipt_apply_method": serviceDetails.description?.receipt?.applyMethod,
          // "description_payment_payment_amount_coins": serviceDetails.description?.payment?.paymentAmountCoins,
          // "description_payment_payment_amount_urgent_coins": serviceDetails.description?.payment?.paymentAmountUrgentCoins,

          //  "description_state_duty_payment_account_numbers_account_number_dne": serviceDetails.description?.stateDutyPayment?.accountNumbers?.accountNumberDne,
          // "service_information_form_scheme": serviceDetails.serviceInformation?.formScheme,
          // "service_information_rospih_scheme": serviceDetails.serviceInformation?.rospihScheme,
          // "service_information_additional_scheme": serviceDetails.serviceInformation?.additionalScheme,
          // "service_information_service_steps": serviceDetails.serviceInformation?.serviceSteps,
          // "service_information_xml_template": serviceDetails.serviceInformation?.xmlTemplate,

          // this.result,
          // this.blank,
          // this.reglament,
          //   "documents_reglament_name": serviceDetails.documents?.reglamentName,
          //   "documents_reglament_file": serviceDetails.documents?.reglamentFile,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getDetails() async {
    var db = await createDatabase();
    return await db.query(
      "details",
      orderBy: 'id DESC',
      limit: 20,
    );
  }

  static Future<List<Map<String, dynamic>>> getDetailsByID(int id) async {
    var db = await createDatabase();
    return await db.query(
      "details",
      where: 'id',
      orderBy: 'id DESC',
      limit: 20,
    );
  }
}
