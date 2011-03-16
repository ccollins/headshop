require 'growl'
require 'open3'

ENV["WATCHR"] = "1"
$spec_cmd = "rspec --drb --tty --colour --format nested"
$pass = File.join(File.expand_path(File.dirname(__FILE__)), '.watchr_images', 'pass.png')
$fail = File.join(File.expand_path(File.dirname(__FILE__)), '.watchr_images', 'fail.png')
$pending = File.join(File.expand_path(File.dirname(__FILE__)), '.watchr_images', 'pending.png')

def growl_spec(message='')
  if message.match(/\s0\s(errors|failures)/)
    title = 'Watchr: All specs passed'
    image = $pass
  elsif message.match(/(error|failure)/)
    title = 'Watchr: Specs are failing'
    image = $fail
  elsif message.match(/pending/)
    title = 'Watchr: Pending specs'
    image = $pending
  else
    title = 'Watchr: Running specs'
    message = 'Running specs'
    image = $pending
  end
  Growl.notify message, :icon => image, :title => title
end

def run_spec(spec)
  cmd = "#{$spec_cmd} #{spec}"
  
  growl_spec
  system('clear')
  puts(cmd)
  
  last_output = ''
  stdin, stdout, stderr = Open3.popen3(cmd)
  stdout.each_line do |line|
    last_output = line
    puts line
  end
  
  growl_spec last_output.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
end

def run_all_specs
  run_spec 'spec/'
end

def related_specs(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def run_suite
  run_all_specs
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
  end
end

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running full suite ---\n\n"
  run_suite
end

watch('spec/spec_helper\.rb') { run_all_specs }
watch('spec/support/.*') { run_all_specs }
watch('spec/.*_spec\.rb') { |m| run_spec m[0] }
watch('lib/.*\.rb') { |m| related_specs(m[0]).map {|tf| run_spec tf } }