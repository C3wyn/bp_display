class Ingredient {
  String Name;
  bool Selected;
  bool Default;

  Ingredient({
    required this.Name,
    required this.Selected,
    required this.Default
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      Name: json['Name'],
      Selected: json['Selected'],
      Default: json['Default']
    );
  }
}