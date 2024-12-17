import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/i_show_bottom_sheet.dart';
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/show_bottom_sheet_impl.dart';
import 'package:thrivve_assignment/core/helper/show_dialog_helper/i_show_dialog_helper.dart';
import 'package:thrivve_assignment/core/helper/show_dialog_helper/show_dialog_helper.dart';
import 'package:thrivve_assignment/core/utils/navigation_service.dart';
import 'package:thrivve_assignment/core/utils/storage.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/withdraw_datawsource.dart';
import 'package:thrivve_assignment/features/withdraw/data/services/withdraw_service.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/withdraw_repository.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';

final getIt = GetIt.instance;

Future<void> initStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(
    Storage(sharedPreferences),
  );
}

Future<void> init() async {
  await initStorage();
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerSingleton<IShowDialogHelper>(
    ShowDialogHelperImpl(),
  );
  getIt.registerLazySingleton<IPageLoadingDialog>(
    () => PageLoadingDialog(),
  );
  _initWithDraw();
  getIt.registerSingleton<IShowBottomSheetHelper>(
    ShowBottomSheetHelperImpl(),
  );
}

void _initWithDraw() {
  getIt.registerLazySingleton<WithdrawService>(
    () => WithdrawService.create(),
  );

  getIt.registerLazySingleton<IWithdrawDataSource>(
    () => WithdrawDatawSource(
      getIt<WithdrawService>(),
    ),
  );

  getIt.registerLazySingleton<IWithDrawRepository>(
    () => WithdrawRepository(
      getIt<IWithdrawDataSource>(),
    ),
  );
  getIt.registerLazySingleton<IGetPaymentListUseCase>(
    () => GetPaymentListUseCase(
      getIt<IWithDrawRepository>(),
    ),
  );
  getIt.registerLazySingleton<IGetWithDrawUseCase>(
    () => GetWithDrawUseCase(
      getIt<IWithDrawRepository>(),
    ),
  );

  getIt.registerSingleton(
    WithdrawProvider(
      getIt<IGetWithDrawUseCase>(),
      getIt<IGetPaymentListUseCase>(),
    ),
  );
}
