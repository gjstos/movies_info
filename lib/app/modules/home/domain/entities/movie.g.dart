// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      data: fields[0] as String,
      genero: (fields[1] as List)?.cast<String>(),
      link: fields[2] as String,
      poster: fields[3] as String,
      sinopse: fields[4] as String,
      sinopseFull: fields[5] as String,
      titulo: fields[6] as String,
      isFav: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
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
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
