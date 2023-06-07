// class Favourite {
//   Content? content;
//
//   Favourite({this.content});
//
//   Favourite.fromJson(Map<String, dynamic> json) {
//     content =
//     json['content'] != null ? new Content.fromJson(json['content']) : null;
//   }
// }
//
// class Content {
//   List<Favorites>? favorites;
//
//   Content({this.favorites});
//
//   Content.fromJson(Map<String, dynamic> json) {
//     if (json['favorites'] != null) {
//       favorites = <Favorites>[];
//       json['favorites'].forEach((v) {
//         favorites!.add(new Favorites.fromJson(v));
//       });
//     }
//   }
// }

class Favorites {
  int? faId;
  int? cuId;
  int? bId;
  String? faCreatedOn;
  String? bName;
  String? bDescription;
  String? bGenre;
  double? bPrice;
  int? aId;

  Favorites(
      {this.faId,
        this.cuId,
        this.bId,
        this.faCreatedOn,
        this.bName,
        this.bDescription,
        this.bGenre,
        this.bPrice,
        this.aId});

  Favorites.fromJson(Map<String, dynamic> json) {
    faId = json['fa_id'];
    cuId = json['cu_id'];
    bId = json['b_id'];
    faCreatedOn = json['fa_created_on']??'';
    bName = json['b_name']??'';
    bDescription = json['b_description']??'';
    bGenre = json['b_genre']??'';
    bPrice = json['b_price']??0.0;
    aId = json['a_id'];
  }
}
