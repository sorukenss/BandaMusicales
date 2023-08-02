
import 'package:flutter/material.dart';

class Banda{

  String id;
  String name;
  int votos;

  Banda({
    required this.id,
    required this.name,
    required this.votos,
  });


  factory Banda.fromMap(Map<String, dynamic> obj) => 
  Banda(
    id: obj['id'],
    name: obj['name'],
    votos: obj['votos'],


  );
}