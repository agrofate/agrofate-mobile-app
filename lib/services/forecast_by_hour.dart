class ForecastByHour {
  String hour;
  String temperature;
  String windVelocity;
  String rainProbability;
  String humidity;

  ForecastByHour(
      {required this.hour,
      required this.temperature,
      required this.windVelocity,
      required this.rainProbability,
      required this.humidity});

  // TODO: função async para recuperar da API os valores de previsão por hra
}
