import 'package:flutter/services.dart';
import 'package:mustache_template/mustache.dart';

class TemplateService {
  Future<String> render(String template, Map<String, Object> data) async {
    var templateFile = await rootBundle.loadString(
      "assets/templates/$template.mustache",
    );

    var myTemplate = Template(templateFile);

    return myTemplate.renderString(data);
  }
}
