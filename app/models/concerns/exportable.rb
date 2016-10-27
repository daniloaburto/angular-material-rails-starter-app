module Exportable
  extend ActiveSupport::Concern
 
  module ClassMethods

    # Method that exports model records to a csv formatted file
    def to_csv options = {}

      # Set attributes to be written
      attributes = self::ATTRS ||= column_names

      # Generating csv file
      CSV.generate options do |csv|       

        # Column names using locale
        csv << attributes.map { |a| a.in?(["id", "created_at", "updated_at"]) ? I18n.t(a, scope: [:activerecord, :others]) : I18n.t("#{name.underscore}.#{a}", scope: [:activerecord, :attributes]) }

        # Column values for each resource
        all.each do |record|
          csv << attributes.map do |attr|
            attr_value = record.send(attr)

            if attr_value.instance_of? ActiveSupport::TimeWithZone
              I18n.l attr_value, format: :db    # Format dd-mm-yyyy HH:MM

            elsif attr_value.instance_of? Date
              I18n.l attr_value                 # Format dd-mm-yyyy

            elsif attr_value.instance_of? Time
              I18n.l attr_value, format: :time  # Format HH:MM

            elsif attr_value.instance_of? TrueClass
              I18n.t 'boolean_true', scope: [:activerecord, :others]

            elsif attr_value.instance_of? FalseClass
              I18n.t 'boolean_false', scope: [:activerecord, :others]

            else
              attr_value
            end

          end
        end
      end
    end
  end
end