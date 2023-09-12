class Extra {
  String Name;

  Extra({
    required this.Name
  });

  factory Extra.fromJson(Map<String, dynamic> json) {
    return Extra(
      Name: json['Name']
    );
  }
}