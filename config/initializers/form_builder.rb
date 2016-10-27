class ActionView::Helpers::FormBuilder
  def label_with_required_class(method, text_or_options = nil, options = {}, &block)
    if text_or_options && text_or_options.class == Hash
      options = text_or_options
    else
      text = text_or_options
    end
 
    validators = object.class.validators_on(method)
    if validators.map(&:class).include?(ActiveRecord::Validations::PresenceValidator)
      # Classes as array with one item for each class
      classes = options[:class]
      classes = classes.is_a?(String) ? classes.split(' ') : Array(classes)
      classes << 'mandatory'
      options[:class] = classes.uniq
    end
 
    self.label_without_required_class(method, text, options, &block)
  end
  alias_method_chain :label, :required_class
end