// class SearchModel {
//   Content? content;
//
//   SearchModel({this.content});
//
//   SearchModel.fromJson(Map<String, dynamic> json) {
//     content =
//     json['content'] != null ? new Content.fromJson(json['content']) : null;
//   }
// }
//
// class Content {
//   List<Books>? books;
//
//   Content({this.books});
//
//   Content.fromJson(Map<String, dynamic> json) {
//     if (json['books'] != null) {
//       books = <Books>[];
//       json['books'].forEach((v) {
//         books!.add(new Books.fromJson(v));
//       });
//     }
//   }
// }
//
// class Books {
//   bool? isFree;
//   bool? isOwned;
//   int? bId;
//   String? bName;
//   String? bDescription;
//   String? bGenre;
//   double? bPrice;
//   int? aId;
//   String? bCreatedOn;
//   String? coverImageUrl;
//   bool? isFavorite;
//
//   Books(
//       {this.isFree,
//         this.isOwned,
//         this.bId,
//         this.bName,
//         this.bDescription,
//         this.bGenre,
//         this.bPrice,
//         this.aId,
//         this.bCreatedOn,
//         this.coverImageUrl,
//         this.isFavorite});
//
//   Books.fromJson(Map<String, dynamic> json) {
//     isFree = json['is_free'];
//     isOwned = json['is_owned'];
//     bId = json['b_id'];
//     bName = json['b_name'];
//     bDescription = json['b_description'];
//     bGenre = json['b_genre'];
//     bPrice = json['b_price']??0.0;
//     aId = json['a_id'];
//     bCreatedOn = json['b_created_on'];
//     coverImageUrl = json['cover_image_url'];
//     isFavorite = json['is_favorite'];
//   }
// }
