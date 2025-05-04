
extension Elapsed on DateTime {
  String elapsed() {
    final int lastLoginInMinutes = DateTime.now().difference(this).inMinutes;
    if (lastLoginInMinutes < 60) {
      return '$lastLoginInMinutes minutes ago';
    } else {
      return '${DateTime.now().difference(this).inHours} hours ago';
    }
  }
}