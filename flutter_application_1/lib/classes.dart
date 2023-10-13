import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'dart:io';


var baseurl = 'http://89.108.102.117/';


class Category{
  final String title;
  final int pk;
  final List<dynamic> products;
  Category({
    @required this.title = '',
    @required this.products = const [''],
    @required this.pk=0,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
      products:json['productss'],
      pk:json['pk']
    );
  }
}


class Product{
  final String title;
  final String description;
  final bool hit;
  final bool neww;
  final List<dynamic> types;
  final int pk;
  Product({
    @required this.title = '',
    @required this.description='',
    @required this.hit = false,
    @required this.neww = true,
    @required this.types = const [''],
    @required this.pk=0,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description:json['description'],
      hit:json['hit'],
      neww: json['new'],
      types:json['types'],
      pk:json['pk']
    );
  }
}


class ProductToCart{
  final int count;
  final String title;
  final String image_url;
  final int price;
  final String size;
  final int id;
  final List<dynamic> dops;
  ProductToCart({
    @required this.image_url = '',
    @required this.title = '',
    @required this.price = 0,
    @required this.count = 0,
    @required this.size = '0',
    @required this.id = 0,
    @required this.dops = const [''],
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["img"] = image_url;
    data["title"] = title;
    data["price"] = price;
    data["count"] = count;
    data["size"] = size;
    data['pk'] = id;
    data['dops'] = dops;
    return data;
  }
  factory ProductToCart.fromJson(Map<String, dynamic> json) {
    return ProductToCart(
      image_url: json['img'],
      title: json['title'],
      price: int.parse(json['price']),
      count : json['count'],
      id: json['pk'],
      size : json['size'],
      dops : json['dops']

    );
  }
}

class ProductToCartDefault{
  final int count;
  final String title;
  final String image_url;
  final int price;
  final int id;
  final String weight;

  final List<dynamic> dops;
  ProductToCartDefault({
    @required this.image_url = '',
    @required this.title = '',
    @required this.price = 0,
    @required this.count = 0,
    @required this.weight = '',

    @required this.id = 0,
    @required this.dops = const [''],
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["img"] = image_url;
    data["title"] = title;
    data["price"] = price;
    data["count"] = count;
    data["weight"] = weight;

    data['pk'] = id;
    data['dops'] = dops;
    return data;
  }
  factory ProductToCartDefault.fromJson(Map<String, dynamic> json) {
    return ProductToCartDefault(
      image_url: json['img'],
      title: json['title'],
      price: int.parse(json['price']),
      count : json['count'],
      id: json['pk'],
      weight: json['weight'],

      dops : json['dops']
    );
  }
}



class DopClass{

  final String img;
  final String title;
  final int price;
  DopClass({
    @required this.img = '',
    @required this.title = '',
    @required this.price=0,
  });

  factory DopClass.fromJson(Map<String, dynamic> json) {
    return DopClass(
      img: json['img'],
      title: json['title'],
      price: json['price'],
    );
  }
}




class OrderClass{
  final String id;
  final String date;
  final String status;
  final String address;
  final List<dynamic> products;
  final List<dynamic> productsdefault;
  final int price;
  OrderClass({
    @required this.id = '',
    @required this.date = '',
    @required this.status='',
    @required this.address = '',
    @required this.products = const [''],
    @required this.productsdefault = const [''],
    @required this.price=0,
  });
  factory OrderClass.fromJson(Map<String, dynamic> json) {
    return OrderClass(
      id: json['idd'],
      date: json['created_at'],
      status: json['status'],
      address: json['address'],
      products: json['products'],
      productsdefault: json['productsdefault'],
      price: json['price'],
    );
  }
}

class ProductsCart{
  final int pk;
  final Map fields;
  ProductsCart({
    @required this.pk = 0,
    @required this.fields = const {"": ""},
  });
  factory ProductsCart.fromJson(Map<String, dynamic> json) {
    return ProductsCart(
      pk: json['pk'],
      fields: json['fields'],
    );
  }
}




Future<String> getDeviceId() async {
  ClientInformation info = await ClientInformation.fetch();

  return info.deviceId; // EA625164-4XXX-XXXX-XXXXXXXXXXXX

  // return (await ClientInformation.fetch()).deviceId;
}