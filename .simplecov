SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.minimum_coverage 61.03
SimpleCov.refuse_coverage_drop
SimpleCov.start :rails do
  add_group 'Importers', 'app/importers'
  add_filter 'app/admin'
end
