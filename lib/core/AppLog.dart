
class AppLog {
  static void d({final String? tag, required final String message}) => print('Debug: ${tag??''} => $message');
}