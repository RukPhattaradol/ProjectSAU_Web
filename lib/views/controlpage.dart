import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydro_monitor/styles.dart';
import 'package:hydro_monitor/views/homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydro_monitor/views/loginScreen.dart';

class controlPage extends StatefulWidget {
  const controlPage({super.key});

  @override
  State<controlPage> createState() => _controlPageState();
}

bool switchiot1auto = false;
bool switchiot1manual = false;
bool switchiot2auto = false;
bool switchiot2manual = false;
bool switchiot3auto = false;
bool switchiot3manual = false;
bool switchiot4auto = false;
bool switchiot4manual = false;
List<String> ListNameIoT = ['IoT1', 'IoT2', 'IoT3', 'IoT4'];
String statusiot1 = "offline";
String statusiot2 = "offline";
String statusiot3 = "offline";
String statusiot4 = "offline";
String resultiot1 = "ไม้กั้นปิด";
String resultiot2 = "ไม้กั้นปิด";
String resultiot3 = "ไม้กั้นปิด";
String resultiot4 = "ไม้กั้นปิด";
final combinedStream =
    FirebaseDatabase.instance.reference().child('iotvalue').onValue;

void autoiot1() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier1/auto');
  int valueToSet = switchiot1auto ? 1 : 0;
  reference.set(valueToSet);
}

void manualiot1() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier1/manual');
  int valueToSet = switchiot1manual ? 1 : 0;
  reference.set(valueToSet);
}

void autoiot2() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier2/auto');
  int valueToSet = switchiot2auto ? 1 : 0;
  reference.set(valueToSet);
}

void manualiot2() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier2/manual');
  int valueToSet = switchiot2manual ? 1 : 0;
  reference.set(valueToSet);
}

void autoiot3() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier3/auto');
  int valueToSet = switchiot3auto ? 1 : 0;
  reference.set(valueToSet);
}

void manualiot3() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier3/manual');
  int valueToSet = switchiot3manual ? 1 : 0;
  reference.set(valueToSet);
}

void autoiot4() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier4/auto');
  int valueToSet = switchiot4auto ? 1 : 0;
  reference.set(valueToSet);
}

void manualiot4() {
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('iotBarrier/iotBarrier4/manual');
  int valueToSet = switchiot4manual ? 1 : 0;
  reference.set(valueToSet);
}

class _controlPageState extends State<controlPage> {
  void listenToDatabase() {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('iotBarrier');

    reference.onValue.listen((event) {
      Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          //iot1
          int autoValueiot1 = data['iotBarrier1']['auto'] as int;
          int manualValueiot1 = data['iotBarrier1']['manual'] as int;
          String resultValueiot1 = data['iotBarrier1']['result'] as String;
          resultiot1 = resultValueiot1.toString();
          switchiot1auto = autoValueiot1 == 1 ? true : false;
          switchiot1manual = manualValueiot1 == 1 ? true : false;
          statusiot1 = data['iotBarrier1']['status'] as String;
          //iot2
          int autoValueiot2 = data['iotBarrier2']['auto'] as int;
          int manualValueiot2 = data['iotBarrier2']['manual'] as int;
          String resultValueiot2 = data['iotBarrier2']['result'] as String;
          resultiot2 = resultValueiot2.toString();
          switchiot2auto = autoValueiot2 == 1 ? true : false;
          switchiot2manual = manualValueiot2 == 1 ? true : false;
          statusiot2 = data['iotBarrier2']['status'] as String;
          //iot3
          int autoValueiot3 = data['iotBarrier3']['auto'] as int;
          int manualValueiot3 = data['iotBarrier3']['manual'] as int;
          String resultValueiot3 = data['iotBarrier3']['result'] as String;
          resultiot3 = resultValueiot3.toString();
          switchiot3auto = autoValueiot3 == 1 ? true : false;
          switchiot3manual = manualValueiot3 == 1 ? true : false;
          statusiot3 = data['iotBarrier3']['status'] as String;
          //iot4
          int autoValueiot4 = data['iotBarrier4']['auto'] as int;
          int manualValueiot4 = data['iotBarrier4']['manual'] as int;
          String resultValueiot4 = data['iotBarrier4']['result'] as String;
          resultiot4 = resultValueiot4.toString();
          switchiot4auto = autoValueiot4 == 1 ? true : false;
          switchiot4manual = manualValueiot4 == 1 ? true : false;
          statusiot4 = data['iotBarrier4']['status'] as String;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 15, 43),
      body: StreamBuilder(
          stream: combinedStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            // Extract data from snapshot
            Map<dynamic, dynamic>? iotData =
                snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

            if (iotData == null) {
              return Center(
                child: Text('No data available'),
              );
            }

            // Now you can access each ref's data from iotData
            double hum1 = iotData['iot1']['hum'];
            double temp1 = iotData['iot1']['temp'];
            double ultra1 = iotData['iot1']['ultra'];
            double hum2 = iotData['iot2']['hum'];
            double temp2 = iotData['iot2']['temp'];
            double ultra2 = iotData['iot2']['ultra'];
            double hum3 = iotData['iot3']['hum'];
            double temp3 = iotData['iot3']['temp'];
            double ultra3 = iotData['iot3']['ultra'];
            double hum4 = iotData['iot4']['hum'];
            double temp4 = iotData['iot4']['temp'];
            double ultra4 = iotData['iot4']['ultra'];

            return Center(
              child: Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 26, 85),
                    borderRadius: BorderRadius.circular(
                        10.0), // ตั้งค่า radius ให้กับ Container
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 83, 92, 145)
                            .withOpacity(0.2), // สีของเงา
                        spreadRadius: 2, // รัศมีการกระจายของเงา
                        blurRadius: 7, // รัศมีของเงาที่เบลอ
                        offset: Offset(0, 3), // ตำแหน่งของเงา
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    children: [
                      Image.asset('assets/icons/icon.png'),
                      Text(
                        "Hydro Monitor",
                        style: fontstyle.dashboardTextStyle(context),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => homepage(),
                            ),
                          );
                        },
                        child: Text(
                          'หน้าแรก',
                          style: fontstylenav.dashboardTextStyle(context),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(145, 102, 102, 102),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => controlPage(),
                              ),
                            );
                          },
                          child: Text(
                            'ควบคุมอุปกรณ์',
                            style: fontstylenav.dashboardTextStyle(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => loginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'ออกจากระบบ',
                          style: fontstylenav.dashboardTextStyle(context),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          height: 40, // กำหนดความสูงของรูป
                          width: 40, // กำหนดความกว้างของรูป
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.005,
                      ),
                      Text("ภัทรดล นวนจันทร์",
                          style: fontstylenav.dashboardTextStyle(context)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 26, 85),
                    borderRadius: BorderRadius.circular(
                        10.0), // ตั้งค่า radius ให้กับ Container
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 83, 92, 145)
                            .withOpacity(0.2), // สีของเงา
                        spreadRadius: 2, // รัศมีการกระจายของเงา
                        blurRadius: 7, // รัศมีของเงาที่เบลอ
                        offset: Offset(0, 3), // ตำแหน่งของเงา
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          'ชื่ออุปกรณ์',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'อุณหภูมิ',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'ความชื้น',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'ระดับน้ำ',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'ไม้กั้นทำงานอัติโนมัติ',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'เปิด/ปิด ไม้กั้น',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'สถานะไม้กั้น',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'สถานะอุปกรณ์',
                          style: GoogleFonts.kanit(color: Colors.white),
                        )),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text(
                              ListNameIoT[0],
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              temp1.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              hum1.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              ultra1.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Switch(
                                value: switchiot1auto,
                                onChanged: (value) {
                                  setState(() {
                                    switchiot1auto = value;
                                    autoiot1();
                                    // กำหนดค่าให้ switchiot1manual และเรียกฟังก์ชัน manualiot1 ตามต้องการ
                                    switchiot1manual =
                                        !value; // กำหนดให้ switchiot1manual เป็นค่าตรงข้ามกับ switchiot1auto
                                    if (!value) {
                                      // เช็คว่า switchiot1auto ปิดอยู่หรือไม่
                                      manualiot1(); // เรียกใช้งาน manualiot1 ถ้า switchiot1auto ปิด
                                    }
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Switch(
                                value: switchiot1manual,
                                onChanged: switchiot1auto
                                    ? null
                                    : (value) {
                                        setState(() {
                                          switchiot1manual = value;
                                          manualiot1();
                                        });
                                      },
                              ),
                            ),
                            DataCell(Text(
                              resultiot1,
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: statusiot1 == "online"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  SizedBox(
                                      width:
                                          5), // ระยะห่างระหว่าง Icon กับ Text
                                  Text(
                                    statusiot1,
                                    style:
                                        GoogleFonts.kanit(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(
                              ListNameIoT[1],
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              temp2.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              hum2.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              ultra2.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Switch(
                                value: switchiot2auto,
                                onChanged: (value) {
                                  setState(() {
                                    switchiot2auto = value;
                                    autoiot2();
                                    // กำหนดค่าให้ switchiot2manual และเรียกฟังก์ชัน manualiot2 ตามต้องการ
                                    switchiot2manual =
                                        !value; // กำหนดให้ switchiot2manual เป็นค่าตรงข้ามกับ switchiot2auto
                                    if (!value) {
                                      // เช็คว่า switchiot2auto ปิดอยู่หรือไม่
                                      manualiot2(); // เรียกใช้งาน manualiot2 ถ้า switchiot2auto ปิด
                                    }
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Switch(
                                value: switchiot2manual,
                                onChanged: switchiot2auto
                                    ? null
                                    : (value) {
                                        setState(() {
                                          switchiot2manual = value;
                                          manualiot2();
                                        });
                                      },
                              ),
                            ),
                            DataCell(Text(
                              resultiot2,
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: statusiot2 == "online"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  SizedBox(
                                      width:
                                          5), // ระยะห่างระหว่าง Icon กับ Text
                                  Text(
                                    statusiot2,
                                    style:
                                        GoogleFonts.kanit(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(
                              ListNameIoT[2],
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              temp3.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              hum3.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              ultra3.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Switch(
                                value: switchiot3auto,
                                onChanged: (value) {
                                  setState(() {
                                    switchiot3auto = value;
                                    autoiot3();
                                    // กำหนดค่าให้ switchiot3manual และเรียกฟังก์ชัน manualiot3 ตามต้องการ
                                    switchiot3manual =
                                        !value; // กำหนดให้ switchiot3manual เป็นค่าตรงข้ามกับ switchiot3auto
                                    if (!value) {
                                      // เช็คว่า switchiot3auto ปิดอยู่หรือไม่
                                      manualiot3(); // เรียกใช้งาน manualiot3 ถ้า switchiot3auto ปิด
                                    }
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Switch(
                                value: switchiot3manual,
                                onChanged: switchiot3auto
                                    ? null
                                    : (value) {
                                        setState(() {
                                          switchiot3manual = value;
                                          manualiot3();
                                        });
                                      },
                              ),
                            ),
                            DataCell(Text(
                              resultiot3,
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: statusiot3 == "online"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  SizedBox(
                                      width:
                                          5), // ระยะห่างระหว่าง Icon กับ Text
                                  Text(
                                    statusiot3,
                                    style:
                                        GoogleFonts.kanit(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(
                              ListNameIoT[3],
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              temp4.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              hum4.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(Text(
                              ultra4.toString(),
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Switch(
                                value: switchiot4auto,
                                onChanged: (value) {
                                  setState(() {
                                    switchiot4auto = value;
                                    autoiot4();
                                    switchiot4manual = !value;
                                    if (!value) {
                                      manualiot4();
                                    }
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Switch(
                                value: switchiot4manual,
                                onChanged: switchiot4auto
                                    ? null
                                    : (value) {
                                        setState(() {
                                          switchiot4manual = value;
                                          manualiot4();
                                        });
                                      },
                              ),
                            ),
                            DataCell(Text(
                              resultiot4,
                              style: GoogleFonts.kanit(color: Colors.white),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: statusiot4 == "online"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  SizedBox(
                                      width:
                                          5), // ระยะห่างระหว่าง Icon กับ Text
                                  Text(
                                    statusiot4,
                                    style:
                                        GoogleFonts.kanit(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
