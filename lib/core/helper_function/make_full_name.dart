String makeFullName(String name) {
  String trimmed = name.trim();
  List<String> parts = trimmed.split(RegExp(r'\s+'));

  if (parts.length == 1) {
    return "${parts[0]}";
  }

  if (parts.length >= 2) {
    return "${parts[0]} ${parts[1]}";
  }

  return trimmed;
}