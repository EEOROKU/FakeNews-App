import 'package:flutter/material.dart';
import 'package:a1_fakenews/news/news.dart';

//Example Code Moves between 2 screens
void main() async{
  var gen = FakeNewsGenerator();
  var newsI = await gen.getNews();
  var news = [];
  var screens = [];
  for (var item in newsI) {
    var secondScreen = SecondScreen(img: item.image,title: item.title,author: item.author,date: '${item.date}', paper: item.body,);
    news.add(secondScreen);
  }
  for (var i = 0; i < news.length; i++){
    var routeName = '/third$i';
    screens.add(routeName);
  }
  runApp(
    MaterialApp(
      onGenerateTitle: (context)=>'Named Routes Demo',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (context) =>  MyApp(newss: news,screens: screens,),
        for (var i = 0; i < screens.length; i++)
          screens[i]: (BuildContext context) => SecondScreen(img: news[i].img, title: news[i].title, author: news[i].author, date: news[i].date, paper: news[i].paper,),
      },
    ),
  );
}


class MyApp extends StatelessWidget {
  var newss;
  var screens;
  MyApp({this.newss, this.screens});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Fake News'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List<Widget>.generate(newss.length, (index) {
                return ChoiceTile(
                  img: newss[index].img, text: newss[index].title, page: screens[index],);
              }
            )
        )
        )
    );
  }
}


class SecondScreen extends StatelessWidget {
  final String? img;
  final String? title;
  final String? author;
  final String? date;
  final String? paper;

  SecondScreen({this.img, this.title, this.author, this.date, this.paper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake News Story'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (img != null) Image.network(img!),
              if (title != null) Text(title!, style: TextStyle(fontSize: 25.0)),
              if (author != null) Text(author!, style: TextStyle(fontSize: 10.0)),
              if (date != null) Text(date!, style: TextStyle(fontSize: 10.0)),
              if (paper != null) Text(paper!),
            ],
          ),
        ),
      ),
    );
  }
}




class ChoiceTile extends StatelessWidget {
  var img;
  final String text;
  final String page;
  ChoiceTile( {required this.img, required this.text, required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Image.network(img),
          title: Text(text),
          onTap: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pushNamed(context, page);

          },
        )
    );
  }
}