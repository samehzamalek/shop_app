class FavoritesModel {
    bool? status;
    Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}
class Data {
  int? currentPage;
  List<FavoritesData> data=[];
  String? firstPageUrl;
  int ?from;
  int ?lastPage;
  String? lastPageUrl;
  String? path;
  int ?perPage;
  int ?to;
  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element){data.add(FavoritesData.fromJson(element));});
    // List.generate(data!.length, (index) => FavoritesData.fromJson(json['data']));
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  int? id;
  FavoriteProduct? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoriteProduct.fromJson(json['product']);
  }
}

class FavoriteProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}