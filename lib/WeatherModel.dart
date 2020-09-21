class WeatherModel {
  final temp;
  final pressure;
  final humidity;
  final tempMax;
  final tempMin;
  final name;

  dynamic get getTemp => temp;
  dynamic get getMaxTemp => tempMax;
  dynamic get getMinTemp => tempMin;
  get getCity => name;

  WeatherModel(this.temp, this.pressure, this.humidity, this.tempMax,
      this.tempMin, this.name);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(json["temp"], json["pressure"], json["humidity"],
        json["temp_max"], json["temp_min"], json["name"]);
  }
}
