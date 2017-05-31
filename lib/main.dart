import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting
        // the app, try changing the primarySwatch below to Colors.green
        // and then invoke "hot reload" (press "r" in the console where
        // you ran "flutter run", or press Run > Hot Reload App in IntelliJ).
        // Notice that the counter didn't reset back to zero -- the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final int numTabs = 20;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: numTabs, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> pages = <Widget>[];
    List<Tab> tabs = <Tab>[];
    for (int i = 0; i < numTabs; i++) {
      pages.add(_buildTab(context, i));
      tabs.add(new Tab(text: 'Tab $i'));
    }

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that
        // was created by the App.build method, and use it to set
        // our appbar title.
        title: new Text(widget.title),
        bottom: new TabBar(
          controller: tabController,
          tabs: tabs,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: pages,
      ),
    );
  }

  Widget _buildTab(BuildContext context, int i) {
    return new MyPage(pageNum: i);
  }
}

class MySliverChildDelegate extends SliverChildDelegate {
  MySliverChildDelegate(this.pageNum);
  int pageNum;

  Widget build(BuildContext context, int i) {
    return new ListTile(title: new Text('Page $pageNum ListTile $i'),);
  }

  bool shouldRebuild(MySliverChildDelegate old) {
    return false;
  }
}

class MyPage extends StatefulWidget {
  MyPage({this.pageNum});
  final int pageNum;

  @override
  MyPageState createState() => new MyPageState();
}

class MyPageState extends State<MyPage> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    print('create ScrollController for page: ${widget.pageNum}');
    scrollController = new ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: () async {
      },
      child: new CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          new SliverList(
              delegate: new MySliverChildDelegate(widget.pageNum),
          ),
        ],
      ),
    );
  }
}