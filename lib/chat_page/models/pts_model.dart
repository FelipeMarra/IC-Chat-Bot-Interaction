import 'package:flutter/material.dart';

class PtsModel {
  int _gamePts = 0;
  int _socialNetworkPts = 0;
  int _editingPts = 0;
  int _productivityPts = 0;

  void sumGames(int pts) => _gamePts += pts;
  void sumSocialNetwork(int pts) => _socialNetworkPts += pts;
  void sumEditing(int pts) => _editingPts += pts;
  void sumProductivity(int pts) => _productivityPts += pts;

  PtsResult get result {
    int biggestPoints = 0;
    PtsResult result = PtsResult(image: "", category: "", smartphone: "");

    if (_gamePts > biggestPoints) {
      biggestPoints = _gamePts;
      result.category = "Jogos";
      result.smartphone = "Asus Rog Phone 5";
      result.image =
          "https://i.pinimg.com/564x/30/c9/87/30c9876cefd6272329d556497d637070.jpg";
    } else if (_socialNetworkPts > biggestPoints) {
      biggestPoints = _socialNetworkPts;
      result.category = "Redes Sociais";
      result.smartphone = "Apple IPhone 13";
      result.image =
          "https://i.pinimg.com/564x/f6/09/4f/f6094fe5829a8d7f98d2b0734eb76b08.jpg";
    } else if (_editingPts > biggestPoints) {
      biggestPoints = _editingPts;
      result.category = "Edição";
      result.smartphone = "Google Pixel 6";
      result.image =
          "https://i.pinimg.com/564x/7d/48/45/7d4845062acbc6613d927b94ec5a7d51.jpg";
    } else if (_productivityPts > biggestPoints) {
      biggestPoints = _productivityPts;
      result.category = "Produtividade";
      result.smartphone = "Samsung Galaxy S22 Ultra";
      result.image =
          "https://i.pinimg.com/564x/cb/44/c9/cb44c91939908cd7b397d9d3e4e6f3ed.jpg";
    }

    return result;
  }
}

class PtsResult {
  String image;
  String category;
  String smartphone;

  PtsResult({
    required this.image,
    required this.category,
    required this.smartphone,
  });
}
