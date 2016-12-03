class Profile < ActiveRecord::Base
  belongs_to :user

  validate :not_null_first_last_name, :gender_validator, :not_male_and_sue

  def not_null_first_last_name
  	if first_name.nil? && last_name.nil?
  		errors.add(:first_name, "First and last name cannot be null")
  	end
  end

  def gender_validator
  	if gender != "male" && gender != "female"
  		errors.add(:gender, "Gender should be male or female")
  	end
  end

  def not_male_and_sue
  	if gender == "male" && first_name == "Sue"
  		errors.add(:gender, "Cannot be male and Sue")
  	end
  end

  def self.get_all_profiles (min, max)
  	Profile.where("birth_year BETWEEN ? AND ?", min, max).order(birth_year: :asc).to_a
  end
end
