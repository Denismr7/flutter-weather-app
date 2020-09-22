import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/WeatherBloc.dart';
import 'package:weather_app/WeatherRepo.dart';
import 'package:string_validator/string_validator.dart';

import 'WeatherModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.cyan,
        body: BlocProvider(
          create: (context) =>
              WeatherBloc(WeatherIsNotSearched(), WeatherRepo()),
          child: SearchPage(),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  final cityController = new TextEditingController();

  onSubmittedCity(city) {
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            child: Image.asset('assets/cloud.png'),
            height: 270,
            width: 270,
          ),
        ),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherIsNotSearched) {
              return Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: <Widget>[
                    Text('Search Weather',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white,
                        )),
                    Text(
                      'Instantly',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: 'City (i.e Madrid)',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(180, 150, 150, 150),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.cyan,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.white, style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.yellowAccent,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        onPressed: () =>
                            weatherBloc.add(FetchWeather(cityController.text)),
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: Color.fromARGB(255, 246, 203, 67),
                        splashColor: Color.fromARGB(255, 250, 176, 60),
                        disabledColor: Colors.grey,
                        textColor: Colors.white,
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is WeatherIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherIsLoaded) {
              return ShowWeather(state.getWeather, cityController.text);
            } else {
              return Text(
                "Error",
                style: TextStyle(color: Colors.white, fontSize: 30),
              );
            }
          },
        ),
      ],
    );
  }
}

class ShowWeather extends StatelessWidget {
  final WeatherModel weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          Text(
            toBoolean(city) ? city.toString().toUpperCase() : weather.getCity,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "MIN",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weather.getMinTemp.round().toString() + "ºC",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 246, 203, 67),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "CURRENT",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weather.getTemp.round().toString() + "ºC",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 246, 203, 67),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "MAX",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weather.getMaxTemp.round().toString() + "ºC",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 246, 203, 67),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: (() =>
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather())),
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Color.fromARGB(255, 246, 203, 67),
              splashColor: Color.fromARGB(255, 250, 176, 60),
              disabledColor: Colors.grey,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.undo,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'New search',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
