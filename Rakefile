require 'rbconfig'

def unix?
  RbConfig::CONFIG['host_os'] =~ /(aix|darwin|linux|(net|free|open)bsd|cygwin|solaris|irix|hpux)/i
end

def windows?
  RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw|[Ww]indows)!
end

#TODO check for updates of spell files, then add task to default
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

# rake --silent curl_for_win > <path to git>/cmd/curl.cmd
task :curl_for_win do
  require 'net/http'
  require 'net/https'
  
  http = Net::HTTP.new('gist.github.com', 443)
  http.use_ssl = true
  path = '/raw/904906/2753fc4ad996d00bbe09f7af9faceb8e98433722/curl.cmd'
  
  resp, data = http.get(path, nil)
  puts data
end

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
        ln_s(File.expand_path("../#{file}", __FILE__), dest)
      elsif windows?
        mklink(dest, File.expand_path("../#{file}", __FILE__))
      end
    end
  end
end

desc "Pull the latest"
task :pull do
  system "git pull"
end

task :update do
  system "git submodule update --init"
end

task :default => [:update, :link_vimrc]

desc "Upgrade"
task :upgrade => [:pull, :default]
