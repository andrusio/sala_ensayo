// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sala_grupo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaGrupo _$SalaGrupoFromJson(Map<String, dynamic> json) => SalaGrupo(
      id: json['id'] as int?,
      sala: json['sala'] as String?,
      salaId: json['sala_id'] as int?,
      salaColor: Color((json['sala_color'] as int)).withOpacity(1),
      grupo: (json['grupo'] as String),
      grupoId: json['grupo_id'] as int?,
      horaDesde: DateTime.parse(json['hora_desde']),
      horaHasta: DateTime.parse(json['hora_hasta']),
    );

Map<String, dynamic> _$SalaGrupoToJson(SalaGrupo instance) => <String, dynamic>{
      'id': instance.id,
      'sala': instance.sala,
      'salaId': instance.salaId,
      'salaColor': instance.salaColor,
      'grupo': instance.grupo,
      'grupoId': instance.grupoId,
      'horaDesde': instance.horaDesde,
      'horaHasta': instance.horaHasta,
    };
