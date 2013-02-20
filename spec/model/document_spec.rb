require "spec_helper"

describe Document do
  before do
    @document = create :document
  end

  describe "after_save" do
    it "should enqueue process bootstrap task" do
      skip "need Mocha"
      document = build :document
      Resque.expects(:enqueue).with(DocumentProcessBootstrapTask)
      assert document.save
    end
  end

  describe "validation" do
    it "should have a `file_id` defined" do
      @document.file_id = nil
      refute @document.valid?
    end

    it "should have an `original_filename` defined" do
      @document.original_filename = nil
      refute @document.valid?
    end
  end

  describe "#file=" do
    it "should upload the given file to GridFS and set #file_id" do
      @document.file_id = nil
      @document.file = StringIO.new("a different file\n")
      refute @document.file_id.nil?
      assert_equal "a different file\n", @document.file.data
    end
  end

  describe "#file" do
    it "should return nil if #file_id is nil" do
      @document.file_id = nil
      assert @document.file.nil?
    end

    it "should return the file from GridFS" do
      assert_equal @document.file.id, @document.file_id
      assert_equal "empty content", @document.file.data
    end
  end

  describe "#thumbnail_file=" do
    it "should upload the given thumbnail file to GridFS and set #thumbnail_file_id" do
      @document.thumbnail_file_id = nil
      @document.thumbnail_file = StringIO.new("a different file\n")
      refute @document.thumbnail_file_id.nil?
      assert_equal "a different file\n", @document.thumbnail_file.data
    end
  end

  describe "#thumbnail_file" do
    it "should return nil if #thumbnail_file_id is nil" do
      @document.thumbnail_file_id = nil
      assert @document.thumbnail_file.nil?
    end

    it "should return the thumbnail file from GridFS" do
      @document.thumbnail_file = StringIO.new("thumbnail")
      assert_equal @document.thumbnail_file.id, @document.thumbnail_file_id
      assert_equal "thumbnail", @document.thumbnail_file.data
    end
  end
end
