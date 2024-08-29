require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all posts to @posts" do
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new post" do
        expect {
          post :create, params: { post: { title: "New Post", content: "Content", user_id: user.id } }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post :create, params: { post: { title: "New Post", content: "Content", user_id: user.id } }
        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new post" do
        expect {
          post :create, params: { post: { title: nil, content: "Content", user_id: user.id } }
        }.not_to change(Post, :count)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid parameters" do
      it "updates the requested post" do
        patch :update, params: { id: post.id, post: { title: "Updated Title" } }
        post.reload
        expect(post.title).to eq("Updated Title")
      end

      it "redirects to the post" do
        patch :update, params: { id: post.id, post: { title: "Updated Title" } }
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid parameters" do
      it "renders the edit template" do
        patch :update, params: { id: post.id, post: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post_to_delete = create(:post, user: user)
      expect {
        delete :destroy, params: { id: post_to_delete.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "POST #like" do
    it "creates a like for the post" do
      expect {
        post :like, params: { id: post.id }
      }.to change(post.likes, :count).by(1)
    end

    it "redirects to the post" do
      post :like, params: { id: post.id }
      expect(response).to redirect_to(post)
    end
  end

  describe "POST #dislike" do
    before do
      post.likes.create(user: user)
    end

    it "removes a like from the post" do
      expect {
        post :dislike, params: { id: post.id }
      }.to change(post.likes, :count).by(-1)
    end

    it "redirects to the post" do
      post :dislike, params: { id: post.id }
      expect(response).to redirect_to(post)
    end
  end
end
