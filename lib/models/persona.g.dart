// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      apellido: json['apellido'] as String?,
      telefono: json['telefono'] as String?,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'telefono': instance.telefono,
    };
