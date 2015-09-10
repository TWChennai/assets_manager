class SelectizeAutocompleteInput < ::Formtastic::Inputs::SelectInput
  def input_html_options
    super.tap do |options|
      options[:class] = [options[:class], 'selectize-autocomplete'].compact.join(' ')
      options[:data] ||= {}
      options[:data].merge! autocomplete_options
    end
  end

  private

  # TODO: Is this method not used anywhere?
  def raw_collection
    res = object.send(method)
    (res.is_a?(ActiveRecord::Relation) || res.is_a?(Array)) ? res : [res]
  end

  def autocomplete_options
    options = self.options.fetch(:selectize, {})
    options = Hash[options.map { |k, v| [k.to_s.camelcase(:lower), v] }]
    { selectize: options }
  end
end
