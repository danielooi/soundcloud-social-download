class PostsController < ApplicationController
  
  def new
    
    @user = {}
    
    if logged_in("facebook")
      
      result = Facebook.new(session[:facebook]).class.get('/me')
      
      @user["name"], @user["picture"] = result["name"], "https://graph.facebook.com/#{result["id"]}/picture"
      
    elsif logged_in("twitter")
      
      @access_token = OAuth::AccessToken.new(consumer("twitter"), session[:twitter][:token], session[:twitter][:secret])
      
      result = Crack::JSON.parse(@access_token.get('/account/verify_credentials.json').body)
      
      @user["name"], @user["picture"] = result["name"], result["profile_image_url"]
      
    end
    
  end

  def create
    
    flash[:notice] = params[:post]
    
    redirect_to root_path
    
=begin

#puts @access_token.post('/statuses/update.json', {:status => "testing 1 2 3"})

response = Facebook.new(session[:facebook]).class.post('/me/feed', 
  :query => {
    :message => "testing social download",
    #:picture => @product.image("compact"),
    :link => root_url,
    :name => "social download"
    #:caption
    #:description
  }
)

=end    
    
  end

end
