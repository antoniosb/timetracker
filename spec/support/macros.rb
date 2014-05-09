def drop_schemas
  connection = ActiveRecord::Base.connection.raw_connection
  schemas = connection.query(%Q{
    SELECT 'drop schema ' || nspname || ' cascade;'
    from pg_namespace
    where nspname != 'public'
    AND nspname NOT LIKE 'pg_%'
    AND nspname != 'information_schema';
  })
  schemas.each do |query|
    connection.query(query.values.first)
  end
end

def sign_user_in(user, opt={})
  if opt[:subdomain]
    visit new_user_session_url(subdomain: opt[:subdomain])
  else
    visit new_user_session_path
  end
  
  fill_in 'Email', with: user.email
  fill_in 'Password', with: (opt[:password] || user.password)
  click_button 'Sign in'
end

def set_subdomain(subdomain)
  Capybara.app_host = "http://#{subdomain}.example.com"
end