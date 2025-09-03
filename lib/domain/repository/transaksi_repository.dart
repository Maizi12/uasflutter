import 'package:dartz/dartz.dart';
import 'package:digit/core/core.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/data/models/general_response.dart';

abstract class TransaksiRepository {
  Future<Either<Failure, List<GetWalletModel>>> getWallet(int idJenisCoa);
  Future<Either<Failure, List<GetJenisCoaModel>>> getJenisTransaksi();
  Future<Either<Failure, GetBerandaModel>> getBeranda({
    int? idWallet,
    int? idCoaDebit,
  });
  Future<Either<Failure, Pagination<GetTxModel>>> getRecentTx({
    int? page,
    pageSize,
    id,
    idCoaDebit,
    idCoaKredit,
    sort,
    idJenisTransaksi,
    idWallet,
    tglAwal,
    tglAkhir,
  });
  Future<Either<Failure, GetTxModelDetail>> getTxOne({dynamic id});
  Future<Either<Failure, GeneralResponse>> createTransaksi(
      List<dynamic> transaksi);
  Future<Either<Failure, GeneralResponse>> updateTransaksi(dynamic transaksi);
}
