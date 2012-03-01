require 'json'

class Reflecticle
  URL = "http://www.reflecticle.com/api/"
  def initialize(api_key)
    @api_key = api_key
    @site = RestClient::Resource.new(URL)
  end

  def log(project, message)
    project_id = find_project_id(project)
    if project_id < 0
      puts "Project not found!"
    else
      params = { :api_key => @api_key, :project_id => project_id,
                 :description => message }
      @site['activities/create'].post(params)
    end
  end

  def find_project_id(project_name)
    raw_projects = @site['projects'].get(:params => {:api_key => @api_key})
    projects = JSON.parse(raw_projects)

    projects.each do |project|
      if project['name'] == project_name
        return project['id']
      end
    end

    id
  end

  def self.api_key=(key)
    File.open(File.expand_path('~/.reflecticle'), 'w') do |f|
      f << key
    end
  end

  def self.api_key
    api_key = ''
    begin
      File.open(File.expand_path('~/.reflecticle'), 'r') do |f|
        api_key = f.read.chomp
      end
    rescue Errno::ENOENT
      missing_key!
    end

    if api_key == ''
      missing_key!
    end

    api_key
  end

  def self.missing_key!
    puts "Please put your API key in ~/.reflecticle"
    exit
  end
end
