class SubscriptionPlan {
  final String name;
  final String benefits;
  final double price;
  final String startDate;
  final bool? is_active;

  SubscriptionPlan({
    required this.name,
    required this.benefits,
    required this.price,
    required this.startDate,
    required this.is_active,
  });
}
