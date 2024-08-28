require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    user = User.create!(email: 'test@example.com', password: 'password')
    post = Post.new(title: 'Test Title', content: 'Test Content', user: user)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = Post.new(title: nil)
    expect(post).not_to be_valid
  end

  it 'is not valid without content' do
    post = Post.new(content: nil)
    expect(post).not_to be_valid
  end
end
