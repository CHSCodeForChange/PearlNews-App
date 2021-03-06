import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../sections/tag-stories.dart';
import '../../models/colors.dart';
import '../../models/story.dart';
import 'webview.dart';


class Story extends StatelessWidget {
  StoryModel story;

  Story(this.story);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new Webview(story)),
        );
      },

      child: new Card(
        child: new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  story.image == null ? new Container() : story.image,
                  story.isTagNull() ? new Container() : 
                    new Padding(
                      padding: EdgeInsets.only(bottom: story.image == null ? 0.0 : 10.0, left: 15.0),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new TagStories(story.topTag)),
                          );
                        },
                        child: new Chip(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: MyColors.yellow(),
                          label: new AutoSizeText(
                            story.topTag.title,
                            maxLines: 1,
                            style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        )
                      )
                    )
                ],
              ),
              new Padding (
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                child: new Text(
                  story.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25.0, color:Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              new Padding (
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                child: new Text(
                  story.getInfo(),
                  style: TextStyle(fontSize: 16.0, color: Colors.grey)
                )
              ),
              story.isExcerptNull() ? new Container() :
                new Padding (
                  padding: EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: new Text(
                    story.excerpt,
                    style: TextStyle(fontSize: 14.0, color:Colors.black)
                  ), 
                ),
              // new Padding (
              //   padding: EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
              //   child: new Text(
              //     stories.elementAt(index).comments.toString() + " Comments",
              //     style: TextStyle(fontSize: 16.0, color: Colors.black)
              //   )
              // ),
            ],
          ),
        )
      )
    );
  }
}