String makeFullName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return '';

  final words = trimmed.split(RegExp(r'\s+'));

  // توحيد الكلمة للمقارنة فقط (بنرجع الكلمة الأصلية في النتيجة)
  String norm(String w) => w
      .replaceAll(RegExp(r'[\u064B-\u0652\u0640]'), '') // تشكيل وتطويل
      .replaceAll(RegExp(r'[أإآ]'), 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي');

  // كلمات بتتربط باللي بعدها: عبد الله، أبو بكر، أم كلثوم، بن علي...
  const prefixes = {
    'عبد', 'ابو', 'ام', 'ابن', 'بن', 'بنت', 'ال', 'ذو', 'ذات',
  };

  // كلمات بتتربط باللي قبلها: صلاح الدين، فتح الله، سيف الإسلام...
  const suffixes = {
    'الدين', 'الله', 'الاسلام', 'الحق', 'الملك', 'الدوله',
  };

  // يقرأ اسم واحد بادئ من مكان معين ويرجع (الاسم، المكان التالي)
  (String, int) readName(int start) {
    int i = start;

    // 1) بادئات متتالية (أبو عبد الله = اسم واحد)
    while (i < words.length - 1 && prefixes.contains(norm(words[i]))) {
      i++;
    }

    // 2) الكلمة الأساسية
    i++;

    // 3) لواحق (نور الدين، فتح الله)
    while (i < words.length && suffixes.contains(norm(words[i]))) {
      i++;
    }

    return (words.sublist(start, i).join(' '), i);
  }

  final names = <String>[];
  int index = 0;
  while (index < words.length && names.length < 2) {
    final (n, next) = readName(index);
    names.add(n);
    index = next;
  }

  return names.join(' ');
}