import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../core/models/zip_code_model.dart';
import 'stores/zip_codes/zip_codes_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.zipCodesStore,
  }) : super(key: key);

  final ZipCodesStore zipCodesStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ZipCodesStore get _zipCodesStore => widget.zipCodesStore;

  @override
  void initState() {
    super.initState();
    _zipCodesStore.fetchZipCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de CEPs'),
      ),
      body: Center(
        child: ScopedBuilder<ZipCodesStore, List<ZipCodeModel>>(
          store: _zipCodesStore,
          onLoading: (_) => const CircularProgressIndicator(),
          onError: (context, error) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ops... Parece que algo deu errado!'),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _zipCodesStore.fetchZipCodes,
                icon: const Icon(Icons.refresh),
                label: const Text('Recarregar'),
              ),
            ],
          ),
          onState: (context, state) {
            if (state.isEmpty) {
              return const Text('Nenhum CEP registrado');
            } else {
              return ListView.separated(
                itemCount: state.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) => ListTile(
                  title: Text(state[index].cep),
                  onTap: () async {
                    await Modular.to.pushNamed(
                      '/zip_code',
                      arguments: state[index],
                    );
                    await _zipCodesStore.fetchZipCodes();
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await _zipCodesStore.deleteZipCode(state[index]);
                      await _zipCodesStore.fetchZipCodes();
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Modular.to.pushNamed('/search');
          await _zipCodesStore.fetchZipCodes();
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
