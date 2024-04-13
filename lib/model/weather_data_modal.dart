class WeatherData {
  final double lon;
  final double lat;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final String base;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double rain1h;
  final int cloudsAll;
  final int dt;
  final int sysType;
  final int sysId;
  final String sysCountry;
  final int sysSunrise;
  final int sysSunset;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherData({
    required this.lon,
    required this.lat,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.base,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.rain1h,
    required this.cloudsAll,
    required this.dt,
    required this.sysType,
    required this.sysId,
    required this.sysCountry,
    required this.sysSunrise,
    required this.sysSunset,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      lon: json['coord']['lon'].toDouble(),
      lat: json['coord']['lat'].toDouble(),
      weatherId: json['weather'][0]['id'],
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      base: json['base'],
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'],
      rain1h: (json['rain'] != null && json['rain']['1h'] != null)
          ? json['rain']['1h'].toDouble()
          : 0.0,
      cloudsAll: json['clouds']['all'],
      dt: json['dt'],
      sysType: json['sys']['type'],
      sysId: json['sys']['id'],
      sysCountry: json['sys']['country'],
      sysSunrise: json['sys']['sunrise'],
      sysSunset: json['sys']['sunset'],
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}
