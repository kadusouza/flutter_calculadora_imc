// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PessoaAdapter extends TypeAdapter<Pessoa> {
  @override
  final int typeId = 0;

  @override
  Pessoa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pessoa(
      peso: fields[0] as double,
      altura: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Pessoa obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PessoaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
