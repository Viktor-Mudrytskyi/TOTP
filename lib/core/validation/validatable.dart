abstract class Validatable<Value, Failure> {
  Validatable(Value value) {
    update(value);
  }

  void update(Value value) {
    _value = value;
    _failure = validate();
  }

  Failure? validate();

  Failure? _failure;
  late Value _value;

  Value get value => _value;
  Failure? get failure => _failure;
  bool get isValid => _failure == null;
}
