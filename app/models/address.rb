class Address < ActiveRecord::Base

  def self.valid_categories
    ["Home", "School", "Work", "Vacation", "Travel"]
  end

  belongs_to :user
  has_many :subscriptions
  validates :line1, :state, :city, :zip ,:presence => true 
  validate :correct_category
  validate :one_per_category

  before_validation :set_default_category_to_home

  private

  def correct_category
    unless self.class.valid_categories.include?(self.category)
      self.errors.add(:category, "is invalid. Valid categories are: #{self.class.valid_categories.to_sentence}")
    end
  end

  def one_per_category
    duplicates = user.addresses.select{|addr| addr.category == category}

    unless duplicates.empty?
      self.errors.add(:category, "You already have an address with the #{category} category!")
    end
  end

  def set_default_category_to_home
    self.category ||= "Home"
  end
end
