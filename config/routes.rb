Rails.application.routes.draw do
  resources :lessons

  get     '/test_objects/'                => 'test_objects#get_test_objects'
  get     '/test_objects/:toid'           => 'test_objects#get_test_object'
  post    '/test_objects'                 => 'test_objects#create_test_object'
  patch   '/test_objects/:toid'           => 'test_objects#update_test_object'
  delete  '/test_objects/:toid'           => 'test_objects#destroy_test_object'

  get     '/imit_mod/simplex/count'       => 'imit_mods#data_table'
  post    '/imit_mod/simplex/count'       => 'imit_mods#simplex_count'
end
