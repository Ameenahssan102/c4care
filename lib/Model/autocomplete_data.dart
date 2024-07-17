class AutocompleteData {
  String id;
  String name;

  AutocompleteData({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }

  factory AutocompleteData.fromJson(Map<String, dynamic> json) => AutocompleteData(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
