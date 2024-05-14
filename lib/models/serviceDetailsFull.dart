// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ServiceDetails welcomeFromJson(String str) =>
    ServiceDetails.fromJson(json.decode(str));

String welcomeToJson(ServiceDetails data) => json.encode(data.toJson());

class ServiceDetails {
  final int? id;
  final String? name;
  final String? priority;
  final String? tags;
  final String? organization;
  final String? category;
  final Description? description;
  // final Documents? documents;
  // final Contact? contacts;
  final Extra? extra;
  // final ServiceInformation? serviceInformation;
  final Access? access;
  final int? serviceCanBeInvited;
  final String? step;

  ServiceDetails({
    this.id,
    this.name,
    this.priority,
    this.tags,
    this.organization,
    this.category,
    this.description,
    // this.documents,
    // this.contacts,
    this.extra,
    // this.serviceInformation,
    this.access,
    this.serviceCanBeInvited,
    this.step,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        tags: json["tags"],
        organization: json["organization"],
        category: json["category"],
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        // documents: json["documents"] == null ? null : Documents.fromJson(json["documents"]),
        // contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
        // contacts: json["contacts"] == null ? null : Contact.fromJson(json["contacts"]),
        extra: json["extra"] == null ? null : Extra.fromJson(json["extra"]),
        // serviceInformation: json["service_information"] == null ? null : ServiceInformation.fromJson(json["service_information"]),
        access: json["access"] == null ? null : Access.fromJson(json["access"]),
        serviceCanBeInvited: json["serviceCanBeInvited"],
        step: json["step"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "priority": priority,
        "tags": tags,
        "organization": organization,
        "category": category,
        "description": description?.toJson(),
        // "documents": documents?.toJson(),
        // "contacts": contacts?.toJson(),
        "extra": extra?.toJson(),
        // "service_information": serviceInformation?.toJson(),
        "access": access?.toJson(),
        "serviceCanBeInvited": serviceCanBeInvited,
        "step": step,
      };
}

class Access {
  final bool? canUserOrder;
  final bool? requireErnValidation;
  final bool? fizOnly;
  final bool? urOnly;
  // final int? canUserOrder;
  // final int? requireErnValidation;
  // final int? fizOnly;
  // final int? urOnly;

  Access({
    this.canUserOrder,
    this.requireErnValidation,
    this.fizOnly,
    this.urOnly,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        canUserOrder: json["canUserOrder"],
        requireErnValidation: json["requireErnValidation"],
        fizOnly: json["fiz_only"],
        urOnly: json["ur_only"],
      );

  Map<String, dynamic> toJson() => {
        "canUserOrder": canUserOrder,
        "requireErnValidation": requireErnValidation,
        "fiz_only": fizOnly,
        "ur_only": urOnly,
      };
}

class Contact {
  final String? name;
  final String? boss;
  final String? address;
  final String? phone;
  final String? fax;
  final String? site;
  final String? schedule;

  Contact({
    this.name,
    this.boss,
    this.address,
    this.phone,
    this.fax,
    this.site,
    this.schedule,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        boss: json["boss"],
        address: json["address"],
        phone: json["phone"],
        fax: json["fax"],
        site: json["site"],
        schedule: json["schedule"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "boss": boss,
        "address": address,
        "phone": phone,
        "fax": fax,
        "site": site,
        "schedule": schedule,
      };
}

class Description {
  final Receipt? receipt;
  final Payment? payment;
  final Time? time;
  final String? recipientCategories;
  final String? serviceReason;
  final String? suspendReason;
  final String? denialReason;
  final String? serviceResult;
  final DigitalSignature? digitalSignature;
  final StateDutyPayment? stateDutyPayment;
  final int? hasPublicServiceStatus;
  final int? needConfirmation;
  final int? hasElectronicView;
  final int? hasElectronicForm;
  final int? hideService;

  Description({
    this.receipt,
    this.payment,
    this.time,
    this.recipientCategories,
    this.serviceReason,
    this.suspendReason,
    this.denialReason,
    this.serviceResult,
    this.digitalSignature,
    this.stateDutyPayment,
    this.hasPublicServiceStatus,
    this.needConfirmation,
    this.hasElectronicView,
    this.hasElectronicForm,
    this.hideService,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        receipt:
            json["receipt"] == null ? null : Receipt.fromJson(json["receipt"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        recipientCategories: json["recipient_categories"],
        serviceReason: json["service_reason"],
        suspendReason: json["suspend_reason"],
        denialReason: json["denial_reason"],
        serviceResult: json["service_result"],
        digitalSignature: json["digital_signature"] == null
            ? null
            : DigitalSignature.fromJson(json["digital_signature"]),
        stateDutyPayment: json["state_duty_payment"] == null
            ? null
            : StateDutyPayment.fromJson(json["state_duty_payment"]),
        hasPublicServiceStatus: json["has_public_service_status"],
        needConfirmation: json["need_confirmation"],
        hasElectronicView: json["has_electronic_view"],
        hasElectronicForm: json["has_electronic_form"],
        hideService: json["hide_service"],
      );

  Map<String, dynamic> toJson() => {
        "receipt": receipt?.toJson(),
        "payment": payment?.toJson(),
        "time": time?.toJson(),
        "recipient_categories": recipientCategories,
        "service_reason": serviceReason,
        "suspend_reason": suspendReason,
        "denial_reason": denialReason,
        "service_result": serviceResult,
        "digital_signature": digitalSignature?.toJson(),
        "state_duty_payment": stateDutyPayment?.toJson(),
        "has_public_service_status": hasPublicServiceStatus,
        "need_confirmation": needConfirmation,
        "has_electronic_view": hasElectronicView,
        "has_electronic_form": hasElectronicForm,
        "hide_service": hideService,
      };
}

class DigitalSignature {
  final String? certificateImprint;

  DigitalSignature({
    this.certificateImprint,
  });

  factory DigitalSignature.fromJson(Map<String, dynamic> json) =>
      DigitalSignature(
        certificateImprint: json["certificate_imprint"],
      );

  Map<String, dynamic> toJson() => {
        "certificate_imprint": certificateImprint,
      };
}

class Payment {
  final String? paymentType;
  final String? paymentAmount;
  final String? paymentAmountUrgent;
  final String? paymentAmountCoins;
  final String? paymentAmountUrgentCoins;
  final String? paymentAmountUl;
  final String? paymentAmountUrgentUl;
  final String? paymentAmountCoinsUl;
  final String? paymentAmountUrgentCoinsUl;
  final String? paymentMethod;

  Payment({
    this.paymentType,
    this.paymentAmount,
    this.paymentAmountUrgent,
    this.paymentAmountCoins,
    this.paymentAmountUrgentCoins,
    this.paymentAmountUl,
    this.paymentAmountUrgentUl,
    this.paymentAmountCoinsUl,
    this.paymentAmountUrgentCoinsUl,
    this.paymentMethod,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentType: json["payment_type"],
        paymentAmount: json["payment_amount"],
        paymentAmountUrgent: json["payment_amount_urgent"],
        paymentAmountCoins: json["payment_amount_coins"],
        paymentAmountUrgentCoins: json["payment_amount_urgent_coins"],
        paymentAmountUl: json["payment_amount_ul"],
        paymentAmountUrgentUl: json["payment_amount_urgent_ul"],
        paymentAmountCoinsUl: json["payment_amount_coins_ul"],
        paymentAmountUrgentCoinsUl: json["payment_amount_urgent_coins_ul"],
        paymentMethod: json["payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "payment_type": paymentType,
        "payment_amount": paymentAmount,
        "payment_amount_urgent": paymentAmountUrgent,
        "payment_amount_coins": paymentAmountCoins,
        "payment_amount_urgent_coins": paymentAmountUrgentCoins,
        "payment_amount_ul": paymentAmountUl,
        "payment_amount_urgent_ul": paymentAmountUrgentUl,
        "payment_amount_coins_ul": paymentAmountCoinsUl,
        "payment_amount_urgent_coins_ul": paymentAmountUrgentCoinsUl,
        "payment_method": paymentMethod,
      };
}

class Receipt {
  final String? applyMethod;
  final String? getResultMethod;
  final String? applyUrl;

  Receipt({
    this.applyMethod,
    this.getResultMethod,
    this.applyUrl,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        applyMethod: json["apply_method"],
        getResultMethod: json["get_result_method"],
        applyUrl: json["apply_url"],
      );

  Map<String, dynamic> toJson() => {
        "apply_method": applyMethod,
        "get_result_method": getResultMethod,
        "apply_url": applyUrl,
      };
}

class StateDutyPayment {
  final String? accountNumber;
  final TaxCodes? taxCodes;
  final AccountNumbers? accountNumbers;
  final String? article;
  final String? incomesClassification;

  StateDutyPayment({
    this.accountNumber,
    this.taxCodes,
    this.accountNumbers,
    this.article,
    this.incomesClassification,
  });

  factory StateDutyPayment.fromJson(Map<String, dynamic> json) =>
      StateDutyPayment(
        accountNumber: json["account_number"],
        taxCodes: json["tax_codes"] == null
            ? null
            : TaxCodes.fromJson(json["tax_codes"]),
        accountNumbers: json["account_numbers"] == null
            ? null
            : AccountNumbers.fromJson(json["account_numbers"]),
        article: json["article"],
        incomesClassification: json["incomes_classification"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "tax_codes": taxCodes?.toJson(),
        "account_numbers": accountNumbers?.toJson(),
        "article": article,
        "incomes_classification": incomesClassification,
      };
}

class AccountNumbers {
  final String? accountNumber;
  final String? accountNumberBen;
  final String? accountNumberRyb;
  final String? accountNumberKam;
  final String? accountNumberDub;
  final String? accountNumberGri;
  final String? accountNumberSlo;
  final String? accountNumberDne;

  AccountNumbers({
    this.accountNumber,
    this.accountNumberBen,
    this.accountNumberRyb,
    this.accountNumberKam,
    this.accountNumberDub,
    this.accountNumberGri,
    this.accountNumberSlo,
    this.accountNumberDne,
  });

  factory AccountNumbers.fromJson(Map<String, dynamic> json) => AccountNumbers(
        accountNumber: json["account_number"],
        accountNumberBen: json["account_number_ben"],
        accountNumberRyb: json["account_number_ryb"],
        accountNumberKam: json["account_number_kam"],
        accountNumberDub: json["account_number_dub"],
        accountNumberGri: json["account_number_gri"],
        accountNumberSlo: json["account_number_slo"],
        accountNumberDne: json["account_number_dne"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_number_ben": accountNumberBen,
        "account_number_ryb": accountNumberRyb,
        "account_number_kam": accountNumberKam,
        "account_number_dub": accountNumberDub,
        "account_number_gri": accountNumberGri,
        "account_number_slo": accountNumberSlo,
        "account_number_dne": accountNumberDne,
      };
}

class TaxCodes {
  final String? taxCodeTir;
  final String? taxCodeBen;
  final String? taxCodeRyb;
  final String? taxCodeKam;
  final String? taxCodeDub;
  final String? taxCodeGri;
  final String? taxCodeSlo;
  final String? taxCodeDne;

  TaxCodes({
    this.taxCodeTir,
    this.taxCodeBen,
    this.taxCodeRyb,
    this.taxCodeKam,
    this.taxCodeDub,
    this.taxCodeGri,
    this.taxCodeSlo,
    this.taxCodeDne,
  });

  factory TaxCodes.fromJson(Map<String, dynamic> json) => TaxCodes(
        taxCodeTir: json["tax_code_tir"],
        taxCodeBen: json["tax_code_ben"],
        taxCodeRyb: json["tax_code_ryb"],
        taxCodeKam: json["tax_code_kam"],
        taxCodeDub: json["tax_code_dub"],
        taxCodeGri: json["tax_code_gri"],
        taxCodeSlo: json["tax_code_slo"],
        taxCodeDne: json["tax_code_dne"],
      );

  Map<String, dynamic> toJson() => {
        "tax_code_tir": taxCodeTir,
        "tax_code_ben": taxCodeBen,
        "tax_code_ryb": taxCodeRyb,
        "tax_code_kam": taxCodeKam,
        "tax_code_dub": taxCodeDub,
        "tax_code_gri": taxCodeGri,
        "tax_code_slo": taxCodeSlo,
        "tax_code_dne": taxCodeDne,
      };
}

class Time {
  final String? maxExecutionTime;
  final String? maxRegisterTime;
  final String? maxWaitTime;

  Time({
    this.maxExecutionTime,
    this.maxRegisterTime,
    this.maxWaitTime,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        maxExecutionTime: json["max_execution_time"],
        maxRegisterTime: json["max_register_time"],
        maxWaitTime: json["max_wait_time"],
      );

  Map<String, dynamic> toJson() => {
        "max_execution_time": maxExecutionTime,
        "max_register_time": maxRegisterTime,
        "max_wait_time": maxWaitTime,
      };
}

class Documents {
  final Apply? apply;
  final Apply? result;
  final String? blank;
  final Reglament? reglament;

  Documents({
    this.apply,
    this.result,
    this.blank,
    this.reglament,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        // apply: json["apply"] == null ? [] : List<Apply>.from(json["apply"]!.map((x) => Apply.fromJson(x))),
        // result: json["result"] == null ? [] : List<Apply>.from(json["result"]!.map((x) => Apply.fromJson(x))),
        // blank: json["blank"] == null ? [] : List<dynamic>.from(json["blank"]!.map((x) => x)),
        apply: json["apply"] == null ? null : Apply.fromJson(json["apply"]),
        result: json["result"] == null ? null : Apply.fromJson(json["result"]),
        blank: json["blank"],
        reglament: json["reglament"] == null
            ? null
            : Reglament.fromJson(json["reglament"]),
      );

  Map<String, dynamic> toJson() => {
        "apply": apply,
        "result": result,
        "blank": blank,
        "reglament": reglament?.toJson(),
      };
}

class Apply {
  final String? name;
  final String? description;
  final String? count;
  final int? originalOnly;
  final int? required;
  final int? deleteOldFile;
  final FileClass? file;

  Apply({
    this.name,
    this.description,
    this.count,
    this.originalOnly,
    this.required,
    this.deleteOldFile,
    this.file,
  });

  factory Apply.fromJson(Map<String, dynamic> json) => Apply(
        name: json["name"],
        description: json["description"],
        count: json["count"],
        originalOnly: json["original_only"],
        required: json["required"],
        deleteOldFile: json["deleteOldFile"],
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "count": count,
        "original_only": originalOnly,
        "required": required,
        "deleteOldFile": deleteOldFile,
        "file": file?.toJson(),
      };
}

class FileClass {
  final String? file64Atach;
  final String? descriptionatach;

  FileClass({
    this.file64Atach,
    this.descriptionatach,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        file64Atach: json["FILE64ATACH"],
        descriptionatach: json["DESCRIPTIONATACH"],
      );

  Map<String, dynamic> toJson() => {
        "FILE64ATACH": file64Atach,
        "DESCRIPTIONATACH": descriptionatach,
      };
}

class Reglament {
  final String? name;
  final String? file;

  Reglament({
    this.name,
    this.file,
  });

  factory Reglament.fromJson(Map<String, dynamic> json) => Reglament(
        name: json["name"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "file": file,
      };
}

class Extra {
  final String? appealOrder;
  final String? organizations;
  final String? rightsAndDuties;
  final String? regulations;

  Extra({
    this.appealOrder,
    this.organizations,
    this.rightsAndDuties,
    this.regulations,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        appealOrder: json["appeal_order"],
        organizations: json["organizations"],
        rightsAndDuties: json["rights_and_duties"],
        regulations: json["regulations"],
      );

  Map<String, dynamic> toJson() => {
        "appeal_order": appealOrder,
        "organizations": organizations,
        "rights_and_duties": rightsAndDuties,
        "regulations": regulations,
      };
}

class ServiceInformation {
  final String? formScheme;
  final String? rospihScheme;
  final String? additionalScheme;
  final String? serviceSteps;
  final String? xmlTemplate;

  ServiceInformation({
    this.formScheme,
    this.rospihScheme,
    this.additionalScheme,
    this.serviceSteps,
    this.xmlTemplate,
  });

  factory ServiceInformation.fromJson(Map<String, dynamic> json) =>
      ServiceInformation(
        formScheme: json["form_scheme"],
        rospihScheme: json["rospih_scheme"],
        additionalScheme: json["additional_scheme"],
        serviceSteps: json["service_steps"],
        xmlTemplate: json["xml_template"],
      );

  Map<String, dynamic> toJson() => {
        "form_scheme": formScheme,
        "rospih_scheme": rospihScheme,
        "additional_scheme": additionalScheme,
        "service_steps": serviceSteps,
        "xml_template": xmlTemplate,
      };
}
