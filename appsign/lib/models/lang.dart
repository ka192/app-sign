import 'dart:convert';

/*class Lang {
  Abc abc123;
  Abc abc456;

  Lang({
    required this.abc123,
    required this.abc456,
  });

  factory Lang.fromJson(String str) => Lang.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lang.fromMap(Map<String, dynamic> json) => Lang(
        abc123: Abc.fromMap(json["abc123"]),
        abc456: Abc.fromMap(json["abc456"]),
      );

  Map<String, dynamic> toMap() => {
        "abc123": abc123.toMap(),
        "abc456": abc456.toMap(),
      };
}*/

//class Abc {
class Lang {
  String letter;
  String name;
  String? picture;
  String? id;

  Lang({required this.letter, required this.name, this.picture, this.id});

  factory Lang.fromJson(String str) => Lang.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lang.fromMap(Map<String, dynamic> json) => Lang(
        letter: json["letter"],
        name: json["name"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "letter": letter,
        "name": name,
        "picture": picture,
      };

  Lang copy() => Lang(
        letter: letter,
        name: name,
        picture: picture,
        id: id,
      );
}
