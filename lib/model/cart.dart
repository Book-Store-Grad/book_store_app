class Cart {
  Content? content;

  Cart({this.content});

  Cart.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  List<CartItems>? cartItems;

  Content({this.cartItems});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }
}

class CartItems {
  int? caiId;
  int? bId;
  String? bName;
  String? bPrice;
  String? bGenre;
  String? bDescription;

  CartItems(
      {this.caiId,
        this.bId,
        this.bName,
        this.bPrice,
        this.bGenre,
        this.bDescription});

  CartItems.fromJson(Map<String, dynamic> json) {
    caiId = json['cai_id'];
    bId = json['b_id'];
    bName = json['b_name']??'';
    bPrice = json['b_price']??'';
    bGenre = json['b_genre']??'';
    bDescription = json['b_description']??'';
  }
}
