class URLs {
  //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

  // sub -> https://api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={API key}
  static const base = 'https://api.openweathermap.org/data/2.5';

  static weatherIcon(String code) {
    return 'https://openweathermap.org/img/wn/$code@4x.png';
  }
}
