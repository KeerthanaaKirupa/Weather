class Images {

  static String getImage(String weatherStateAbbr) {
    var _image;
    String abbr = weatherStateAbbr;

    if (abbr == 'hr') {
      _image = 'assets/heavyrain.png';
    } else if (abbr == 'sl') {
      _image = 'assets/sleet.png';
    } else if (abbr == 'sn') {
      _image = 'assets/snow.png';
    } else if (abbr == 'h') {
      _image = 'assets/hail.png';
    } else if (abbr == 'c') {
      _image = 'assets/clear.png';
    } else if (abbr == 'hc') {
      _image = 'assets/heavycloud.png';
    } else if (abbr == 's' || abbr == 'lr') {
      _image = 'assets/showers.png';
    } else if (abbr == 'lc') {
      _image = 'assets/lightcloud.png';
    } else if (abbr == 'ts') {
      _image = 'assets/thunferstorm.png';
    } else {
      _image = 'assets/default.png';
    }

    return _image;
  }
}
