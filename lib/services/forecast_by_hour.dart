class ForecastByHour {
  String hour;
  String temperature;
  String windVelocity;
  String rainProbability;
  String humidity;

  ForecastByHour(
      {this.hour,
      this.temperature,
      this.windVelocity,
      this.rainProbability,
      this.humidity});

  // TODO: função async para recuperar da API os valores de previsão por hra
}
