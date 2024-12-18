class ShowSnackBarInput {
  const ShowSnackBarInput({
    required this.message,
    this.duration = const Duration(seconds: 1),
  });
  final String? message;
  final Duration duration;
}
