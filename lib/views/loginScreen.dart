import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydro_monitor/styles.dart';
import 'package:hydro_monitor/views/homepage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 1,
            color: Color.fromARGB(255, 7, 15, 43),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Image.asset(
                  'assets/icons/icon.png',
                  width:
                      MediaQuery.of(context).size.width * 0.4, // กำหนดความกว้าง
                  height:
                      MediaQuery.of(context).size.height * 0.4, // กำหนดความสูง
                ),
                Text(
                  "Hydro Monitor",
                  style: fontstyle.dashboardTextStyle(context),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Text(
                  "เข้าสู่ระบบ",
                  style: fontstyleBGwhite.dashboardTextStyle(context),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0), // ปรับขนาดความกว้างช่องกรอก
                  child: TextField(
                    style:
                        TextStyle(color: const Color.fromARGB(255, 7, 15, 43)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 7, 15, 43)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 7, 15, 43)),
                      ),
                      hintText: "username",
                      labelText: "ชื่อผู้ใช้",
                      hintStyle: GoogleFonts.kanit(
                          color: const Color.fromARGB(255, 7, 15, 43)),
                      labelStyle: GoogleFonts.kanit(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 7, 15, 43),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0), // ปรับขนาดความกว้างช่องกรอก
                  child: TextField(
                    style:
                        TextStyle(color: const Color.fromARGB(255, 7, 15, 43)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 7, 15, 43)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 7, 15, 43)),
                      ),
                      hintText: "password",
                      labelText: "รหัสผ่าน",
                      hintStyle: GoogleFonts.kanit(
                          color: const Color.fromARGB(255, 7, 15, 43)),
                      labelStyle: GoogleFonts.kanit(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 7, 15, 43),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => homepage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // รูปร่างเป็นสี่เหลี่ยมเงิน
                    ),
                    backgroundColor:
                        Color.fromARGB(255, 7, 15, 43), // สีน้ำเงิน
                  ),
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: fontstylelist.dashboardTextStyle(context),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "หรือ",
                  style: GoogleFonts.kanit(
                    color: Color.fromARGB(255, 7, 15, 43),
                    fontSize: MediaQuery.of(context).size.width * 0.010,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => homepage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // รูปร่างเป็นสี่เหลี่ยมเงิน
                      ),
                      backgroundColor:
                          Color.fromARGB(255, 7, 15, 43), // สีน้ำเงิน
                    ),
                    child: Text(
                      "เข้าใช้งานแบบไร้ตัวตน",
                      style: fontstylelist.dashboardTextStyle(context),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
