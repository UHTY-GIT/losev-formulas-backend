include Swagger::Docs::ImpotentMethods

module Swagger
  module Docs
    class Config

      def self.transform_path(path, api_v)
        "api_docs/single_swagger_doc/#{path}"
      end

      def self.base_api_controller
        ActionController::API
      end

    end

    class Generator
      def self.transform_spec_to_api_path(spec, controller_base_path, extension)
        Logger.new(STDOUT).error(spec.inspect)
        api_path = spec.to_s.dup
        api_path.gsub!('(.:format)', extension ? ".#{extension}" : '')
        api_path.gsub!(/:(\w+)/, '{\1}')
        api_path.gsub!(controller_base_path, '')

        # Substitute api version params in path to current API version
        api_path.gsub!('{api_v}', "v1")

        "/" + trim_slashes(api_path)
      end
    end
  end
end

#Swagger::Docs::Config.base_api_controller = Api::V1::ApiController
Swagger::Docs::Config.register_apis('1' => {
  controller_base_path: '',
  api_file_path: 'public/api_docs/single_swagger_doc/',
  base_path: Rails.env.development? ? 'http://127.0.0.1:3000/' : ENV['PRODUCTION_SERVER_NAME'],
  clean_directory: true
})
