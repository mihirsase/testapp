class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  });

  factory Address.fromMap(Map<String, dynamic> json) => new Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
      );
}
