class Product {
  String? id;
  String? sku;
  String? name;
  String? brandName;
  String? mainImage;
  List<String>? price;
  List<dynamic>? sizes;
  String? stockStatus;
  String? colour;
  String? description;

  Product(
      {this.id,
      this.sku,
      this.name,
      this.brandName,
      this.colour,
      this.description,
      this.mainImage,
      this.price,
      this.sizes,
     this.stockStatus});

  Product.fromSnapShot(Map dataSnapshot){
    id = dataSnapshot['id'];
    sku = dataSnapshot['SKU'];
    name = dataSnapshot['name'];
    brandName = dataSnapshot['brandName'];
    mainImage = dataSnapshot['mainImage'];
    price = [dataSnapshot['price']['amount'], dataSnapshot['price']['currency']];
    sizes = dataSnapshot['sizes'];
    stockStatus = dataSnapshot['stockStatus'];
    colour = dataSnapshot['colour'];
    description = dataSnapshot['description'];
  }
}
