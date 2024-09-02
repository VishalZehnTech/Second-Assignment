import 'dart:convert';

// Function to convert a JSON string into a HomeModel object.
HomeModel userListFromJson(String str) => HomeModel.fromJson(json.decode(str));

// Function to convert a HomeModel object into a JSON string.
String userListToJson(HomeModel data) => json.encode(data.toJson());

// Main model class representing the home data structure.
class HomeModel {
  int page; // Current page number.
  int perPage; // Number of items per page.
  int total; // Total number of items.
  int totalPages; // Total number of pages.
  List<Data> data; // List of user data.
  Support support; // Support information.

  HomeModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  // Factory constructor to create a HomeModel object from JSON.
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  // Method to convert a HomeModel object into a JSON map.
  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };
}

// Class representing the data of individual users.
class Data {
  int id; // User ID.
  String email; // User email address.
  String firstName; // User's first name.
  String lastName; // User's last name.
  String avatar; // URL to the user's avatar image.

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory constructor to create a Data object from JSON.
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  // Method to convert a Data object into a JSON map.
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

// Class representing the support information.
class Support {
  String url; // URL to the support page.
  String text; // Support message text.

  Support({
    required this.url,
    required this.text,
  });

  // Factory constructor to create a Support object from JSON.
  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  // Method to convert a Support object into a JSON map.
  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
