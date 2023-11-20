import 'package:flutter/material.dart';
import 'dart:async';
import 'drivers_model.dart';
import 'drivers_list.dart';
import 'new_driver_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My favourite Drivers',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage
      (
        title: 'My favourite Drivers',
      ),
    );   
  }
}

class MyHomePage extends StatefulWidget 
{
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  List<Driver> initialPilots = [Driver('Fernando'), Driver('Carlos'), Driver('Lando')];

  Future _showNewPilotForm() async 
  {
    Driver? newDriver = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) 
    {
      return const AddPilotFormPage();
    }));
    //print(newDigimon);
    
    if (newDriver != null) {
    initialPilots.add(newDriver);
      setState(() {});
    } 
    else 
    {
    
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold
    (
      key: key,
      appBar: AppBar
      (
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B479E),
        actions: <Widget>
        [
          IconButton
          (
            icon: const Icon(Icons.add),
            onPressed: _showNewPilotForm,
          ),
        ],
      ),
      body: Container
      (
        child: Center
        (
          child: PilotList(initialPilots),
        )
        
      ),
    );
  }
}
