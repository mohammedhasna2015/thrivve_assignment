import 'show_dialog_input.dart';

abstract class IShowDialogHelper {
  Future<T?> showDialog<T>(ShowDialogInput input);
}
