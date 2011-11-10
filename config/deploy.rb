application = "calesur"
repository = '/home/elretirao/git/calesur'
hosts = ['elretirao.net']
path = '/home/elretirao'
user = 'elretirao'

before_restarting_server do
  rake "redis:import_yaml"
  rake "assets:precompile"
end
