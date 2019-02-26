ENV['SHA'] = ENV['HEROKU_SLUG_COMMIT'] || `head -n 1 /opt/doris-hyku/revisions.log`.strip

HealthMonitor.configure do |config|
  config.environment_variables = {
    git_sha: ENV['SHA'],
    site_uri: ENV['SITE_URI']
  }
  config.error_callback = proc do |e|
    Rails.logger.error "Health check failed with: #{e.message} \n #{e.backtrace}"
    Raven.capture_exception(e)
  end
  config.cache
end

if(defined?(Lograge))
  Rails.application.config.lograge.ignore_actions = ["HealthMonitor::HealthController#check", "HealthMonitor::HealthController#fail" ]
end
