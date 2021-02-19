import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User userCurrent;

  const Home({Key key, this.userCurrent}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final AuthService _auth = AuthService();

  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  var cardsList = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 7, 0.32)
  ];

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      appBar: AppBar(
        title: Text(
          "TaskCV",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[
          MaterialButton(
            shape: CircleBorder(),
            onPressed: () {
              print('search');
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider('userHienTai.photoUrl'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                      child: Text(
                        "Hello, ",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "Looks like feel good.",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "You have 3 tasks to do today.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  child: Text(
                    "TODAY : JUL 21, 2018",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 250.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          print('${cardsList[position].cardTitle}');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => CustomPage(
                                title: '${cardsList[position].cardTitle}',
                                color: currentColor,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          cardsList[position].icon,
                                          color: appColors[position],
                                        ),
                                        Icon(
                                          Icons.more_vert,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Text(
                                            "${cardsList[position].tasksRemaining} Tasks",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${cardsList[position].cardTitle}",
                                                style:
                                                    TextStyle(fontSize: 28.0),
                                              ),
                                              Text(
                                                '${cardsList[position].taskCompletion * 100}%',
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(
                                            value: cardsList[position]
                                                .taskCompletion,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        onHorizontalDragEnd: (details) {
                          animationController = AnimationController(
                              vsync: this,
                              duration: Duration(milliseconds: 500));
                          curvedAnimation = CurvedAnimation(
                              parent: animationController,
                              curve: Curves.fastOutSlowIn);
                          animationController.addListener(() {
                            setState(() {
                              currentColor =
                                  colorTween.evaluate(curvedAnimation);
                            });
                          });

                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            if (cardIndex > 0) {
                              cardIndex--;
                              colorTween = ColorTween(
                                  begin: currentColor,
                                  end: appColors[cardIndex]);
                            }
                          } else {
                            if (cardIndex < 2) {
                              cardIndex++;
                              colorTween = ColorTween(
                                  begin: currentColor,
                                  end: appColors[cardIndex]);
                            }
                          }
                          setState(() {
                            scrollController.animateTo((cardIndex) * 256.0,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.fastOutSlowIn);
                          });

                          colorTween.animate(curvedAnimation);

                          animationController.forward();
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'dataUser.fullName',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text('userHienTai.email'),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage:
                    CachedNetworkImageProvider('userHienTai.photoUrl'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/drawbg.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text('Viêm dạ dày'),
              trailing: Icon(
                Icons.brightness_1,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => CustomPage(
                      title: 'Viêm dạ dày',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Đau đầu'),
              trailing: Icon(
                Icons.brightness_1,
                color: Colors.yellow,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => CustomPage(
                      title: 'Đau đầu',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Ho'),
              trailing: Icon(
                Icons.brightness_1,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => CustomPage(
                      title: 'Ho',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Đăng xuất'),
              trailing: Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
              onTap: () async {
                await AuthService().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Authenticate(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        foregroundColor: Color(0xffffffff),
        onPressed: () => print('them'),
        tooltip: 'Thêm',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black54,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_active),
              color: Colors.white,
              onPressed: () => print('notification'),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.white,
              onPressed: () => print('calendar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
