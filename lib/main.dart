import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_new_app_api/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  String url = 'https://reqres.in/api/users';

  UserModel? userModel;

  Future<UserModel> getData() async {
    Response response = await dio.get(url);

    userModel = UserModel.fromJson(response.data);

    return userModel!;
    // print('Data: ${response.data}');

    // print('First Element: ${userModel!.data!.first!.firstName}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          'Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff101010),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: FutureBuilder<UserModel>(
                    future: getData(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: userModel!.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Container(
                                      height: 200,
                                      width: 200,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            userModel!.data![index].avatar ??
                                                ''),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Your name: ${userModel!.data![index].firstName} ${userModel!.data![index].lastName}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${userModel!.data![index].email}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                );
                              })
                          : snapshot.hasError
                              ? Text('wen wrong')
                              : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
