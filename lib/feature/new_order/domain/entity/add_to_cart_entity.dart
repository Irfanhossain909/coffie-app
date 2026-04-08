class SelectedCustomization {
  final String? customizationId;

  /// for single select
  final String? optionId;

  /// for multi select
  final List<String>? optionIds;

  /// for quantity type
  final int? quantity;

  SelectedCustomization({
    this.customizationId,
    this.optionId,
    this.optionIds,
    this.quantity,
  });

  factory SelectedCustomization.fromJson(Map<String, dynamic> json) {
    return SelectedCustomization(
      customizationId: json['customizationId']?.toString(),
      optionId: json['optionId']?.toString(),
      optionIds: (json['optionIds'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    /// ✅ null / empty check for all fields

    if (customizationId != null && customizationId!.isNotEmpty) {
      data["customizationId"] = customizationId;
    }

    if (optionId != null && optionId!.isNotEmpty) {
      data["optionId"] = optionId;
    }

    if (optionIds != null && optionIds!.isNotEmpty) {
      data["optionIds"] = optionIds;
    }

    if (quantity != null && quantity! > 0) {
      data["quantity"] = quantity;
    }

    return data;
  }
}