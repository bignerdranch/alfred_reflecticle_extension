require 'spec_helper'

describe Reflecticle do
  let(:api_key)      { 'key' }
  let(:project_name) { 'Project' }
  let(:project_id)   { 1 }
  let(:reflecticle)  { Reflecticle.new(api_key) }

  describe '#log' do
    it 'logs to Reflecticle' do
      message_content = "Message!"
      full_message = "#{project_name} #{message_content}"
      activities_create = "#{Reflecticle::URL}/activities/create.json"
      params = { :api_key => api_key, :project_id => project_id, :description => message_content }
      reflecticle.stub(:find_project).with(full_message).and_return([project_id, project_name])
      RestClient::Resource.any_instance.should_receive(:post).with(params)

      reflecticle.log(full_message)
    end
  end

  describe '#find_project' do
    it 'searches Reflecticle projects by message and returns a project name and ID' do
      projects = [
                   { 'name' => 'Highgroove',  'id' => 5 },
                   { 'name' => project_name,  'id' => project_id },
                   { 'name' => 'Reflecticle', 'id' => 500 }
                 ].to_json
      RestClient::Resource.any_instance.should_receive(:get).with(:params => {:api_key => api_key}).and_return(projects)

      message = "#{project_name} message!"
      reflecticle.find_project(message).should eq [project_id, project_name]
    end
  end

  describe '.api_key=' do
    it "creates & writes to the users home directory with the API key" do
      pending "WTF Ruby can't create the file!? WHY"
      Reflecticle.api_key = api_key

      File.open(File.expand_path('~/.reflecticle')) do |file|
        key = file.read
        key.should eq api_key
      end
    end
  end

  describe '.api_key' do
    it "reads the API key from the home directory" do
      pending "WTF Ruby can't create the file!? WHY"
      File.open(File.expand_path('~/.reflecticle'), 'w') do |file|
        file << api_key
      end

      Reflecticle.api_key.should eq api_key
    end
  end
end
