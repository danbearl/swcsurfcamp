module PaypalLogin
  @@login = ''
  @@password = ''
  @@signature = ''

  def self.login=(value)
    @@login = value
  end

  def self.login
    @@login
  end

  def self.password=(value)
    @@password = value
  end

  def self.password
    @@password
  end

  def self.signature=(value)
    @@signature = value
  end

  def self.signature
    @@signature
  end

end
