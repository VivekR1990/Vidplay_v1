// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDataAdapter extends TypeAdapter<FavoriteData> {
  @override
  final int typeId = 1;

  @override
  FavoriteData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteData(
      videoPath: fields[0] as String,
      videoName: fields[1] as String,
      videoSize: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.videoName)
      ..writeByte(2)
      ..write(obj.videoSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
