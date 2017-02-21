require "rails/generators/named_base"

module Js # :nodoc:
  module Generators # :nodoc:
    class AssetsGenerator < Rails::Generators::NamedBase # :nodoc:
      source_root File.expand_path("../templates", __FILE__)

      def create_javascript_files
        template 'new.js',  File.join("app/assets/javascripts/ng/controllers/#{file_name}", "new.js")
        template 'edit.js',  File.join("app/assets/javascripts/ng/controllers/#{file_name}", "edit.js")
        template 'index.js',  File.join("app/assets/javascripts/ng/controllers/#{file_name}", "index.js")
        template 'show.js',  File.join("app/assets/javascripts/ng/controllers/#{file_name}", "show.js")

        ng_app_path = 'app/assets/javascripts/ng/app.module.js'
        tag =  "    // <controllers_scaffold>\n"

        inject_into_file ng_app_path, after: tag do
          "    'app.controllers.#{file_name}.new',\n"
        end

        inject_into_file ng_app_path, after: tag do
          "    'app.controllers.#{file_name}.edit',\n"
        end

        inject_into_file ng_app_path, after: tag do
          "    'app.controllers.#{file_name}.show',\n"
        end

        inject_into_file ng_app_path, after: tag do
          "    'app.controllers.#{file_name}.index',\n"
        end

      end
    end
  end
end
