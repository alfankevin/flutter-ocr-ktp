part of 'csv_load_cubit.dart';

sealed class CsvLoadState extends Equatable {
  const CsvLoadState();

  @override
  List<Object> get props => [];
}

final class CsvLoadInitial extends CsvLoadState {}

final class CsvLoadLoading extends CsvLoadState {}

final class CsvLoadError extends CsvLoadState {
  final String message;

  const CsvLoadError(this.message);

  @override
  List<Object> get props => [message];
}

final class CsvLoadSuccess extends CsvLoadState {
  final List<List<dynamic>> csvTable;

  const CsvLoadSuccess(this.csvTable);

  @override
  List<Object> get props => [csvTable];
}
