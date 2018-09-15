import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './models/story.dart';
import './story.dart';
import './models/colors.dart';
import './home.dart';

class Search extends StatefulWidget {

    @override
    SearchState createState() => new SearchState();

}

class SearchState extends State<Search> {
  final webview = FlutterWebviewPlugin();
  Iterable<StoryModel> stories;
  ScrollController controller = new ScrollController();
 
  String query = "";
  final String domain = 'https://hilite.org';
  int count = 10;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        count += 5;
        getData();
      }
    });

    webview.close();
  }
  

   @override
  void dispose() {
    webview.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<String> getData() async {
    String url = this.domain + '/?json=get_search_results&search=' + query;

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );
    
    if (this.mounted) {
      this.setState(() {
        List raw_stories = json.decode(response.body)['posts'];
        if (raw_stories != null){
          stories = (raw_stories).map((i) => new StoryModel.fromJson(i));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: MyColors.blue(),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (String query) {
                this.query = query;
                getData();
              },

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                hintText: "Search"
              ),
            ),
          ),
          new Expanded (
            child: ListView.builder(
              itemCount: stories == null ? 0 : stories.length + 0,
              padding: new EdgeInsets.all(8.0),
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Story(stories.elementAt(index))),
                      );
                    },

                    child: new Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: new Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              stories.elementAt(index).title,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20.0, color:Colors.black, fontWeight: FontWeight.bold)
                            ),
                            new Padding (
                              padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                              child: new Chip(
                                backgroundColor: MyColors.yellow(),
                                label: new Text(
                                  stories.elementAt(index).date,
                                  style: TextStyle(fontSize: 14.0, color:Colors.white) 
                                ),
                              )
                            ),
                            stories.elementAt(index).image == null ? new Container() : stories.elementAt(index).image,
                            new Padding (
                              padding: EdgeInsets.only(top: 10.0),
                              child: new Text(
                                stories.elementAt(index).excerpt,
                                style: TextStyle(fontSize: 14.0, color:Colors.black)
                              ), 
                            )
                          ],
                        ),
                      )
                    )
                  );
              },
            )
          )
        ],
      )
    );
  }
}