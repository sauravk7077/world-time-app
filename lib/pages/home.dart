import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    // Set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime']
        ? Color.fromRGBO(255, 243, 243, 1)
        : Color.fromARGB(255, 1, 1, 55);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      if (result != null) {
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDaytime': result['isDaytime'],
                            'flag': result['flag']
                          };
                        });
                      }
                    },
                    icon: Icon(Icons.edit_location),
                    label: Text("Edit Location")),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(data['location'],
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 2,
                            color: Colors.white))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 20),
                Text(data['time'],
                    style: TextStyle(fontSize: 66, color: Colors.white))
              ],
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
