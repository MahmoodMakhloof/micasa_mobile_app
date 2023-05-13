const _regex = r'^01[0125][0-9]{8}$';

String get egyptianPhoneNumberRegex => _regex;

bool isEgyptianPhoneNumber(String phoneNumber) {
  return RegExp(_regex).hasMatch(phoneNumber);
}
