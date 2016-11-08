require "rails/generators/named_base"

module Js # :nodoc:
  module Generators # :nodoc:
    class AssetsGenerator < Rails::Generators::NamedBase # :nodoc:
      source_root File.expand_path("../templates", __FILE__)

      def create_javascript_files
        template 'javascript.js',  File.join('app/assets/javascripts/controllers', class_path, "#{file_name}.js")
      end

      hook_for :pundit
    end
  end
end
