import 'dart:convert';

// Parses a JSON string to create a VerberModel instance
VerberModel userListFromJson(String str) =>
    VerberModel.fromJson(json.decode(str));

// Converts a VerberModel instance to a JSON string
String userListToJson(VerberModel data) => json.encode(data.toJson());

// Represents the model for the Verber data
class VerberModel {
  int page; // Current page number.
  int perPage; // Number of items per page.
  int total; // Total number of items.
  int totalPages; // Total number of pages.
  List<Data> data; // List of user data.
  Support support; // Support information.

  VerberModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  // Creates a VerberModel instance from a JSON map
  factory VerberModel.fromJson(Map<String, dynamic> json) => VerberModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  // Converts a VerberModel instance to a JSON map
  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };

  // Creates a copy of the VerberModel with updated data
  VerberModel copyWith(
      {int? page,
      int? perPage,
      int? total,
      int? totalPages,
      required List<Data> data,
      Support? support}) {
    return VerberModel(
      page: this.page,
      perPage: this.perPage,
      total: this.total,
      totalPages: this.totalPages,
      data: data, // Use the updated data
      support: this.support,
    );
  }
}

// Represents individual user data
class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Creates a Data instance from a JSON map
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  // Converts a Data instance to a JSON map
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

// Represents support information
class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  // Creates a Support instance from a JSON map
  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  // Converts a Support instance to a JSON map
  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
