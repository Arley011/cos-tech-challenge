/// A utility class for regular expressions.
class RegexUtils {
  /// A regular expression to validate email addresses.
  static final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  /// A regular expression to validate phone numbers. Doesn't enforce
  /// Note: Doesn't enforce VIN length.
  static final vinRegExp = RegExp(r'^[A-HJ-NPR-Za-hj-npr-z0-9]+$');
}
