import 'package:FP/helper/authenticate.dart';
import 'package:flutter/material.dart';

// import 'firstpage.dart' as firstpage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'FP',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blueGrey,
      ),
      home: Authenticate(),
    );
  }
}

// class MainPage extends StatefulWidget {
//   MainPage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   Widget button(textvalue) {
//     return Expanded(
//       child: new OutlineButton(
//         child: Text(textvalue),
//         onPressed: () => {},
//         padding: EdgeInsets.all(24.0),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: new Container(
//           child: Column(
//             children: [
//               new Text("0"),
//               new Expanded(child: new Divider()),
//               Row(
//                 children: [
//                   button("7"),
//                   button("8"),
//                   button("9"),
//                   button("/"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   button("4"),
//                   button("5"),
//                   button("6"),
//                   button("X"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   button("1"),
//                   button("2"),
//                   button("3"),
//                   button("-"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   button("."),
//                   button("0"),
//                   button("00"),
//                   button("+"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   button("CLEAR"),
//                   button("="),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
