require 'json'
require 'rest-client'

class Reflecticle
  URL = "http://www.reflecticle.com/api/"
  def initialize(api_key)
    @api_key = api_key
    @site = RestClient::Resource.new(URL)
  end

  def log(message)
    project_id, project_name = find_project(message)

    # Assume the project is the first set of words in the message
    if project_name
      message = message.sub(/#{project_name} /, '')
    end

    if project_id < 0
      puts "Project not found!"
    else
      params = { :api_key => @api_key, :project_id => project_id,
                 :description => message }
      @site['activities/create'].post(params)
    end
  end

  def projects
    return @projects if @projects

    raw_projects = @site['projects'].get(:params => {:api_key => @api_key})
    @projects = JSON.parse(raw_projects)
  end

  def find_project(message)
    project = projects.find {|project| message.match(/#{project['name']}/i) }

    if project
      return project['id'], message.match(/#{project['name']}/i).to_s
    end
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
