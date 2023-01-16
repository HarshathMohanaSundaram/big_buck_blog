import 'package:flutter/material.dart';

class CompanyModel {
  final String name;
  final String image;
  final String api;

  CompanyModel({required this.name, required this.image, required this.api});
}

List<CompanyModel> company = [
  CompanyModel(
      name: "Ashok Leyland",
      image: "assets/images/Ashok_Leyland-Logo.wine.png",
      api: "ashok"),
  CompanyModel(
      name: "Cipla", image: "assets/images/cipla-logo.png", api: "cipla"),
  CompanyModel(
      name: "Eicher Motor",
      image: "assets/images/EICHERMOT.NS.png",
      api: "eichermot"),
  CompanyModel(
      name: "Reliance", image: "assets/images/reliance.jpg", api: "reliance"),
  CompanyModel(
      name: "Tata Steel",
      image: "assets/images/Tata-Steel.png",
      api: "tatasteel")
];
