# frozen_string_literal: true

class SeedData::Refresher
  def self.refresh!
    return if @refreshed

    # Fix any bust caches post initial migration
    # Not that reset_column_information is not thread safe so we have to becareful
    # not to run it concurrently within the same process.
    ActiveRecord::Base.connection.tables.each do |table|
      table.classify.constantize.reset_column_information rescue nil
    end

    @refreshed = true
  end
end

SeedData::Refresher.refresh!
SiteSetting.refresh!
