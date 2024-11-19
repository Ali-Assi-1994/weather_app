class WeatherModel {
  final String cod;
  final int message;
  final int cnt;
  final List<DayForecast> days;
  final City city;

  WeatherModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.days,
    required this.city,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        days: List<DayForecast>.from(json["list"].map((x) => DayForecast.fromJson(x))),
        city: City.fromJson(json["city"]),
      );
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );
}

class DayForecast {
  final int dt;
  final MainClass main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final DateTime dtTxt;
  final Rain? rain;
  final Rain? snow;

  DayForecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    this.rain,
    this.snow,
  });

  factory DayForecast.fromJson(Map<String, dynamic> json) => DayForecast(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
        snow: json["snow"] == null ? null : Rain.fromJson(json["snow"]),
      );
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}

class MainClass {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
      );
}

class Rain {
  final double the3H;

  Rain({
    required this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble(),
      );
}

class Sys {
  final Pod pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: podValues.map[json["pod"]]!,
      );
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  final int id;
  final MainEnum main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainEnumValues.map[json["main"]]!,
        description: json["description"],
        icon: json["icon"],
      );
}

enum MainEnum { CLEAR, CLOUDS, RAIN, SNOW }

final mainEnumValues = EnumValues({"Clear": MainEnum.CLEAR, "Clouds": MainEnum.CLOUDS, "Rain": MainEnum.RAIN, "Snow": MainEnum.SNOW});

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

extension UniqueForecastDays on List<DayForecast> {
  List<DayForecast> get getUniqueWeekdays {
    // Use a Set to track the days already added (avoiding duplicates)
    final Set<int> uniqueWeekdays = {};
    final List<DayForecast> uniqueDayForecasts = [];

    for (var forecast in this) {
      // Check if the weekday is already in the Set
      final weekday = forecast.dtTxt.weekday;
      if (!uniqueWeekdays.contains(weekday)) {
        uniqueWeekdays.add(weekday);
        uniqueDayForecasts.add(forecast);
      }
    }

    return uniqueDayForecasts;
  }
}
