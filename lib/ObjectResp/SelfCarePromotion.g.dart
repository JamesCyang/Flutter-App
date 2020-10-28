// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SelfCarePromotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfCarePromotion _$SelfCarePromotionFromJson(Map<String, dynamic> json) {
  return SelfCarePromotion(
    title: json['title'] as String,
    banner: json['banner'] as String,
    bannerUrl: json['bannerURL'] as String,
    description: json['description'] as String,
    status: json['status'] as bool,
    modifiedBy: json['modifiedBy'] as String,
    createdBy: json['createdBy'] as String,
    contentType: json['contentType'] as String,
    thumbnailFile: json['thumbnailFile'] as String,
    createdDateString: json['createdDateString'] as String,
    modifiedDateString: json['modifiedDateString'] as String,
  )..list = (json['list'] as List)
      ?.map((e) => e == null
          ? null
          : SelfCarePromotion.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$SelfCarePromotionToJson(SelfCarePromotion instance) =>
    <String, dynamic>{
      'list': instance.list,
      'title': instance.title,
      'banner': instance.banner,
      'bannerURL': instance.bannerUrl,
      'description': instance.description,
      'status': instance.status,
      'modifiedBy': instance.modifiedBy,
      'createdBy': instance.createdBy,
      'contentType': instance.contentType,
      'thumbnailFile': instance.thumbnailFile,
      'createdDateString': instance.createdDateString,
      'modifiedDateString': instance.modifiedDateString,
    };
