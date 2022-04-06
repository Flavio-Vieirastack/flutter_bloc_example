import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'teste_state.dart';

class TesteCubit extends Cubit<TesteState> {
  TesteCubit() : super(TesteInitial());

  void getList() async {
    try {
      emit(TesteLoading());
      final list = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
      await Future.delayed(const Duration(seconds: 5));
      emit(TesteLoaded(lista: list));
    } on Exception catch (e) {
      log('Erro: $e');
      emit(TesteFaliure('error'));
    }
  }
}
