import 'package:dio_viacep_back4app/app/core/models/zip_code_model.dart';
import 'package:flutter/material.dart';

import '../widgets/zip_code_tile_widget.dart';

class SingleZipCodePage extends StatefulWidget {
  const SingleZipCodePage({super.key, required this.zipCodeModel});

  final ZipCodeModel zipCodeModel;

  @override
  State<SingleZipCodePage> createState() => _SingleZipCodePageState();
}

class _SingleZipCodePageState extends State<SingleZipCodePage> {
  ZipCodeModel get _zipCodeModel => widget.zipCodeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_zipCodeModel.cep),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          ZipCodeTileWidget(
            description: 'Logradouro',
            content: _zipCodeModel.logradouro,
          ),
          ZipCodeTileWidget(
            description: 'Bairro',
            content: _zipCodeModel.bairro,
          ),
          ZipCodeTileWidget(
            description: 'Localidade',
            content: _zipCodeModel.localidade,
          ),
          ZipCodeTileWidget(
            description: 'UF',
            content: _zipCodeModel.uf,
          ),
        ],
      ),
    );
  }
}
