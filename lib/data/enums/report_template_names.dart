enum ReportTemplateNames {
  tag_report(prefix: "tag_report_template"),
  tag_validation(prefix: "tag_validation_template");

  final String prefix;

  const ReportTemplateNames({required this.prefix});
}
