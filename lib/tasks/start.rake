namespace :generate do

  desc "Generate a scaffold"
  task :scaffold, [:model] do |model|
    %(bundle exec rails generate #{model} scaffold _id:string properties:hash)
  end

end
