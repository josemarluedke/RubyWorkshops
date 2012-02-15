class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, format: {with: /\w+@gmail\.com/}, uniqueness: true
  validates :state, inclusion: { in: %w[rs sp rj], allow_nil: true }
  validates :age, numericality: { greater_than: 17, only_integer: true, allow_nil: true }
  validates :password, presence: true, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, :presence => true
  
  validate :strength_of_password
  def strength_of_password
    return unless password
    if password.count(password[0]) == password.length
      errors.add(:password, "too weak")
    end
    if password == (password[0]..password[password.size-1]).to_a.join('')
      errors.add(:password, "don't use sequences")
    end
    
    if not password =~ /\d/ or not password =~ /[A-Z]/ or not password =~ /!|@|#|\$|%|&|\*/
      errors.add(:password, "use numbers, special characters and capital letters")
    end
  end
end