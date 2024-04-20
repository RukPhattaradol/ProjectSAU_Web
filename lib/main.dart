import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydro_monitor/views/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDNkg5dkgRZlV_OVznF6LFSZUscNbP7B4s",
    projectId: "iot-project-sau-15388",
    messagingSenderId: "811369617753",
    appId: "1:811369617753:web:4f83c0b3be396592265448",
    databaseURL: 'https://iot-project-sau-15388-default-rtdb.firebaseio.com',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydro Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: loginPage(),
    );
  }
}

// Column(
//                           children: [
//                             Row(
//                               children: [
//                                 DropdownButton<String>(
//                                   dropdownColor: Colors.black,
//                                   value: _selectedType,
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       _selectedType = newValue!;
//                                     });
//                                   },
//                                   items: <String>[
//                                     'ระดับน้ำ',
//                                     'อุณหภูมิ',
//                                     'ความชื้น',
//                                   ].map<DropdownMenuItem<String>>(
//                                       (String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(
//                                         value,
//                                         style: fontstylegauge
//                                             .dashboardTextStyle(context),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                                 SizedBox(width: 20),
//                                 DropdownButton<String>(
//                                   dropdownColor: Colors.black,
//                                   value: _selectedIot,
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       _selectedIot = newValue!;
//                                     });
//                                   },
//                                   items: <String>[
//                                     'iot1',
//                                     'iot2',
//                                     'iot3',
//                                     'iot4'
//                                   ].map<DropdownMenuItem<String>>(
//                                       (String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(
//                                         value,
//                                         style: fontstylegauge
//                                             .dashboardTextStyle(context),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                                 SizedBox(width: 20),
//                                 ElevatedButton(
//                                   onPressed: () => _selectDate(context, true),
//                                   child: Text(
//                                       'Start Date: ${_startDate.toIso8601String().substring(0, 10)}'),
//                                 ),
//                                 SizedBox(width: 20),
//                                 ElevatedButton(
//                                   onPressed: () => _selectDate(context, false),
//                                   child: Text(
//                                       'End Date: ${_endDate.toIso8601String().substring(0, 10)}'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       startText = _startDate
//                                           .toString()
//                                           .substring(0, 10);
//                                       endText =
//                                           _endDate.toString().substring(0, 10);
//                                       iotText = _selectedIot.substring(3);
//                                       typeDT = _selectedType;
//                                       typeText = _selectedType == 'อุณหภูมิ'
//                                           ? 'tempValue'
//                                           : _selectedType == 'ความชื้น'
//                                               ? 'humValue'
//                                               : _selectedType == 'ระดับน้ำ'
//                                                   ? 'ultraValue'
//                                                   : 'ค่าเริ่มต้นหรือค่าอื่นๆ';
//                                     });
//                                     fetchIotValueHistory();
//                                   },
//                                   child: Text("ค้นหา"),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               "data22",
//                               style: fontstyle.dashboardTextStyle(context),
//                             ),
//                             Container(
//                               child: SingleChildScrollView(
//                                 scrollDirection:
//                                     Axis.vertical, // เปลี่ยนเป็นแนวตั้ง
//                                 child: SingleChildScrollView(
//                                   scrollDirection:
//                                       Axis.horizontal, // เพิ่มการเลื่อนแนวนอน
//                                   child: ConstrainedBox(
//                                     constraints: BoxConstraints(
//                                       minHeight:
//                                           MediaQuery.of(context).size.height *
//                                               0.6,
//                                     ),
//                                     child: DataTable(
//                                       columns: [
//                                         DataColumn(
//                                             label: Text(typeDT,
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                         DataColumn(
//                                             label: Text('เวลา',
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                         DataColumn(
//                                             label: Text('วัน',
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                       ],
//                                       // ในส่วนของการแสดง DataTable
//                                       rows: graphData.map((data) {
//                                         return DataRow(
//                                           cells: [
//                                             DataCell(Text(
//                                                 typeDT == 'อุณหภูมิ'
//                                                     ? data.tempValue
//                                                             .toString() ??
//                                                         "กำลังโหลดข้อมูล"
//                                                     : typeDT == 'ความชื้น'
//                                                         ? data.humValue
//                                                                 .toString() ??
//                                                             "กำลังโหลดข้อมูล"
//                                                         : typeDT == 'ระดับน้ำ'
//                                                             ? data.ultraValue
//                                                                     .toString() ??
//                                                                 "กำลังโหลดข้อมูล"
//                                                             : 'ค่าเริ่มต้นหรือค่าอื่นๆ',
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                             DataCell(Text(data.time ?? '-',
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                             DataCell(Text(data.date ?? '-',
//                                                 style: fonttablestyle
//                                                     .dashboardTextStyle(
//                                                         context))),
//                                           ],
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),