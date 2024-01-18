class SkincareRecResponse {
  final String message;
  final RecResponse response;
  final int status;

  SkincareRecResponse({
    required this.message,
    required this.response,
    required this.status,
  });

  factory SkincareRecResponse.fromJson(Map<String, dynamic> json) {
    return SkincareRecResponse(
      message: json['message'] as String,
      response: RecResponse.fromJson(json['response'] as Map<String, dynamic>),
      status: json['status'] as int,
    );
  }
}

class RecResponse {
  final List<ProductDetail> products;

  RecResponse({
    required this.products,
  });

  factory RecResponse.fromJson(Map<String, dynamic> json) {
    List<ProductDetail> products = [];

    if (json['product_details'] != null) {
      // Handle the case where 'product_details' is not present or null
      products = (json['product_details'] as List<dynamic>)
          .map((item) => ProductDetail.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return RecResponse(
      products: products,
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
