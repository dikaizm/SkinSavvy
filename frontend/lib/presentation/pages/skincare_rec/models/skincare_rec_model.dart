class SkincareRecResponse {
  final String message;
  final List<ProductDetail> response;
  final int status;

  SkincareRecResponse({
    required this.message,
    required this.response,
    required this.status,
  });

  factory SkincareRecResponse.fromJson(Map<String, dynamic> json) {
    return SkincareRecResponse(
      message: json['message'] as String,
      response: ProductDetail.fromJson(json['response']['Product Details']) as List<ProductDetail>,
      status: json['status'] as int,
    );
  }
}

class ProductDetail {
  final String brand;
  final String name;
  final String price;
  final String url;
  final String img;
  final String quantity;
  final String desc;

  ProductDetail({
    required this.brand,
    required this.name,
    required this.price,
    required this.url,
    required this.img,
    required this.quantity,
    required this.desc,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      brand: json['brand'] as String,
      name: json['name'] as String,
      price: json['Price'] as String,
      url: json['url'] as String,
      img: json['img'] as String,
      quantity: json['quantity'] as String,
      desc: json['Explanation'] as String,
    );
  }
}