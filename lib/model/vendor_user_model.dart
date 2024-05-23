class VendorUserModel {
  final bool approved;

  final String businessName;

  final String cityValue;

  final String stateValue;

  final String countryValue;

  final String emailAddress;

  final String storeImage;

  final String vendorId;

  VendorUserModel(
      {required this.approved,
      required this.businessName,
      required this.cityValue,
      required this.stateValue,
      required this.countryValue,
      required this.emailAddress,
      required this.storeImage,
      required this.vendorId});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          businessName: json['businessName']! as String,
          cityValue: json['cityValue']! as String,
          stateValue: json['stateValue']! as String,
          countryValue: json['countryValue']! as String,
          emailAddress: json['emailAddress']! as String,
          storeImage: json['storeImage']! as String,
          vendorId: json['vendorId']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'cityValue': cityValue,
      'stateValue': stateValue,
      'countryValue': countryValue,
      'emailAddress': emailAddress,
      'storeImage': storeImage,
      'vendorId': vendorId,
    };
  }
}
