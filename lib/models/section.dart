import 'package:flutter/widgets.dart';
import '../api/sections.dart';

import 'database.dart';

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
    isSaved();
  }

  void isSaved() async {
    saved = await DBHelper().isSectionSaved(this);
  }

  Future<void> fillImage() async {
    url = await new SectionsAPI().getImage(this);
    image = url != null ? Image.network(url, scale: 0.25,) : null;
  }

  int getCountInt() {
    return count != null ? count : 0;
  }

  String getCount() {
    return getCountInt().toString() + " Posts";
  }
}