import 'package:flutter/material.dart';

class Rating {
  Widget rating(String rate){
    if(double.parse(rate).toInt()==1){
      return const Row(
        children: [
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21)
        ],
      );} else if(double.parse(rate).toInt()==2){
      return const Row(
        children: [
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21)
        ],
      );} else if(double.parse(rate).toInt()==3){
      return const Row(
        children: [
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21,),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21,),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21,),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21,),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21,)
        ],
      );} else if(double.parse(rate).toInt()==4){
      return const Row(
        children: [
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star_border,color: Colors.deepOrange,size: 21)
        ],
      );} else if(double.parse(rate).toInt()==5){
      return const Row(
        children: [
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
          Icon(Icons.star,color: Colors.deepOrangeAccent,size: 21),
        ],
      );} else {
      return const Text("No rating");
    }
  }
}