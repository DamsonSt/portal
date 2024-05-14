class Service {
  final String id;
  final String name;
  final String serviceResult;
  final String orgId;
  final String catId;
  final int hasElectronicView;
  final String iconLink;
  final String orgName;

  Service({
    required this.id,
    required this.name,
    required this.serviceResult,
    required this.orgId,
    required this.catId,
    required this.hasElectronicView,
    required this.iconLink,
    required this.orgName,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      serviceResult: json['service_result'],
      orgId: json['org_id'],
      catId: json['cat_id'],
      hasElectronicView: json['has_electronic_view'],
      iconLink: json['iconLink'],
      orgName: json['orgName'],
    );
  }
}
