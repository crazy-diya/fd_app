// To parse this JSON data, do
//
//     final marketNewsResponseModel = marketNewsResponseModelFromJson(jsonString);

import 'dart:convert';

List<MarketNewsResponseModel> marketNewsResponseModelFromJson(String str) => List<MarketNewsResponseModel>.from(json.decode(str).map((x) => MarketNewsResponseModel.fromJson(x)));

String marketNewsResponseModelToJson(List<MarketNewsResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketNewsResponseModel {
  final String? category;
  final int? datetime;
  final String? headline;
  final int? id;
  final String? image;
  final String? related;
  final String? source;
  final String? summary;
  final String? url;

  MarketNewsResponseModel({
    this.category,
    this.datetime,
    this.headline,
    this.id,
    this.image,
    this.related,
    this.source,
    this.summary,
    this.url,
  });

  factory MarketNewsResponseModel.fromJson(Map<String, dynamic> json) => MarketNewsResponseModel(
    category: json["category"],
    datetime: json["datetime"],
    headline: json["headline"],
    id: json["id"],
    image: json["image"],
    related: json["related"],
    source: json["source"],
    summary: json["summary"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "datetime": datetime,
    "headline": headline,
    "id": id,
    "image": image,
    "related": related,
    "source": source,
    "summary": summary,
    "url": url,
  };
}
