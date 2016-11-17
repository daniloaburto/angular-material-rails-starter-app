module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    # sentence = I18n.t("errors.messages.not_saved",
    #                   count: resource.errors.count,
    #                   resource: resource.class.model_name.human.downcase)
    #sentence = 'Some problems here:'

    html = <<-HTML
      <div class="alert alert-danger alert-dismissable" role="alert">
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
          <span class="sr-only">#{t('close_alert', scope: :flash)}</span>
        </button>
        <strong><i class="icon fa fa-ban"></i> #{t('error_title', scope: :flash)}: </strong>
        <ul>#{messages}</ul>
      </div>
    HTML

    html.html_safe
  end

  def devise_session_flash!
    flash_msg = ""
    flash_msg = flash[:error] || flash[:alert] || flash[:notice] unless flash.empty?

    return "" if flash_msg.empty?

    if flash[:alert]
      if flash_msg == t('devise.failure.last_attempt')
        html = <<-HTML
          <div class="alert alert-warning alert-dismissable" role="alert">
            <button type="button" class="close" data-dismiss="alert">
              <span aria-hidden="true">&times;</span>
              <span class="sr-only">#{t('close_alert', scope: :flash)}</span>
            </button>
            <strong><i class="icon fa fa-warning"></i> #{t('alert_title', scope: :flash)}: </strong> #{flash_msg}
          </div>
        HTML
      else
        html = <<-HTML
          <div class="alert alert-danger alert-dismissable" role="alert">
            <button type="button" class="close" data-dismiss="alert">
              <span aria-hidden="true">&times;</span>
              <span class="sr-only">#{t('close_alert', scope: :flash)}</span>
            </button>
            <strong><i class="icon fa fa-ban"></i> #{t('error_title', scope: :flash)}: </strong> #{flash_msg}
          </div>
        HTML
      end
    elsif flash[:notice]
      html = <<-HTML
        <div class="alert alert-success alert-dismissable" role="alert">
          <button type="button" class="close" data-dismiss="alert">
            <span aria-hidden="true">&times;</span>
            <span class="sr-only">#{t('close_alert', scope: :flash)}</span>
          </button>
          <strong><i class="icon fa fa-check"></i> #{t('notice_title', scope: :flash)}: </strong> #{flash_msg}
        </div>
      HTML
    end

    html.html_safe
  end

end
