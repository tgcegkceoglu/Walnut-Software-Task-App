import 'package:flutter/material.dart';

enum ImageConstants{
  logo('logo');

  final String value;
  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value.png';
  Image get toImagePng => Image.asset(toPng);
}