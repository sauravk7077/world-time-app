import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name of the UI
  String time; // time in that location
  String flag; // url to asset flag item
  String url; // location URL for api endpoint
  bool isDayTime; // True if it is daytime

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response res =
          await get('https://www.worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(res.body);
      // print(data);

      // get properties from data
      String dateTime = data['utc_datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(
          hours: int.parse(offset.substring(1, 3)),
          minutes: int.parse(offset.substring(4))));

      // Set the time property
      isDayTime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = "Could not get the time";
    }
  }
}
