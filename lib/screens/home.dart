import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:Alzeheimer/data/model_user.dart';
import 'package:Alzeheimer/data/user.dart';
import 'package:Alzeheimer/screens/adminInfo.dart';
import 'package:Alzeheimer/screens/patientInfo/patientInfo.dart';
import 'package:Alzeheimer/screens/signUp.dart';
import 'package:Alzeheimer/screens/signin.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:Alzeheimer/utility/signout_process.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Alzeheimer/screens/assignActivity/patientList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String  nameUser, nameUser2;
  String firstName,
      lastName,
      password,
      confirmPassword,
      gender,
      dateOfBirth,
      department,
      bloodType,
      address,
      email,
      img;
  //1080 x 1920 420dpi

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userPreferences();
  }

  Future<Null> userPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('FirstName');
      lastName = preferences.getString('LastName');
      department = preferences.getString('Department');
      dateOfBirth = preferences.getString('DateOfBirth');
      gender = preferences.getString('Gender');
      bloodType = preferences.getString('BloodType');
      address = preferences.getString('Address');
      img = preferences.getString('Img');
      email = preferences.getString('Email');
      print('Nameuser = $nameUser');
      print('Nameuser = $nameUser2');
      print('Gender = $gender');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyStyle().txt16Bold('หน้าหลัก'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      drawer: showDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            MyStyle().mySizeboxh24(),
            emergencyCircle(),
            MyStyle().mySizeboxh24(),
            Row(
              children: [
                Expanded(
                  child: space(),
                  flex: 2,
                ),
                Column(
                  children: [
                    trackingPatient(),
                    MyStyle().freeSizebox(0, 12),
                    MyStyle().txt16BoldMain('ติดตามผู้ป่วย'),
                  ],
                ),
                Expanded(
                  child: space(),
                  flex: 2,
                ),
                Column(
                  children: [
                    patientHistory(),
                    MyStyle().freeSizebox(0, 12),
                    MyStyle().txt16BoldMain('ประวัติผู้ป่วย'),
                  ],
                ),
                Expanded(
                  child: space(),
                  flex: 2,
                )
              ],
            ),
            MyStyle().mySizeboxh24(),
            //MyStyle().mySizeboxh24(),
            Row(
              children: [
                Expanded(
                  child: space(),
                  flex: 2,
                ),
                Column(
                  children: [
                    assignActivity(),
                    MyStyle().freeSizebox(0, 12),
                    MyStyle().txt16BoldMain('''บันทึกกิจกรรมผู้ป่วย'''),
                  ],
                ),
                Expanded(
                  child: space(),
                  flex: 2,
                ),
                Column(
                  children: [
                    hospitalList(),
                    MyStyle().freeSizebox(0, 12),
                    MyStyle().txt16BoldMain('รายชื่อรพ.'),
                  ],
                ),
                Expanded(
                  child: space(),
                  flex: 3,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emergencyCircle() {
    return GestureDetector(
      onTap: (){
       
launch("tel://+66869086116");
 print('test call phone6');
      },
      child: Container(
        width: 220,
        height: 220,
        child: Image.asset(('images/emergency_logo.png')),
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          // image: DecorationImage(
          //     //image: ,
          //     fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget space() {
    return Container(
      //margin: const EdgeInsets.only(left: 40),
      //color: Colors.black,
      height: 100,
      //width: 50,
    );
  }

  Widget trackingPatient() {
    return Container(
      //margin: const EdgeInsets.only(left: 65, right: 65),
      height: 106.0,
      width: 101.0,
      child: new Center(
        widthFactor: 58,
        heightFactor: 64,
        child: new Image.asset(
          'images/trackingPatient.png',
          width: 58,
          height: 64,
        ),
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(35.0),
      ),
    );
  }

  Widget patientHistory() {
    return GestureDetector(
      child: Container(
        //margin: const EdgeInsets.only(right: 65),
        width: 106,
        height: 101,
        child: new Center(
          widthFactor: 58,
          heightFactor: 64,
          child: new Image.asset(
            'images/patientHistory.png',
            width: 58,
            height: 64,
          ),
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(35.0),
        ),
      ),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => PatientInfo()); //วิธีเชื่อมหน้า
        Navigator.push(context, route);
      },
    );
  }

  Widget assignActivity() {
    return GestureDetector(
      onTap: (){
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => PatientList()); //วิธีเชื่อมหน้า
        Navigator.push(context, route);
      },
      child: Container(
        //margin: const EdgeInsets.only(left: 65, right: 65),
        width: 106,
        height: 101,
        child: new Center(
          widthFactor: 58,
          heightFactor: 64,
          child: new Image.asset(
            'images/assignActivity.png',
            width: 58,
            height: 64,
          ),
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(35.0),
        ),
      ),
    );
  }

  Widget hospitalList() {
    return Container(
      //margin: const EdgeInsets.only(right: 65),
      width: 106,
      height: 101,
      child: new Center(
        widthFactor: 58,
        heightFactor: 64,
        child: new Image.asset(
          'images/hospitalList.png',
          width: 58,
          height: 64,
        ),
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(35.0),
      ),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          // children: <Widget>[showHeadDrawer(),userInfo(), signUpMenu(),signOut(),
          // ],
          children: <Widget>[
            SizedBox(
              height: 300,
              child: DrawerHeader(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(children: <Widget>[
                  Align(
                    heightFactor: 1.5,
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.asset(
                        'images/middle_age_man.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: CircleAvatar(
                    //   radius: (50),
                    //   backgroundColor: Colors.white,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(50),
                    //     child: Image.asset("images/middle_age_man.png"),
                    //   ),
                    // ),
                  ),
                  Align(
                      heightFactor: 0,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username : $nameUser',
                        style: TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: 'Prompt'),
                      ),
                    ),
                     Align(
                      heightFactor: 1.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email: $email',
                        style: TextStyle(color: Colors.white, fontSize: 20.0,fontFamily: 'Prompt'),
                      ),
                    ),
                ]),
              ),
            ),
            userInfo(),
            patientList2(),
            Padding(
              padding: const EdgeInsets.only(top: 350,left: 60),
              child: signOut(),
            ),
          ],
        ),
      );

  ListTile signOut() => ListTile(
        leading: Image.asset(
          'images/exit.png',
          height: 24,
          width: 24,
        ),
        title: MyStyle().txt16BoldB('ออกจากระบบ'),
        onTap: ()=> signOutProcess(),
        // onTap: () {
        //   Navigator.pop(
        //       context); // ลูกศรกลับ แก้ปัญหาเรื่องตัว Drawer ไม่หดกลับ
        //   MaterialPageRoute route =
        //       MaterialPageRoute(builder: (value) => SignIn()); //วิธีเชื่อมหน้า
        //   Navigator.push(context, route);
        // },
      );

  ListTile userInfo() => ListTile(
        leading: Image.asset(
          'images/pencil.png',
          height: 24,
          width: 24,
        ),
        title: MyStyle().txt16BoldB('ข้อมูลผู้ใช้'),
        onTap: () {
          Navigator.pop(
              context); // ลูกศรกลับ แก้ปัญหาเรื่องตัว Drawer ไม่หดกลับ
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => AdminInfo()); //วิธีเชื่อมหน้า
          Navigator.push(context, route);
          }
      );

  // Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('LastName',userModel.lastName);
  //   preferences.setString('FirstName',userModel.firstName);
  //   preferences.setString('Department',userModel.department);
  //   preferences.setString('DateOfBirth',userModel.dateOfBirth);
  //   preferences.setString('Gender',userModel.gender);
  //   preferences.setString('BloodType',userModel.bloodType);
  //   preferences.setString('Address',userModel.address);
  // }

  //   MaterialPageRoute route = MaterialPageRoute (builder: (context) => myWidget,);
  //   Navigator.pushAndRemoveUntil(context,route,(route)=>false);
  // }
  // Future<Null> fetchUser() async{
  //   String url = 'http://restaurant2019.com/htdocs/checkAuthen.php?isAdd=true&Email=$email';
  //   try {
  //     Response response = await Dio().get(url);
  //     print('res = $response');

  //     var result = json.decode(response.data);//ตัวแปร var คือไม่รู้ว่าได้ค่ามาเป็นอะไร
  //     print('result = $result');

  //     for(var map in result){
  //       UserModel userModel = UserModel.fromJson(map);
  //         routeToService(AdminInfo(),userModel);
  //         // String chooseType = userModel.chooseType;
  //         //   if(chooseType == 'User'){
  //         //     routeToService(MainUser(),userModel);
  //         //   }else if(chooseType == 'Shop'){
  //         //     routeToService(MainShop(),userModel);
  //         //   }else if(chooseType == 'Rider'){
  //         //     routeToService(MainRider(),userModel);
  //         //   }else{
  //         //     normalDialog(context,'ข้อมูลของท่านไม่ตรงกับที่สมัคร');
  //         //   }
  //     }
  //   } catch (e) {
  //     print('error');
  //   }
  // }


  ListTile patientList2() => ListTile(
        leading: Image.asset(
          'images/add-friend.png',
          height: 24,
          width: 24,
        ),
        title: MyStyle().txt16BoldB('คนไข้ที่ดูแล'),
        onTap: () {
          Navigator.pop(
              context); // ลูกศรกลับ แก้ปัญหาเรื่องตัว Drawer ไม่หดกลับ
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => SignUp()); //วิธีเชื่อมหน้า
          Navigator.push(context, route);
        },
      );

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      accountName: Text(nameUser == null ? 'Main User' : '$nameUser login'),
      accountEmail: Text('$email'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(''),
      ),
    );
  }
}
