import 'package:json_annotation/json_annotation.dart';
part 'SelfCarePromotion.g.dart';

@JsonSerializable()
class SelfCarePromotion{
  List<SelfCarePromotion> list = new List();
  String title;
  String banner;
  @JsonKey(name: "bannerURL")
  String bannerUrl;
  String description;
  bool status;
  @JsonKey(ignore: true)
  BigInt createdDate;
  @JsonKey(ignore: true)
  BigInt modifiedDate;
  String modifiedBy;
  String createdBy;
  String contentType;
  String thumbnailFile;
  String createdDateString;
  String modifiedDateString;

  SelfCarePromotion(
      {this.title,
      this.banner,
      this.bannerUrl,
      this.description,
      this.status,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.createdBy,
      this.contentType,
      this.thumbnailFile,
      this.createdDateString,
      this.modifiedDateString});


  factory SelfCarePromotion.fromJson(Map<String, dynamic> json) => _$SelfCarePromotionFromJson(json);
}
