class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination
  include Finder

  field :title,             type: String
  field :heading,           type: String
  field :category,          type: String
  field :published_at,      type: Date
  field :description,       type: String
  field :original_filename, type: String
  field :information,       type: Hash
  field :fontspecs,         type: Hash, default: {}
  field :last_analysis_at,  type: Time
  field :processed_text,    type: String
  field :state,             type: Symbol, default: :waiting
  field :public,            type: Boolean, default: false
  field :percentage,        type: Integer, default: 0
  field :file_id,           type: Moped::BSON::ObjectId
  field :thumbnail_file_id, type: Moped::BSON::ObjectId

  belongs_to :project

  has_many :pages
  has_many :fact_registers
  has_many :named_entities
  has_and_belongs_to_many :people, index: true

  validates_presence_of :file_id
  validates_presence_of :original_filename

  after_create  :enqueue_process
  after_destroy :destroy_gridfs_files

  scope :public, -> { where(public: true) }

  include Tire::Model::Search
  include Tire::Model::Callbacks

  tire do
    mapping do
      indexes :title,   analyzer: "snowball", boost: 100
      indexes :heading, analyzer: "snowball", boost: 100
      indexes :pages,   analyzer: "snowball"
    end
  end

  def to_indexed_json
    fields = {
      title: title,
      heading: heading,
      pages: {},
    }
    pages.each do |page|
      fields[:pages][page.num] = page.text.gsub(/<[^<]+?>/, "")
    end
    fields.to_json
  end


  def file
    if file_id
      Mongoid::GridFS.namespace_for(:documents).get(file_id)
    end
  end

  def file=(file_or_path)
    fs = Mongoid::GridFS.namespace_for(:documents).put(file_or_path)
    self.file_id = fs.id
    fs
  end

  def thumbnail_file
    if thumbnail_file_id
      Mongoid::GridFS.namespace_for(:thumbnails).get(thumbnail_file_id)
    end
  end

  def thumbnail_file=(file_or_path)
    fs = Mongoid::GridFS.namespace_for(:thumbnails).put(file_or_path)
    self.thumbnail_file_id = fs.id
    fs
  end

  def readable?
    true
  end

  def geocoded?
    true
  end

  def exportable?
    true
  end

  def processed?
    true
  end

  def completed?
    percentage == 100
  end

protected
  def enqueue_process
    logger.info "Enqueue processing task for document with id #{id}"
    Resque.enqueue(DocumentProcessBootstrapTask, id)
  end

  def destroy_gridfs_files
    file.destroy
    thumbnail_file.destroy
  end
end
