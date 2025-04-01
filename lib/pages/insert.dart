import 'package:flutter/material.dart';
import 'package:flutter_crud_app/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Insert extends StatefulWidget {
  const Insert({super.key});

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Insert",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Data",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Age",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: agecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: locationcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String Id = randomAlphaNumeric(10);
                  Map<String, dynamic> dataInfoMap = {
                    "Id": Id,
                    "Name": namecontroller.text,
                    "Age": agecontroller.text,
                    "Location": locationcontroller.text,
                  };
                  await DatabaseMethods().addData(dataInfoMap, Id).then((
                    value,
                  ) {
                    Fluttertoast.showToast(
                      msg: "Data Added Successfully.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
