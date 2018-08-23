class PostsController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new {File.join(root, 'views')}

  configure :development do
    register Sinatra::Reloader
  end

  $posts = [{
      id:0,
      title: 'Widdershins',
      speech: 'adverb',
      definition: "In a direction contrary to the sun's course, considered as unlucky; anticlockwise."
    },
    {
      id:1,
      title: 'Accouchement',
      origin: "Late 18th century: French, from accoucher ‘act as midwife’, from a- (from Latin ad ‘to, at’) + coucher ‘put to bed’.",
      speech: 'noun',
      definition: "The action of giving birth to a baby."
    },
    {
      id:2,
      title: 'Bibliopole',
      origin: "Late 18th century: via Latin from Greek bibliopōlēs, from biblion ‘book’ + pōlēs ‘seller’.",
      speech: 'noun',
      definition: "A person who buys and sells books, especially rare ones."
    },
    {
      id:3,
      title: 'Carl',
      origin: "Old English (denoting a peasant or villein): from Old Norse karl ‘man, freeman’, of Germanic origin; related to churl.",
      speech: 'noun',
      definition: "A peasant or man of low birth."
    },
    {
      id:4,
      title: 'Dandiprat',
      origin: "Early 16th century (denoting a coin worth three halfpence): of unknown origin.",
      speech: 'noun',
      definition: "A young or insignificant person."
    }
  ]

  get "/words" do
    @title = "Blog Posts"
    @post = $posts
    erb :'posts/index'
  end

  get "/words/new" do
    @title = "New post"

    @post = {
      id: "",
      title: "",
      origin: "",
      speech: "",
      definition: ""
    }
    erb :'posts/new'
  end

  post "/words" do
    puts params
    new_post = {
      id: $posts.length,
      title: params[:title],
      origin: params[:origin],
      speech: params[:speech],
      definition: params[:definition]
    }

    $posts.push(new_post)

    redirect "/words"

  end

  get "/words/:id" do
    id = params[:id].to_i
    @post = $posts[id]
    erb :'posts/show'
  end

  get "/words/:id/edit" do
    id = params[:id].to_i
    @post = $posts[id]
    @title = "Edit Post"
    erb :'posts/edit'
  end

  put "/words/:id" do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:origin] = params[:origin]
    post[:speech] = params[:speech]
    post[:definition] = params[:definition]

    redirect '/words'
  end

  delete "/words/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)

    redirect "/words"

  end

end
