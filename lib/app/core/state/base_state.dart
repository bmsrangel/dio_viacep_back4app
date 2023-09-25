abstract class BaseState<T> {
  BaseState({
    required this.isLoading,
    required this.state,
    required this.error,
  });

  final bool isLoading;
  final String? error;
  final T state;

  BaseState copyWith({bool? isLoading, T? state, String? error});
}
