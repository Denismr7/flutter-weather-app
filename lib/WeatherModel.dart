class WeatherModel {
  final temp;
  final pressure;
  final humidity;
  final tempMax;
  final tempMin;

  double get getTemp => temp;
  double get getMaxTemp => tempMax;
  double get getMinTemp => tempMin;

  WeatherModel(
      this.temp, this.pressure, this.humidity, this.tempMax, this.tempMin);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(json["temp"], json["pressure"], json["humidity"],
        json["temp_max"], json["temp_min"]);
  }
}
