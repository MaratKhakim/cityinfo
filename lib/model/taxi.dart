
class Taxi {
  String id;
  String description;
  String phoneNumber;
  String address;
  String price;
  String name;
  String imageUrl;

  Taxi({
    this.description,
    this.phoneNumber,
    this.address,
  });

  Taxi.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['title'];
    description = parsedJson['description'];
    phoneNumber = parsedJson['phone_call'];
    imageUrl = parsedJson['logo'];
    price = parsedJson['price_info'];
  }
}
