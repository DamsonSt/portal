class ServiceDetails {
  final String name;
  final String priority;
  final String organization;
  final String category;
  // final Map<String, dynamic> description;
  // final Map<String, dynamic> payment;
  // final Map<String, dynamic> time;
  final String recipientCategories;
  // final Map<String, dynamic> serviceReason;

  ServiceDetails({
    required this.name,
    required this.priority,
    required this.organization,
    required this.category,
    // required this.description,
    // required this.payment,
    // required this.time,
    required this.recipientCategories,
    // required this.serviceReason,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      name: json['name'],
      priority: json['priority'],
      organization: json['organization'],
      category: json['category'],

      // description: json['description'],
      // payment: json['payment'],
      // time: json['time'] ,
      recipientCategories: json['recipient_categories'] ?? '',
      // serviceReason: json['service_reason'],
    );
  }
}
