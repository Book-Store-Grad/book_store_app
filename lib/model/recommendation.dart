class Recommendation {
  Content? content;

  Recommendation({this.content});

  Recommendation.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  List<Recommendations>? recommendations;

  Content({this.recommendations});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(new Recommendations.fromJson(v));
      });
    }
  }
}

class Recommendations {
  int? bId;
  String? bName;
  String? bDescription;
  String? bGenre;
  double? bPrice;
  int? aId;
  String? bCreatedOn;

  Recommendations(
      {this.bId,
        this.bName,
        this.bDescription,
        this.bGenre,
        this.bPrice,
        this.aId,
        this.bCreatedOn});

  Recommendations.fromJson(Map<String, dynamic> json) {
    bId = json['b_id']??0;
    bName = json['b_name']??'';
    bDescription = json['b_description']??'';
    bGenre = json['b_genre']??'';
    bPrice = json['b_price']??0;
    aId = json['a_id']??0;
    bCreatedOn = json['b_created_on']??'';
  }
}
