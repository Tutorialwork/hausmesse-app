import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _MainPageState();
}

class _MainPageState extends State<StatusPage> {

  bool isActivated = true;

  @override
  void initState() {
    getAlarmStatus();
    super.initState();
  }

  Future<void> getAlarmStatus() async {
    http.Response serverResponse = await http.get(
      Uri.parse(apiUrl + '/status')
    );
    if (serverResponse.body == "0") {
      isActivated = false;
    }
  }

  Future<void> changeAlarmStatus(bool newStatus) async {
    http.Response serverResponse = await http.post(
      Uri.parse(apiUrl + '/changeStatus'),
      body: newStatus ? "1" : "0"
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: isActivated ? Colors.white : Color(0xff292929),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              isActivated = !isActivated;
              changeAlarmStatus(isActivated);
              getAlarmStatus();
              setState(() {

              });
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.1, 1),
                    colors: <Color>[
                      Color(0xff00dbff),
                      Color(0xff7633d9)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(200)
              ),
              child: Icon(Icons.power_settings_new, color: Colors.white, size: 100,),
            ),
          ),
          Text(isActivated ? "ON" : "OFF",
            style: TextStyle(fontSize: 30, color: isActivated ? Colors.black : Colors.white),),
        ],
      ),
    );
  }
}