import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show MessageType;

@immutable
class GlobalState {
  final bool loading;
  final String? message;
  final MessageType type;

  const GlobalState({
    this.loading = true,
    this.message,
    this.type = MessageType.neutral,
  });

  const GlobalState.initial(bool load)
      : loading = load,
        message = null,
        type = MessageType.neutral;

  GlobalState copyWith({
    bool? loading,
    String? message,
    MessageType? type,
  }) =>
      GlobalState(
        loading: loading ?? this.loading,
        message: message ?? this.message,
        type: type ?? this.type,
      );

  @override
  bool operator ==(covariant GlobalState other) =>
      identical(this, other) ||
      (loading == other.loading &&
          message == other.message &&
          type == other.type);

  @override
  int get hashCode => Object.hash(loading, message, type);
}
