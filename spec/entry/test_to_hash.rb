require 'spec_helper'
module Polygon
  describe Entry, 'to_hash' do

    let(:fixtures){ Entry.new(fixtures_path, "") }

    subject{ entry.to_hash }

    context 'on with_index_yml/say-hello.md' do
      let(:entry){ fixtures / "with_index_yml/say-hello.md" }
      it 'should take all data along ancestors' do
        expected = {
          "title"    => "Say Hello",
          "content"  => "# How to Say Hello to World?\n\nThis way!\n",
          "keywords" => ["say-hello", "with_index_yml/index.yml", "root"]
        }
        subject.should eq(expected)
      end
    end

  end
end