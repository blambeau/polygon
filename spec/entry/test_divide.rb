require 'spec_helper'
module Polygon
  describe Entry, 'divide' do

    let(:entry){ Entry.new(Path.dir, Path.dir) }

    subject{ entry / path }

    context "when it stays inside the root" do
      let(:path){ "somewhere/somefile.yml" }
      it 'should return an Entry instance' do
        subject.should be_a(Entry)
      end
      it 'should return the correct instance' do
        subject.path.should eq(Path.dir / "somewhere/somefile.yml")
      end
    end

    context "when it exits the root" do
      let(:path){ "../somefile.yml" }
      it 'should return nil' do
        subject.should be_nil
      end
    end

  end
end