require 'csv'

module DocumentExporter
  def export_people
    export(:people_found,
           %w{ _id document_id text lemma tag prob pos sentence_pos })
  end

  def export_dates
    export(:dates_found,
           %w{ _id document_id text lemma tag prob pos sentence_pos time })
  end

  def export_places
    export([:places_found, :addresses_found],
           %w{ _id document_id text lemma tag prob pos sentence_pos lat lng })
  end

  def export_organizations
    export(:organizations_found,
           %w{ _id document_id text lemma tag prob pos sentence_pos })
  end

private
  def export(finders, keys)
    finders = Array(finders)
    CSV.generate do |csv|
      csv << keys
      finders.each do |finder|
        self.public_send(finder).only(*keys).each do |ne|
          csv << keys.map { |k| ne.public_send(k) }
        end
      end
    end
  end
end
