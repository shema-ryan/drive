import './screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  static const String routeName = '/startPage';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser.email;
    final List<Order> ordered =
        Provider.of<OrderCar>(context, listen: true).getOrders;
    final List<Order> _myOrder =
        ordered.where((element) => element.email == email).toList();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RecentBookings.routeName);
                },
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              if (_myOrder.length > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 20,
                    child: Text(_myOrder.length.toString()),
                    constraints: BoxConstraints(
                      maxHeight: 20,
                      maxWidth: 20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        ],
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Drive',
          style: GoogleFonts.mcLaren()
              .copyWith(fontSize: 20, color: Theme.of(context).primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: TextField(
                    onSubmitted: (value) {
                      print('hello this might look fun ');
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[100],
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search))),
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Deals',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'View all>>',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Consumer<Data>(
              builder: (context, data, _) => Container(
                height: size.height * 0.37,
                width: double.infinity,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.listCars.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      width: size.width * 0.51,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  DetailsScreen.routeName,
                                  arguments: <String, Car>{
                                    'selected': data.listCars[index]
                                  });
                            },
                            child: Hero(
                              tag: data.listCars[index].model,
                              child: Image.asset(
                                data.listCars[index].images[0],
                                height: size.height * 0.21,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.010,
                          ),
                          Text(
                            data.listCars[index].model,
                            style: GoogleFonts.aBeeZee().copyWith(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text(
                            data.listCars[index].brand,
                            style: GoogleFonts.aBeeZee().copyWith(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text(
                            data.listCars[index].condition,
                            style: GoogleFonts.aBeeZee().copyWith(
                                fontSize: 13,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AvailableCars.routeName);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Cars',
                            style: GoogleFonts.lato()
                                .copyWith(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text(
                            'Short terms and Long terms',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          //  Color(0xFFDE925C)
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        height: size.height * 0.05,
                        width: size.width * 0.101,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: size.height * 0.013,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Dealers',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'View all>>',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.019,
            ),
            Container(
              height: size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Data.getDealerList.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          Data.getDealerList[index].image,
                          height: size.height * .06,
                        ),
                      ),
                      Text(
                        Data.getDealerList[index].name,
                        style: GoogleFonts.mcLaren().copyWith(
                          fontSize: 17,
                        ),
                      ),
                      Text('${Data.getDealerList[index].offers}')
                    ],
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(5.0),
                  width: size.width * 0.38,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: user.email == 'kamanzishema@gmail.com'
          ? Drawer(
              child: ListView(children: [
                DrawerHeader(
                  child: null,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.jpeg'),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('User Management'),
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('Dashboard'),
                  hoverColor: Colors.blueGrey,
                  leading: Icon(
                    Icons.admin_panel_settings,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text('Car Management'),
                  leading: Icon(
                    Icons.settings_applications,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(RecentBookings.routeName);
                  },
                  title: Text('Bookings'),
                  leading: Icon(
                    Icons.work_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ]),
            )
          : null,
    );
  }
}
