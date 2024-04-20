import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydro_monitor/models/forum.dart';
import 'package:hydro_monitor/models/iothistory.dart';
import 'package:hydro_monitor/services/call_api.dart';
import 'package:hydro_monitor/styles.dart';
import 'package:hydro_monitor/views/controlpage.dart';
import 'package:hydro_monitor/views/loginScreen.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

final ref = FirebaseDatabase.instance.ref("iotvalue/iot1");
final ref2 = FirebaseDatabase.instance.ref("iotvalue/iot2");
final ref3 = FirebaseDatabase.instance.ref("iotvalue/iot3");
final ref4 = FirebaseDatabase.instance.ref("iotvalue/iot4");
final combinedStream =
    FirebaseDatabase.instance.reference().child('iotvalue').onValue;
List<forum> forumData = [];
List<iotvaluehistory> graphData = [];
// final Completer<GoogleMapController> _controller =
//     Completer<GoogleMapController>();

class _homepageState extends State<homepage> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02b39a),
  ];
  bool showAvg = false;
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  String _selectedIot = 'iot1';
  String _selectedType = 'อุณหภูมิ';
  String typeText = 'tempValue';
  String typeDT = 'อุณหภูมิ';
  String iotText = '1';
  String startText =
      DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);
  String endText = DateTime.now().toString().substring(0, 10);
  DateTime _startDate = DateTime.now().subtract(Duration(days: 1));
  DateTime _endDate = DateTime.now();

  void _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != (isStart ? _startDate : _endDate)) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> fetchIotValueHistory() async {
    iotvaluehistory IotValueHistory = iotvaluehistory(
        idIot: iotText,
        dateStart: startText,
        dateEnd: endText,
        valueText: typeText);

    try {
      //print(typeText);
      final List<iotvaluehistory> data =
          await CallApi.getGraph(IotValueHistory);
      setState(() {
        graphData = data;
      });
      //print(graphData);
    } catch (error) {
      print('Error fetching IoT value history: $error');
    }
  }

  Future<void> _fetchForum() async {
    try {
      final List<forum> data = await CallApi.GetForum(forum());
      setState(() {
        forumData = data;
        forumData.sort((a, b) => b.dateForum!.compareTo(a.dateForum!));
      });
      print(forumData);
    } catch (e) {
      print('Error fetching forum: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchForum();
    fetchIotValueHistory();
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
            child: Column(
              children: [
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
                                builder: (context) => homepage(),
                              ),
                            );
                          },
                          child: Text(
                            'หน้าแรก',
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
                              builder: (context) => controlPage(),
                            ),
                          );
                        },
                        child: Text(
                          'ควบคุมอุปกรณ์',
                          style: fontstylenav.dashboardTextStyle(context),
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
                        width: MediaQuery.of(context).size.width * 0.35,
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
                //ชิดซ้าย
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    children: [
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
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.74,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton<String>(
                                  dropdownColor: Colors.black,
                                  value: _selectedType,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedType = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'ระดับน้ำ',
                                    'อุณหภูมิ',
                                    'ความชื้น',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: fontstylegauge
                                            .dashboardTextStyle(context),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(width: 20),
                                DropdownButton<String>(
                                  dropdownColor: Colors.black,
                                  value: _selectedIot,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedIot = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'iot1',
                                    'iot2',
                                    'iot3',
                                    'iot4'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: fontstylegauge
                                            .dashboardTextStyle(context),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context, true),
                                  child: Text(
                                      'Start Date: ${_startDate.toIso8601String().substring(0, 10)}'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context, false),
                                  child: Text(
                                      'End Date: ${_endDate.toIso8601String().substring(0, 10)}'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      startText = _startDate
                                          .toString()
                                          .substring(0, 10);
                                      endText =
                                          _endDate.toString().substring(0, 10);
                                      iotText = _selectedIot.substring(3);
                                      typeDT = _selectedType;
                                      typeText = _selectedType == 'อุณหภูมิ'
                                          ? 'tempValue'
                                          : _selectedType == 'ความชื้น'
                                              ? 'humValue'
                                              : _selectedType == 'ระดับน้ำ'
                                                  ? 'ultraValue'
                                                  : 'ค่าเริ่มต้นหรือค่าอื่นๆ';
                                    });
                                    fetchIotValueHistory();
                                  },
                                  child: Text("ค้นหา"),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  //กราฟ
                                  height: MediaQuery.of(context).size.height *
                                      0.390, //449
                                  width: MediaQuery.of(context).size.width *
                                      0.54, //3
                                  child: LineChart(
                                    LineChartData(
                                      minX: 0,
                                      maxX: 50,
                                      minY: 0,
                                      maxY: 50,
                                      gridData: FlGridData(
                                        show: true,
                                        getDrawingHorizontalLine: (value) {
                                          return FlLine(
                                            color: const Color(0xff37434d),
                                            strokeWidth: 1,
                                          );
                                        },
                                        drawVerticalLine: true,
                                        getDrawingVerticalLine: (value) {
                                          return FlLine(
                                            color: const Color(0xff37434d),
                                            strokeWidth: 1,
                                          );
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 250, 250, 250),
                                            width: 1),
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 30,
                                            interval: 1,
                                            getTitlesWidget: bottomTitleWidgets,
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            interval: 1,
                                            getTitlesWidget: leftTitleWidgets,
                                            reservedSize: 42,
                                          ),
                                        ),
                                      ),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: [
                                            FlSpot(0, 3),
                                            FlSpot(5, 2),
                                            FlSpot(10, 5),
                                            FlSpot(15, 2.5),
                                            FlSpot(20, 4),
                                            FlSpot(25, 3),
                                            FlSpot(35, 2),
                                            FlSpot(40, 7),
                                            FlSpot(45, 1),
                                            FlSpot(50, 4),
                                          ],
                                          isCurved: true,
                                          gradient: LinearGradient(
                                            colors: gradientColors,
                                          ),
                                          barWidth: 5,
                                          dotData: FlDotData(show: false),
                                          belowBarData: BarAreaData(
                                            show: true,
                                            gradient: LinearGradient(
                                              colors: gradientColors
                                                  .map((color) =>
                                                      color.withOpacity(0.3))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.430,
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  child: SingleChildScrollView(
                                    scrollDirection:
                                        Axis.vertical, // เปลี่ยนเป็นแนวตั้ง
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis
                                          .horizontal, // เพิ่มการเลื่อนแนวนอน
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                        ),
                                        child: DataTable(
                                          columns: [
                                            DataColumn(
                                                label: Text(typeDT,
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                            DataColumn(
                                                label: Text('เวลา',
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                            DataColumn(
                                                label: Text('วัน',
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                          ],
                                          // ในส่วนของการแสดง DataTable
                                          rows: graphData.map((data) {
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(
                                                    typeDT == 'อุณหภูมิ'
                                                        ? data.tempValue
                                                                .toString() ??
                                                            "กำลังโหลดข้อมูล"
                                                        : typeDT == 'ความชื้น'
                                                            ? data.humValue
                                                                    .toString() ??
                                                                "กำลังโหลดข้อมูล"
                                                            : typeDT ==
                                                                    'ระดับน้ำ'
                                                                ? data.ultraValue
                                                                        .toString() ??
                                                                    "กำลังโหลดข้อมูล"
                                                                : 'ค่าเริ่มต้นหรือค่าอื่นๆ',
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                                DataCell(Text(data.time ?? '-',
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                                DataCell(Text(data.date ?? '-',
                                                    style: fonttablestyle
                                                        .dashboardTextStyle(
                                                            context))),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 27, 26, 85),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 83, 92, 145)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                Text(
                                  "Forum",
                                  style: fontstyle.dashboardTextStyle(context),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: forumData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        forumData[index].head.toString(),
                                        style: fontstylelist
                                            .dashboardTextStyle(context),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                forumData[index].detail != null
                                                    ? forumData[index]
                                                        .detail
                                                        .toString()
                                                    : '-',
                                                style: fontstylelist
                                                    .dashboardTextStyle(
                                                        context),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'เวลา : ${forumData[index].timeForum ?? '-'}',
                                            style: fontstylelist
                                                .dashboardTextStyle(context),
                                          ),
                                          Text(
                                            'วัน : ${forumData[index].dateForum ?? '-'}',
                                            style: fontstylelist
                                                .dashboardTextStyle(context),
                                          ),
                                          Text(
                                            'โดย : ${forumData[index].userFullname ?? '-'}',
                                            style: fontstylelist
                                                .dashboardTextStyle(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    children: [
                      DefaultTabController(
                        length: 4, // จำนวน tabs
                        child: Container(
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
                          // ความสูงและความกว้างควรถูกกำหนดให้เหมาะสมกับที่คุณต้องการแสดงผล
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.74,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                labelColor:
                                    Colors.white, // สีของ label ที่เลือก
                                unselectedLabelColor:
                                    Colors.grey, // สีของ label ที่ไม่ได้เลือก
                                labelStyle: TextStyle(
                                    fontSize: 16.0), // สไตล์ของ label ที่เลือก
                                unselectedLabelStyle: TextStyle(
                                    fontSize:
                                        14.0), // สไตล์ของ label ที่ไม่ได้เลือก
                                tabs: [
                                  Tab(text: "อุปกรณ์ที่1"),
                                  Tab(text: "อุปกรณ์ที่2"),
                                  Tab(text: "อุปกรณ์ที่3"),
                                  Tab(text: "อุปกรณ์ที่4"),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    WidgetForTab1(
                                      temperature: temp1,
                                      humidity: hum1,
                                      waterLevel: ultra1,
                                    ),
                                    WidgetForTab2(
                                      temperature: temp2,
                                      humidity: hum2,
                                      waterLevel: ultra2,
                                    ),
                                    WidgetForTab3(
                                      temperature: temp3,
                                      humidity: hum3,
                                      waterLevel: ultra3,
                                    ),
                                    WidgetForTab4(
                                      temperature: temp4,
                                      humidity: hum4,
                                      waterLevel: ultra4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 27, 26, 85),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 83, 92, 145)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height *
                            0.3, // 30% ของความสูงหน้าจอ
                        width: MediaQuery.of(context).size.width *
                            0.2, // 90% ของความกว้างหน้าจอ
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact",
                                style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.015,
                                ),
                              ),
                              Text(
                                "Name : ภัทรดล นวนจันทร์",
                                style: fontstylecontact
                                    .dashboardTextStyle(context),
                              ),
                              Text(
                                "Email : s6419c10006@sau.ac.th",
                                style: fontstylecontact
                                    .dashboardTextStyle(context),
                              ),
                              Text(
                                "Tel : 081-234-5678",
                                style: fontstylecontact
                                    .dashboardTextStyle(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WidgetForTab1 extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double waterLevel;

  const WidgetForTab1({
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrettyGauge(
            minValue: 0,
            maxValue: 50,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('เย็น', 35, Color.fromARGB(255, 36, 116, 255)),
              GaugeSegment('ร้อน', 15, Colors.red),
            ],
            currentValue: temperature,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$temperature°C',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'อุณหภูมิ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 100,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 33, Color.fromARGB(255, 255, 255, 255)),
              GaugeSegment('กลาง', 33, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 34, Colors.red),
            ],
            currentValue: humidity,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$humidity%',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ความชื้น',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 300,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 100, Color.fromARGB(255, 1, 218, 34)),
              GaugeSegment('กลาง', 100, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 100, Colors.red),
            ],
            currentValue: waterLevel,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$waterLevel CM',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ระดับน้ำ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetForTab2 extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double waterLevel;

  const WidgetForTab2({
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrettyGauge(
            minValue: 0,
            maxValue: 50,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('เย็น', 35, Color.fromARGB(255, 36, 116, 255)),
              GaugeSegment('ร้อน', 15, Colors.red),
            ],
            currentValue: temperature,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$temperature°C',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'อุณหภูมิ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 100,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 33, Color.fromARGB(255, 255, 255, 255)),
              GaugeSegment('กลาง', 33, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 34, Colors.red),
            ],
            currentValue: humidity,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$humidity%',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ความชื้น',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 300,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 100, Color.fromARGB(255, 1, 218, 34)),
              GaugeSegment('กลาง', 100, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 100, Colors.red),
            ],
            currentValue: waterLevel,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$waterLevel CM',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ระดับน้ำ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetForTab3 extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double waterLevel;

  const WidgetForTab3({
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrettyGauge(
            minValue: 0,
            maxValue: 50,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('เย็น', 35, Color.fromARGB(255, 36, 116, 255)),
              GaugeSegment('ร้อน', 15, Colors.red),
            ],
            currentValue: temperature,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$temperature°C',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'อุณหภูมิ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 100,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 33, Color.fromARGB(255, 255, 255, 255)),
              GaugeSegment('กลาง', 33, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 34, Colors.red),
            ],
            currentValue: humidity,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$humidity%',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ความชื้น',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 300,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 100, Color.fromARGB(255, 1, 218, 34)),
              GaugeSegment('กลาง', 100, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 100, Colors.red),
            ],
            currentValue: waterLevel,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$waterLevel CM',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ระดับน้ำ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetForTab4 extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double waterLevel;

  const WidgetForTab4({
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrettyGauge(
            minValue: 0,
            maxValue: 50,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('เย็น', 35, Color.fromARGB(255, 36, 116, 255)),
              GaugeSegment('ร้อน', 15, Colors.red),
            ],
            currentValue: temperature,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$temperature°C',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'อุณหภูมิ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 100,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 33, Color.fromARGB(255, 255, 255, 255)),
              GaugeSegment('กลาง', 33, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 34, Colors.red),
            ],
            currentValue: humidity,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$humidity%',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ความชื้น',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ), // Adjust spacing as needed
          PrettyGauge(
            minValue: 0,
            maxValue: 300,
            gaugeSize: MediaQuery.of(context).size.width * 0.1,
            segments: [
              GaugeSegment('น้อย', 100, Color.fromARGB(255, 1, 218, 34)),
              GaugeSegment('กลาง', 100, Color.fromARGB(255, 246, 255, 114)),
              GaugeSegment('มาก', 100, Colors.red),
            ],
            currentValue: waterLevel,
            showMarkers: true,
            displayWidget: Column(
              children: [
                Text(
                  '$waterLevel CM',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
                Text(
                  'ระดับน้ำ',
                  style: fontstylegauge.dashboardTextStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white,
  );
  Widget text;
  switch (value.toInt()) {
    case 10:
      text = const Text('MAR', style: style);
      break;
    case 20:
      text = const Text('JUN', style: style);
      break;
    case 30:
      text = const Text('SEP', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 10:
      text = '10';
      break;
    case 30:
      text = '30';
      break;
    case 50:
      text = '50';
      break;
    default:
      return Container();
  }

  return Text(text,
      style: GoogleFonts.kanit(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      textAlign: TextAlign.left);
}

// GoogleMap(
//mapType: MapType.hybrid,
//initialCameraPosition: _kGooglePlex,
//onMapCreated: (GoogleMapController controller) {
//_controller.complete(controller);
//},
//),