import '../common/base/base_model.dart';
import '../common/extension/string_extension.dart';
import 'enum/field.dart';

class ItemTemplate extends BaseModel {
  ItemTemplate(this.id, this.content);

  factory ItemTemplate.fromJson(Map<String, Object?> data) {
    return ItemTemplate(
      data[Field.id.name].toString().toInt(),
      data[Field.content.name].toString(),
    );
  }

  final int id;
  final String content;

  @override
  Map<String, Object?> toJson() => {
        Field.id.name: id,
        Field.content.name: content,
      };
}
