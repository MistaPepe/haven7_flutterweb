import 'package:flutter/material.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
        title: Text('Haven 7'),
      ),
      
        body: Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool isPush = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            style: TextStyle(
              color: (isPush == true) ? Color.fromRGBO(170, 253, 35, 1) : Color.fromRGBO(0, 0, 0, 1),
              fontSize: 30),
            'butu'),

            OutlinedButton( onPressed: () {
              setState(() {
                isPush =!isPush;
              });
              }, child: Text('butu')),

              Butu(),
              Butu(),
              Butu(),
              Butu(),
        ],
    );
  }

  Widget Butu(){
    return Container(
      child: Column(
        children: [
          Text(
            style: TextStyle(
              color: (isPush == true) ? Color.fromRGBO(170, 253, 35, 1) : Color.fromRGBO(0, 0, 0, 1),
              fontSize: 30),
            'butu'),

            OutlinedButton( onPressed: () {
              setState(() {
                isPush =!isPush;
              });
              }, child: Text('butu')),

        ],
      ),
    );
  }
}

