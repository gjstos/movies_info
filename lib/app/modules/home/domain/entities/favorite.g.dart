// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final int typeId = 0;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      data: fields[0] as String,
      genero: (fields[1] as List)?.cast<String>(),
      link: fields[2] as String,
      poster: fields[3] as String,
      sinopse: fields[4] as String,
      sinopseFull: fields[5] as String,
      titulo: fields[6] as String,
      isFavorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.genero)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.poster)
      ..writeByte(4)
      ..write(obj.sinopse)
      ..writeByte(5)
      ..write(obj.sinopseFull)
      ..writeByte(6)
      ..write(obj.titulo)
      ..writeByte(7)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
