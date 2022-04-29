require "rake/testtask"
require "rufo"

Rake::TestTask.new do |test|
  test.test_files = FileList["test/**/*.rb"]
  test.verbose = false
end

task :format do
  files = FileList["**/*.rb"]
  Rufo::Command.run(files)
end

task({ default: "test" })
