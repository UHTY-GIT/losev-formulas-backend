SwaggerUiEngine.configure do |config|
  config.admin_username = 'admin'
  config.admin_password = '123456'

  config.swagger_url = 'api-docs.json'
end

Rails.application.config.assets.precompile += %w(swagger_ui_engine/application.css swagger_ui_engine/application.js swagger_ui_engine/reset.css swagger_ui_engine/print.css)
