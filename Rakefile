require 'rake/testtask'
require 'ci/reporter/rake/test_unit'

Rake::TestTask.new do |t|

t.test_files = FileList['lib/shopify_tests.rb']

#t.test_files = FileList['lib/magento_tests.rb'] 

 #t.test_files = FileList['lib/new_test.rb']
  
# real version -   t.test_files = FileList['lib/magento_tests.rb', 'lib/shopify_tests.rb'] 'lib/new_test.rb'
 
  t.verbose = true
end

task :test => "ci:setup:testunit"
