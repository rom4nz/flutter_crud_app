import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/pages/insert.dart';
import 'package:flutter_crud_app/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();
  Stream? DataStream;

  getontheload() async {
    DataStream = await DatabaseMethods().getData();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allData() {
    return StreamBuilder(
      stream: DataStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name : " + ds["Name"],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  namecontroller.text = ds["Name"];
                                  agecontroller.text = ds["Age"];
                                  locationcontroller.text = ds["Location"];
                                  editData(ds["Id"]);
                                },
                                child: Icon(Icons.edit, color: Colors.blueGrey),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseMethods().deleteData(ds["Id"]);
                                },
                                child: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          Text(
                            "Age : " + ds["Age"],
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Location : " + ds["Location"],
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Insert()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CRUD",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "App",
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
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(children: [Expanded(child: allData())]),
      ),
    );
  }

  Future editData(String id) => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width: 60.0),
                    Text(
                      "Edit",
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
                SizedBox(height: 30.0),
                Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
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
                    fontSize: 20.0,
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
                    fontSize: 20.0,
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
                      Map<String, dynamic> updateInfo = {
                        "Name": namecontroller.text,
                        "Age": agecontroller.text,
                        "Id": id,
                        "Location": locationcontroller.text,
                      };
                      await DatabaseMethods().updateData(id, updateInfo).then((
                        value,
                      ) {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
