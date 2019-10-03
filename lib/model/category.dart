
class Category {

  String id;
  String description;
  String phoneNumber;
  String address;
  String price;
  String name;
  String imageUrl;
  String miniImageUrl;
  String email;
  String workPeriod;
  String website;

  Category.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    name = parsedJson['title'];
    description = parsedJson['description'];
    phoneNumber = parsedJson['phone_call'];
    address = parsedJson['address'];
    imageUrl = parsedJson['logo'];
    miniImageUrl = parsedJson['mini_logo'];
    price = parsedJson['price_info'];
    email = parsedJson['email'];
    workPeriod = parsedJson['work_period'];
    website = parsedJson['website'];
  }
}