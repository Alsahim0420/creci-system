// Handler
abstract class Validator {
  Validator? nextValidator;

  Validator setNext(Validator validator) {
    nextValidator = validator;
    return validator;
  }

  /// Returns the first error found in the chain, or null if the input is valid.
  String? validate(String input) {
    final error = check(input);
    if (error != null) return error;
    return nextValidator?.validate(input);
  }

  String? check(String input);
  String get name;
}

// Concrete handlers
class NotEmptyValidator extends Validator {
  @override
  String get name => 'Not Empty';

  @override
  String? check(String input) =>
      input.isEmpty ? '[Error] Empty string not allowed' : null;
}

class MinLengthValidator extends Validator {
  @override
  String get name => 'Min Length (5)';

  @override
  String? check(String input) =>
      input.length < 5 ? '[Error] String too short' : null;
}

class AlphanumericValidator extends Validator {
  @override
  String get name => 'Alphanumeric';

  @override
  String? check(String input) => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input)
      ? null
      : '[Error] Only alphanumeric characters allowed';
}
