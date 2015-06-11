Rails.application.routes.draw do
   
  #----------------------------------------------------------------------------------------------------------
  #                             Routes of User API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'users/userLogin'=>'users#userLogin'
  post 'users/userSignUp'=>'users#userSignUp'
  post 'users/updateProfile'=>'users#updateProfile'

  

  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Post API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'posts/getPostById'=>'posts#getPostById'
  post 'posts/getContentByTopic'=>'posts#getContentByTopic'
  post 'posts/getHomeContent'=>'posts#getHomeContent'
  post 'posts/getUserPost'=>'posts#getUserPost'
  post 'posts/uploadStatus'=>'posts#uploadStatus'
  post 'posts/getUserBeam'=>'posts#getUserBeam'
  post 'posts/getMyChannel'=>'posts#getMyChannel'
  post 'posts/likeComment'=>'posts#likeComment'
  post 'posts/postLike'=>'posts#postLike'
  post 'posts/getTrendingVideos'=>'posts#getTrendingVideos'



  


  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Friend API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'friends/deleteFriend'=>'friends#deleteFriend'
  post 'friends/acceptFriendRequest'=>'friends#acceptFriendRequest'
  post 'friends/sendFriendRequest'=>'friends#sendFriendRequest'
  post 'friends/deleteFriendRequest'=>'friends#deleteFriendRequest'
  post 'friends/searchFriends'=>'friends#searchFriends'



   

  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Topic API`s 
  #-------------------------------------------------------------------------------------------------------------
   post 'topics/getAllTopics'=>'topics#getAllTopics'



  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Post Seen API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'post_seens/postSeen'=>'post_seens#postSeen'


  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Post Likes API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'post_likes/postLike'=>'post_likes#postLike'


  #----------------------------------------------------------------------------------------------------------
  #                             Routes of Comment Likes API`s 
  #-------------------------------------------------------------------------------------------------------------
  post 'comment_likes/likeComment'=>'comment_likes#likeComment'

 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
