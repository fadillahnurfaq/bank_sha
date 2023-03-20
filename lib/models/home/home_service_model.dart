import 'package:flutter/material.dart';

class HomeServiceModel {
  String? iconUrl, title;
  VoidCallback? onTap;

  HomeServiceModel({
    this.iconUrl,
    this.title,
    this.onTap,
  });
}
