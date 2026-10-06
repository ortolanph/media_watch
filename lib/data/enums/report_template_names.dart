enum ReportTemplateNames {
  tagReport(prefix: "tag_report_template"),
  tagValidation(prefix: "tag_validation_template");

  final String prefix;

  const ReportTemplateNames({required this.prefix});
}
