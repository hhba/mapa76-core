require "spec_helper"

describe Document do
  describe "export to CSV" do
    before do
      @document = create :document
      @person1 = create :person
      @person2 = create :person
      @person3 = create :person
      @person1.documents << @document
      @person2.documents << @document
      @person3.documents << @document

      name_entity = create :name_entity, document: @document
      date_entity = create :date_entity, document: @document
      action_entity = create :action_entity, document: @document

      @register = create :fact_register, {
        document: @document,
        person_ids: [name_entity.id],
        action_ids: [action_entity.id],
        date_id: date_entity.id
      }
    end

    it "should generate CSV with all the people" do
      assert_respond_to @document, :to_csv
      assert_instance_of String, @document.to_csv
    end

    it "should export registers as CSV"
  end
end
