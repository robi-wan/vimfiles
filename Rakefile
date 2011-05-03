require 'rbconfig'

def unix?
  RbConfig::CONFIG['host_os'] =~ /(aix|darwin|linux|(net|free|open)bsd|cygwin|solaris|irix|hpux)/i
end

def windows?
  RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw|[Ww]indows)!
end

desc "download spell files"
task :spell_files do
  dest = File.expand_path("~/.vim/bundle/spellfiles/spell")
  FileUtils.mkdir_p(dest) unless File.exist?(dest)
  FileUtils.cd(dest) do  
    #lang = %w[ de ]
    #enc = %w[ latin1 utf-8 ]
    #suffix = %w[ spl sug ]
    require 'net/ftp'
    Net::FTP.open('ftp.nluug.nl') do |ftp|
      ftp.login
      files = ftp.chdir('pub/vim/runtime/spell')
      %w[ de.latin1.spl de.latin1.sug de.utf-8.spl de.utf-8.sug ].each do |file|
      #lang.product(enc, suffix).each do |f| 
        #file = f.join(".")
        puts file
        ftp.getbinaryfile(file)
      end
    end
  end
end

# rake --silent install_curl > <path to git>/cmd/curl.cmd
task :curl_for_win do
  require 'net/http'
  require 'net/https'
  
  http = Net::HTTP.new('gist.github.com', 443)
  http.use_ssl = true
  path = '/raw/904906/2753fc4ad996d00bbe09f7af9faceb8e98433722/curl.cmd'
  
  resp, data = http.get(path, nil)
  puts data
end

module VIM
  Dirs = %w[ after autoload doc plugin ruby snippets syntax ftdetect ftplugin colors indent ]
end

def vim_plugin_task(name, repo=nil, dir=nil)
  cwd = File.expand_path("../", __FILE__)
  dir = File.expand_path("tmp/#{name}") unless dir
  subdirs = VIM::Dirs

  namespace(name) do
    if repo
      file dir => "tmp" do
        if repo =~ /git$/
          sh "git clone #{repo} #{dir}"

        elsif repo =~ /download_script/
          if filename = `curl --silent --head #{repo} | grep attachment`[/filename=(.+)/,1]
            filename.strip!
            sh "curl #{repo} > tmp/#{filename}"
          else
            raise ArgumentError, 'unable to determine script type'
          end

        elsif repo =~ /(tar|gz|vba|zip)$/
          filename = File.basename(repo)
          sh "curl #{repo} > tmp/#{filename}"

        else
          raise ArgumentError, 'unrecognized source url for plugin'
        end

        case filename
        when /zip$/
          sh "unzip -o tmp/#{filename} -d #{dir}"

        when /tar\.gz$/
          dirname  = File.basename(filename, '.tar.gz')

          sh "tar zxvf tmp/#{filename}"
          sh "mv #{dirname} #{dir}"

        when /vba(\.gz)?$/
          if filename =~ /gz$/
            sh "gunzip -f tmp/#{filename}"
            filename = File.basename(filename, '.gz')
          end

          # TODO: move this into the install task
          mkdir_p dir
          lines = File.readlines("tmp/#{filename}")
          current = lines.shift until current =~ /finish$/ # find finish line

          while current = lines.shift
            # first line is the filename (possibly followed by garbage)
            # some vimballs use win32 style path separators
            path = current[/^(.+?)(\t\[{3}\d)?$/, 1].gsub '\\', '/'

            # then the size of the payload in lines
            current = lines.shift
            num_lines = current[/^(\d+)$/, 1].to_i

            # the data itself
            data = lines.slice!(0, num_lines).join

            # install the data
            Dir.chdir dir do
              mkdir_p File.dirname(path)
              File.open(path, 'w'){ |f| f.write(data) }
            end
          end
        end
      end

      task :pull => dir do
        if repo =~ /git$/
          Dir.chdir dir do
            sh "git pull"
          end
        end
      end

      task :install => [:pull] do
      #task :install => [:pull] + subdirs do
        #Dir.chdir dir do
          #if File.exists?("Rakefile") and `rake -T` =~ /^rake install/
            #sh "rake install"
          #elsif File.exists?("install.sh")
            #sh "sh install.sh"
          #else
            #subdirs.each do |subdir|
              #if File.exists?(subdir)
                #sh "cp -rf #{subdir}/* #{cwd}/#{subdir}/"
              #end
            #end
          #end
        #end

        yield if block_given?
      end
    else
      task :install do
      #task :install => subdirs do
        yield if block_given?
      end
    end
  end

  desc "Install #{name} plugin"
  task name do
    puts
    puts "*" * 40
    puts "*#{"Installing #{name}".center(38)}*"
    puts "*" * 40
    puts
    Rake::Task["#{name}:install"].invoke
  end
  task :default => name
end


vim_plugin_task("vundle" , "http://github.com/gmarik/vundle.git", File.expand_path("~/.vim/vundle.git") )  



def mklink(link, target)
  [ link, target ].each { |path| path.gsub!("/","\\") }
  system("cmd /c mklink #{link} #{target}")
end

desc "link vimrc to ~/.vimrc"
task :link_vimrc do
  prefix = "."
  prefix = "_" if windows? 
  %w[ vimrc gvimrc ].each do |file|
    dest = File.expand_path("~/#{prefix}#{file}")
    unless File.exist?(dest)
      if unix?
        #ln_s(File.expand_path("../#{file}", __FILE__), dest)
        ln_s(File.expand_path("~/#{file}"), dest)
      elsif windows?
        mklink(dest, File.expand_path("~/#{file}"))
      end
    end
  end
end

desc "Pull the latest"
task :pull do
  system "git pull"
end

task :default => [:link_vimrc]

desc "Upgrade"
task :upgrade => [:pull, :default]
