import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mengedegna_app/models/user_info_model.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/widgets/CButton.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? fileName;

  String? filePath;

  @override
  Widget build(BuildContext context) {
    UserInfoModel? user = Provider.of<Request>(context).userInfo;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile",
            style: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 15,
            )),
        iconTheme: IconThemeData(color: Colors.indigoAccent),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    // var result = await FilePicker.platform.pickFiles();
                    // setState(() {
                    //   fileName = result!.files.first.name;
                    //   filePath = result.files.first.path;
                    // });

                    // if (fileName!.endsWith(".png") ||
                    //     fileName!.endsWith(".jpg") ||
                    //     fileName!.endsWith(".Jpeg") ||
                    //     fileName!.endsWith(".gif")) {
                    //   setState(() {});
                    // } else {
                    //   fileName = null;
                    //   filePath = null;
                    // }
                  },
                  child: CircleAvatar(
                    backgroundImage: filePath != null
                        ? Image.file(File(filePath as String)).image
                        : null,
                    backgroundColor: Color.fromARGB(255, 221, 221, 221),
                    radius: 50,
                    child: filePath == null
                        ? Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 40,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  initialValue: user!.firstName,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  initialValue: user.lastName,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  initialValue: user.email,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  initialValue: user.phoneNumber,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CButton("Update"),
            ],
          )),
    );
  }
}
