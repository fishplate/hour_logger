# Class to archive all hours for month given
class ProcessHours

  def self.process(date)
    month = date.month
    year = date.year
    collection = UserHour.get_date("01/#{month}/#{year}")
    archive_collection(collection)
  end

private

  def self.archive_collection(collection)
    return if collection.empty?
    collection.each {|hour| hour.update_attributes(archived: true)}
  end

end