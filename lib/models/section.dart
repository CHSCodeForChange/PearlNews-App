import 'package:flutter/widgets.dart';

import '../api/sections.dart';
import './database.dart';

class SectionModel {
  String title;
  String slug;
  Image image;
  String url;
  int count;
  bool saved;

  SectionModel(String title, String slug, int count) {
    this.title = title.toUpperCase();
    this.slug = slug;
    this.count = count;
  }

  SectionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString().toUpperCase();
    slug = json['slug'];
    count = json['post_count'];
  }

  Future<void> isSaved() async {
    saved = await DBHelper().isSectionSaved(this);
  }

  Future<void> fillImage() async {
    url = await new SectionsAPI().getImage(this);
    image = url != null ? Image.network(url, scale: 0.001,) : null;
  }

  int getCountInt() {
    return count != null ? count : 0;
  }

  String getCount() {
    // if (count < 1000) {
    return getCountInt().toString() + " Posts";
    // } else {
    //   int first_two = (count / 100).round();
    //   double decim = (first_two/10) + 0.1*(first_two%10);
    //   return decim.toString() + "K Posts";
    // }
  }

  String titleEachWordCapped() {
    List<String> words = title.split(" ");
    String result = "";
    for (int i = 0; i < words.length; i++) {
      result += words.elementAt(i).substring(0, 1).toUpperCase() + words.elementAt(i).substring(1).toLowerCase();
      if (i < words.length - 1) {
        result += " ";
      }
    }
    return result;
  }
}