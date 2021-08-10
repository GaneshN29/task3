import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
void main()=>runApp(MaterialApp(home: HomePage(),debugShowCheckedModeBanner: false,));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String _location ="";
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  void getWeather (String input) async{
    String url = "http://api.openweathermap.org/data/2.5/weather?q=${input}&appid=b77c3647f5d4ff3cdfdc721e9f060834";
    http.Response response = await http.get(Uri.parse(url));
  var results = jsonDecode(response.body);
  setState(() {
    this.temp = results['main']['temp'];
    this.description = results['weather'][0]['description'];
    this.currently = results['weather'][0]['main'];
    this.humidity = results['main']['humidity'];
    this.windspeed = results['wind']['speed'];
  });
  }
  void onTextFieldSubmitted(String input) {
    getWeather(input);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mobile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
        children:<Widget>[
        Container(
        height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
        width: 300,
        alignment: Alignment.center,
          padding: EdgeInsets.only(top: 40),

          child: TextField(
            onSubmitted: (String input){
              _location=input;
              onTextFieldSubmitted(input);
            },
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 22, color:Colors.white, height: 0.8,fontWeight:FontWeight.w600,

            ),

            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search,color: Colors.white,),
              hintText:"Search Your Location:",
              hintStyle: TextStyle(color: Colors.white, fontSize:22,fontWeight:FontWeight.w600),
            ),
          ),),


        Padding(padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
        child: Text("Your in " + _location,
        style: TextStyle(
        color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w600
        ),
        ),
        ),
        Text(temp != null ? temp.toString() + "K" : "Loading",
        style:TextStyle(
        fontSize: 50, color: Colors.white,
        fontWeight: FontWeight.w600,
        ) ,
        ),
        Padding(padding: EdgeInsets.only(top: 15.0),
        child: Text(currently != null ? currently.toString() : "Loading",
        style: TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600
        ),
        ),
        ),
          Expanded(child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children:<Widget>[
                ListTile(
                  contentPadding: EdgeInsets.only(top:20),
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf, color:Colors.white,),
                  title: Text("Temperature",
                    style: TextStyle(
                      fontSize: 25, fontWeight:FontWeight.w600, color: Colors.white,
                    ),
                  ),
                  trailing: Text(temp != null ? temp.toString() + "K" : "Loading",
                    style: TextStyle(
                      fontSize: 23, fontWeight:FontWeight.w600,color: Colors.white,),
                  ),),
                ListTile(
                  contentPadding: EdgeInsets.only(top:40),
                  leading: FaIcon(FontAwesomeIcons.cloud,color: Colors.white,),
                  title: Text("Weather",
                    style: TextStyle(
                      fontSize: 25, fontWeight:FontWeight.w600,color: Colors.white,
                    ),
                  ),
                  trailing: Text(description != null ? description.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 23, fontWeight:FontWeight.w600,color: Colors.white,),
                  ),),
                ListTile(
                  contentPadding: EdgeInsets.only(top:40),
                  leading: FaIcon(FontAwesomeIcons.sun,color: Colors.white,),
                  title: Text("Humidity",
                    style: TextStyle(
                      fontSize: 25, fontWeight:FontWeight.w600,color: Colors.white,
                    ),
                  ),
                  trailing: Text(humidity != null ? humidity.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 23, fontWeight:FontWeight.w600,color: Colors.white,),
                  ),),
                ListTile(
                  contentPadding: EdgeInsets.only(top:40),
                  leading: FaIcon(FontAwesomeIcons.wind,color: Colors.white,),
                  title: Text("Wind Speed",
                    style: TextStyle(
                      fontSize: 25, fontWeight:FontWeight.w600,color: Colors.white,
                    ),
                  ),
                  trailing: Text(windspeed != null ? windspeed.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 23, fontWeight:FontWeight.w600,color: Colors.white,),
                  ),)
              ],
            ),
          )
          )
        ],
        ),
        ),

        ],

        ),
        ),
      ),
    )
    );
  }
}