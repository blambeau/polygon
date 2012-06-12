require 'spec_helper'
describe Path, "core extensions" do

  def load(file)
    (fixtures_path / "data" / file).load
  end

  it 'loads json correctly' do
    load('data.json').should eq("kind" => "json")
  end

  it 'loads yaml correctly' do
    load('data.yaml').should eq("kind" => "yaml")
    load('data.yml').should eq("kind" => "yml")
  end

  it 'loads ruby correctly' do
    load('data.ruby').should eq("kind" => "ruby")
    load('data.rb').should eq("kind" => "rb")
  end

  it 'load .md correctly, when no front matter' do
    load('text.md').should eq("content" => "This is the text")
  end

  it 'load .md correctly, when a front matter' do
    load('data.md').should eq("kind" => "md", "content" => "This is the text")
  end

end