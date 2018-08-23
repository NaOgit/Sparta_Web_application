class PostsController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new {File.join(root, 'views')}

  configure :development do
    register Sinatra::Reloader
  end

  $posts = [{
      id:0,
      title: 'Post 0',
      post_body: 'This is the initial post'
    },
    {
      id:1,
      title: 'Post 1',
      post_body: 'This is the first post'
    },
    {
      id:2,
      title: 'Post 2',
      post_body: 'This is the second post'
    },
    {
      id:2,
      title: 'Post 3',
      post_body: 'This is the third post'
    }
  ]

  # Separation concerns
  get "/" do
    @title = "Blog Posts"
    @post = $posts
    # erb => go look for the layout field first
    # Apply the template
    erb :'posts/index'
    # "test"
  end

  get "/new" do
    @title = "New post"

    @post = {
      id: "",
      title: "",
      post_body: ""
    }
    erb :'posts/new'
  end

  post "/" do
    puts params
    # Assign new posts
    new_post = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }

    $posts.push(new_post)

    redirect "/"
    "New added"
  end

  get "/:id" do
    id = params[:id].to_i
    @post = $posts[id]
    # erb => go look for the layout field first
    # Apply the template
    erb :'posts/show'
  end

  get "/:id/edit" do
    id = params[:id].to_i
    @post = $posts[id]
    @title = "Edit Post"
    erb :'posts/edit'
  end

  put "/:id" do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:post_body] = params[:post_body]

    redirect '/'
  end

  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)

    redirect "/"

  end

end
