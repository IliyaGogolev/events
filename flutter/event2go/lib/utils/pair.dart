
// TODO remove when this class introduced in flutter/dart
// https://github.com/flutter/flutter/blob/449f4a6673f6d89609b078eb2b595dee62fd1c79/dev/integration_tests/channels/lib/src/pair.dart
class Pair {
  Pair(this.left, this.right);

  final dynamic left;
  final dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}