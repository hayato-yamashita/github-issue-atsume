Rails.application.config.generators do |g|
  g.assets false
  g.helper false
  g.template_engine :slim
  g.test_framework :rspec,
    fixture: true,
    controller_specs: false,
    helper_specs: false,
    routing_specs: false,
    view_specs: false
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
end
