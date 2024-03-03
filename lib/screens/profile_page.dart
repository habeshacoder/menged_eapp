import 'package:flutter/material.dart';
import 'package:mengedegna_app/models/user_info_model.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/screens/EditProfile.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  // void initState() {
  //   Provider.of<Request>(context, listen: false).fetchUserDetail(context);
  // }

  @override
  Widget build(BuildContext context) {
    UserInfoModel? userInfo =
        Provider.of<Request>(context, listen: true).userInfo;
    return userInfo == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(20, 0, 0, 0),
                          spreadRadius: 3,
                          blurRadius: 15)
                    ]),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      userInfo.firstName.toString() +
                          " " +
                          userInfo.lastName.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 26, 36, 95),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userInfo.email as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 26, 36, 95),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditProfile()));
                          },
                          icon: Icon(
                            Icons.edit,
                            // size: 1,
                          ),
                          label: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Provider.of<Auth>(context, listen: false)
                                .logOut(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(20, 0, 0, 0),
                          spreadRadius: 3,
                          blurRadius: 15)
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.settings,
                          color: Colors.teal,
                        ),
                        title: Text("Settings",
                            style: TextStyle(
                              fontFamily: "monte",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.question_mark,
                          color: Colors.redAccent,
                        ),
                        title: Text("FAQ",
                            style: TextStyle(
                              fontFamily: "monte",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () async {},
                        leading: Icon(
                          Icons.policy,
                          color: Colors.purple,
                        ),
                        title: Text("Terms & Policies",
                            style: TextStyle(
                              fontFamily: "monte",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                        title: Text("About",
                            style: TextStyle(
                              fontFamily: "monte",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ))
            ],
          );
  }
}
