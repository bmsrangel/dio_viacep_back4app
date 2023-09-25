import 'package:dio_viacep_back4app/app/core/models/zip_code_model.dart';
import 'package:dio_viacep_back4app/app/modules/home/stores/single_zip_code/search_zip_code_store.dart';
import 'package:dio_viacep_back4app/app/modules/home/stores/zip_codes/zip_codes_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SearchZipCodePage extends StatefulWidget {
  const SearchZipCodePage({
    super.key,
    required this.searchZipCodeStore,
    required this.zipCodesStore,
  });

  final SearchZipCodeStore searchZipCodeStore;
  final ZipCodesStore zipCodesStore;

  @override
  State<SearchZipCodePage> createState() => _SearchZipCodePageState();
}

class _SearchZipCodePageState extends State<SearchZipCodePage> {
  SearchZipCodeStore get _searchZipCodeStore => widget.searchZipCodeStore;
  ZipCodesStore get _zipCodesStore => widget.zipCodesStore;

  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _zipCode$;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _zipCode$ = TextEditingController();
    _searchZipCodeStore.observer(
      onState: (state) {
        if (state != null) {
          Modular.to.pushReplacementNamed(
            '/zip_code',
            arguments: state,
          );
          _zipCodesStore.fetchZipCodes();
        }
      },
    );
  }

  @override
  void dispose() {
    _zipCode$.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _zipCode$,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                  hintText: '12345678',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (value.length != 8) {
                    return 'CEP inválido';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8.0),
              TripleBuilder<SearchZipCodeStore, ZipCodeModel?>(
                store: _searchZipCodeStore,
                builder: (context, triple) => ElevatedButton.icon(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      await _searchZipCodeStore.searchByZipCode(
                        _zipCode$.text,
                      );
                    }
                  },
                  icon: triple.isLoading
                      ? const SizedBox.shrink()
                      : const Icon(Icons.search),
                  label: triple.isLoading
                      ? const SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Pesquisar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
