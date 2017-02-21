module ApplicationHelper

  def show_error_messages!(resource)
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
      <div class="container">
        <div class="row">
          <div class="col-sm-12">
            <div class="alert alert-danger alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong><i class="icon fa fa-ban"></i> #{t('error_title', scope: :flash)}:</strong> #{sentence}
              #{messages}
            </div>
          </div><!-- /.col -->
        </div>
      </div>
    HTML
    html.html_safe
  end

  def attr_has_error?(object, attribute)
    object.errors[attribute].present? ? 'md-is-error="true"' : ''
  end

  def show_attr_errors!(object, attribute)
    return '' unless object.errors[attribute].present?
    errors = object.errors[attribute]
                   .map{|e| "<span class='input-error'>#{e}</span>"}
                   .join('')
    html = "<div class='input-errors'>#{errors}</div>"
    html.html_safe
  end
end
