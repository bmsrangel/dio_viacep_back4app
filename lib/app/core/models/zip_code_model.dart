import 'package:equatable/equatable.dart';

class ZipCodeModel extends Equatable {
  final String? id;
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String uf;

  const ZipCodeModel({
    this.id,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  @override
  List<Object?> get props => [
        id,
        cep,
        logradouro,
        bairro,
        localidade,
        uf,
      ];

  Map<String, dynamic> toMap() {
    return {
      'objectId': id,
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }

  factory ZipCodeModel.fromMap(Map<String, dynamic> map) {
    return ZipCodeModel(
      id: map['objectId'] ?? '',
      cep: map['cep'] ?? '',
      logradouro: map['logradouro'] ?? '',
      bairro: map['bairro'] ?? '',
      localidade: map['localidade'] ?? '',
      uf: map['uf'] ?? '',
    );
  }

  ZipCodeModel copyWith({
    String? id,
    String? cep,
    String? logradouro,
    String? bairro,
    String? localidade,
    String? uf,
  }) {
    return ZipCodeModel(
      id: id ?? this.id,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
    );
  }
}
