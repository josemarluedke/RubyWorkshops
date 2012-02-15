#Encoding: UTF-8
require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test "validates presence of name" do
    client = Client.new name: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:name].any?
  end
  
  test "validates presence of email" do
    client = Client.new email: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  
  test "validates format of email" do
    client = Client.new email: "invalid"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  
  test "validates uniqueness of email" do
    create_client
    client = Client.new email: "john@gmail.com"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:email].any?
  end
  
  test "validates inclusion of state" do
    client = Client.new state: 'xx'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:state].any?
  end
  
  test "validates numericality of age" do
    client = Client.new age: "not a number"
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:age].any?
  end
  
  test "validates minimum age" do
    client = Client.new age: 17
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:age].any?
  end
  
  test "validates confirmation of password - nil" do
    client = Client.new password: 'hgf654^%$', password_confirmation: nil
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password_confirmation].any?
  end
  
  test "validates confirmation of password - wrong" do
    client = Client.new password: 'hgf654^%$', password_confirmation: 'wrong'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
  end
  
  test "validates strenght of password" do
    client = Client.new password: '111111', password_confirmation: '111111'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "too weak", client.errors[:password].first
  end
  
  test "validates length of password" do
    client = Client.new password: 'jhbds', password_confirmation: 'jhbds'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
  end

  test "validates sequence of password with numbers" do
    client = Client.new password: '123456', password_confirmation: '123456'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "don't use sequences", client.errors[:password].first
  end
  
  test "validates sequence of password with characters" do
    client = Client.new password: 'abcdef', password_confirmation: 'abcdef'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "don't use sequences", client.errors[:password].first
  end
  
  test "validates lack of numbers" do
    client = Client.new password: 'ksjffjA!', password_confirmation: 'ksjffjA!'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "use numbers, special characters and capital letters", client.errors[:password].first
  end
  
  test "validates lack of special characters" do
    client = Client.new password: 'ksjffjA1', password_confirmation: 'ksjffjA1'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "use numbers, special characters and capital letters", client.errors[:password].first
  end

  test "validates lack of capital letters" do
    client = Client.new password: 'ksjffj!1', password_confirmation: 'ksjffj!1'
    assert ! client.valid?, "client should be invalid"
    assert client.errors[:password].any?
    assert_equal "use numbers, special characters and capital letters", client.errors[:password].first
  end
  
  test "should be valid" do
    client = create_client
    assert client.valid?, "client should be valid"
  end
  
  def create_client
    Client.create! name: "John",
      email: "john@gmail.com",
      password: 'treA543%$#',
      password_confirmation: 'treA543%$#'
  end
end