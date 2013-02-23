guard 'rspec', cli: "--color --format Fuubar" do
  watch(%r{^lib/(.+)\.rb})          { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.treetop})     { |m| "spec/#{m[1]}_parser_spec.rb" }

  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^spec/(.+)_contract\.rb})  { |m| Dir["spec/#{m[1]}*_spec.rb"] }
  watch('spec/spec_helper.rb')        { "spec" }
  watch(%r{spec/support/.+\.rb})      { "spec" }
end

# Disabled until I can figure out how to make it work with Chrome
# guard 'livereload' do
#   watch(%r{^examples/.+\.html$})
# end
