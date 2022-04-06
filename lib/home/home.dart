import 'dart:developer';

import 'package:bloc_test/home/cubit/teste_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        //* EXECUTADO SEMPRE QUE HÁ UMA MUDANÇA DE ESTADO
        child: BlocListener<TesteCubit, TesteState>(
          listener: (context, state) {
            log('Estado alterado !!!!');
            if (state is TesteLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('A quantidade de itens e ${state.lista?.length}'),
                ),
              );
            }
          },
          child: Column(
            children: [
              //* EXECUTADO QUANDO HÁ UMA MUDANÇA DE ESTADO. ESSE WIDGET TEM A CAPACIDADE DE FAZER BUILD NA TELA
              BlocConsumer<TesteCubit, TesteState>(
                builder: (context, state) {
                  if (state is TesteLoaded) {
                    return Center(
                      child: Text('O total da lista é ${state.lista?.length}'),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                listener: (contex, state) {
                  log('Estado alterado no bloc consumer');
                },
              ),
              //* ESSE CARA TEM O PODER DE MASTIGAR OS ESTADOS E PASSAR PARA O BLOC BUILDER JÁ OS VALORES PRONTOS
              BlocSelector<TesteCubit, TesteState, bool>(
                selector: (state) {
                  if (state is TesteLoading) {
                    return true;
                  }
                  return false;
                },
                builder: (contex, showLoader) {
                  if (showLoader) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              //* O TERCEIRO ARGUMENTO PASSADO NO GENERICS SÃO OS DADOS QUE VOCE QUER TRATAR DENTRO DO BLOC SELECTOR
              BlocSelector<TesteCubit, TesteState, List<String>?>(
                selector: (state) {
                  if (state is TesteLoaded) {
                    return state.lista;
                  }
                  return [];
                },
                builder: (context, myList) {
                  return ListView.builder(
                    itemCount: myList?.length,
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      return ListTile(
                        title: Text(myList![index]),
                      );
                    },
                  );
                },
              ),

              // BlocBuilder<TesteCubit, TesteState>(
              //   builder: (context, state) {
              //     if (state is TesteLoaded) {
              //       return ListView.builder(
              //         itemCount: state.lista?.length,
              //         shrinkWrap: true,
              //         itemBuilder: (contex, index) {
              //           return ListTile(
              //             title: Text(state.lista![index]),
              //           );
              //         },
              //       );
              //     } else {
              //       return const SizedBox.shrink();
              //     }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
