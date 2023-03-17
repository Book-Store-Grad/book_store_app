class LoginModel {
  String? accessToken;
  int? statusCode;
  String? message;
  Content? content;

  LoginModel({this.accessToken, this.statusCode, this.message, this.content});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    statusCode = json['status_code'];
    message = json['message'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  Customer? customer;

  Content({this.customer});

  Content.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? cuId;
  String? cuName;
  String? cuEmail;
  String? cuRole;
  String? cuCreatedOn;

  Customer(
      {this.cuId, this.cuName, this.cuEmail, this.cuRole, this.cuCreatedOn});

  Customer.fromJson(Map<String, dynamic> json) {
    cuId = json['cu_id'];
    cuName = json['cu_name'];
    cuEmail = json['cu_email'];
    cuRole = json['cu_role'];
    cuCreatedOn = json['cu_created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cu_id'] = this.cuId;
    data['cu_name'] = this.cuName;
    data['cu_email'] = this.cuEmail;
    data['cu_role'] = this.cuRole;
    data['cu_created_on'] = this.cuCreatedOn;
    return data;
  }
}