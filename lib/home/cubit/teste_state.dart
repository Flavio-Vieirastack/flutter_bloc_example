part of 'teste_cubit.dart';

@immutable
abstract class TesteState extends Equatable {
  final List<String>? lista;
  const TesteState(
    this.lista,
  );
  @override
  List<Object?> get props => [lista];
}

class TesteInitial extends TesteState {
  TesteInitial() : super([]);

  @override
  List<Object?> get props => [lista];
}

class TesteLoading extends TesteState {
  TesteLoading() : super([]);

  @override
  List<Object?> get props => [lista];
}

class TesteLoaded extends TesteState {
  const TesteLoaded({required List<String> lista}) : super(lista);

  @override
  List<Object?> get props => [lista];
}

class TesteFaliure extends TesteState {
  final String error;
  TesteFaliure(this.error) : super([]);

  @override
  List<Object?> get props => [lista];
}
