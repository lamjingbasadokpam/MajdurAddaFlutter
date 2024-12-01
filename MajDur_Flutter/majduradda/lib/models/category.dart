import 'package:flutter/material.dart';
import 'package:majduradda/models/labours.dart';

class Category extends ChangeNotifier{
  final List<Labour> _labour = [
    Labour(
      name: "Labour1",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour2",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour3",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour4",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour5",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour6",
       description: "Labour Description",
         online: true, 
         category: "Category"),

           Labour(
      name: "Labour7",
       description: "Labour Description",
         online: true, 
         category: "Category"),
  ];
  List<Labour> get labour => _labour;
}