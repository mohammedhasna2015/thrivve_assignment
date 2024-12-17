import 'package:thrivve_assignment/core/helper/optional_mapper.dart';
import 'package:thrivve_assignment/core/utils/iterables/iterable_compact_map.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/mappers/payment_extention.dart';
import 'package:thrivve_assignment/features/withdraw/data/mappers/withdraw_confirm_extention.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';

class WithdrawRepository extends IWithDrawRepository {
  final IWithdrawDataSource _dataSource;

  WithdrawRepository(this._dataSource);
  @override
  Future<WithdrawConfirmEntity> confirmWithDraw() async {
    final result = await _dataSource.confirmWithDraw();
    return result.toEntity();
  }

  @override
  Future<List<PaymentEntity>> listPayment() async {
    final result = await _dataSource.listPayment();
    return result.map((e) => e.toEntity()).toList().orDefault.noneNullList();
  }
}
