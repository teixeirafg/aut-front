desc 'HMG Full Scenarios'
task :hmg_full_scenarios do
  command = 'bundle install --quiet'
  puts command
  system command
  command = 'cucumber -p hml -p chrome'
  puts command
  system command
end
