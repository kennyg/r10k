metadata :name        => "r10k",
         :description => "Syncs modules using git ",
         :author      => "Zack Smith",
         :license     => "MIT",
         :version     => "1.0",
         :url         => "http://puppetlabs.com",
         :timeout     => 900

['push',
 'pull',
 'status'].each do |act|
   action act, :description => "#{act.capitalize} " do
   input :path,
           :prompt      => "Module path",
           :description => "Operating on #{act}",
           :type        => :string,
           :validation  => '.',
           :optional    => false,
           :maxlength   => 256

   output :path,
          :description => "Operating on #{act}",
          :display_as  => "Path"

   output :output,
          :description => "Output from git",
          :display_as  => "Output"

   output :error,
          :description => "Error from git",
          :display_as  => "Errors"
   display :always
  end
end
['cache',
 'synchronize',
 'sync'].each do |act|
  action act, :description => "#{act.capitalize} " do
    output :output,
           :description => "Output from git",
           :display_as  => "Output"

    output :error,
           :description => "Error from git",
           :display_as  => "Errors"
    display :always
  end
end
action 'deploy', :description => "Deploy a specific environment, and its Puppetfile specified modules" do
  input :environment,
        :prompt => "Specific environment",
        :description => "Deploy a particular environment",
        :type => :string,
        # Wanted to rubyize the following regex but didn't have time to test: ^(?!/|.*([/.]\.|//|@\{|\\\\))[^\040\177 ~^:?*\[]+(?<!\.lock|[/.])$
        :validation => '.',
        :optional => true,
        :maxlength => 256 
  
  output :environment,
         :description => "Deploy a particular environment",
         :display_as  => "Specific environment"
  
  output :output,
         :description => "Output from r10k",
         :display_as  => "Output"
  
  output :error,
         :description => "Error from r10k",
         :display_as  => "Errors"
  
  display :always
end
# vim: set syntax=ruby:
