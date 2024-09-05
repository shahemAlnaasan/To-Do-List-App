// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoItmesAdapter extends TypeAdapter<TodoItmes> {
  @override
  final int typeId = 0;

  @override
  TodoItmes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoItmes(
      title: fields[0] as String,
      text: fields[1] as String,
      creatingDate: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodoItmes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.creatingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItmesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
