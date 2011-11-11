application = "calesur"
repository = '/home/elretirao/git/calesur'
hosts = ['elretirao.net']
path = '/home/elretirao'
release_path = "#{path}/#{application}"
user = 'elretirao'

before_restarting_server do
  rake "redis:import_yaml"
  rake "assets:precompile"
  run "cd #{release_path} && rvmsudo foreman export upstart /etc/init -a #{application} -c web=3 -u #{user} -l #{release_path}/log/foreman -e .production_env -p 5000"
  run "sudo start #{application} || sudo restart #{application}"
end
