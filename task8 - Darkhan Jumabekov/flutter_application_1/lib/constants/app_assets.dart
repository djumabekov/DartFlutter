abstract class AppAssets {
  static const images = _Images();
  static const svg = _Svg();
}

class _Images {
  const _Images();
  final String noAvatar = 'assets/images/bitmap/no_avatar.png';
  final String logo = 'assets/images/bitmap/logo.png';
  final String splash = 'assets/images/bitmap/splash.png';
}

class _Svg {
  const _Svg();
  final String account = 'assets/images/svg/account.svg';
  final String password = 'assets/images/svg/password.svg';
  final String persons = 'assets/images/svg/persons.svg';
  final String settings = 'assets/images/svg/settings.svg';
}
