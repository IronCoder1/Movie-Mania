# Movie-Mania

 STORYBOARD BASIC TASKS
 // create scene for the movie search view
 here the user is trying to search a film by title so he/she can check it out
 my must haves:
 
 1.search bar (UITEXTFIELD)
 
 2.  buttons to: A. must watch, B. history (uibutton)
 
 3. mini view showing poster thumbnail and basic movie details in a (uitablEview + custom cell)
 
 
 NEXT
 
 Create detail view scene
 Here the user is trying to view all the vital details for a film title
 my must haves:
 
 1. film poster (uiimageview)
 2. full movie details (uilabel(s))
 3. add to must much button (uibutton)
 
 CODING TASKS
 movie search scene
 
 1. create vc class for scene
 2.1 wire uitextfield , send text to url composer
 2.2 method to download data from json: compose url, start session, download task, serialize data, hanlde errors: [download errors, serialization errors and bad title errors].
 3. model movie class based on data required in view(s).
 4. pass movie data to movie object properties
 5. display mini details in tableview // this is isnt working currently debugging
 6. on selecting row, display detail view (perfom segue on didselect row)
 
 7. method to add film to must watch.
 7.1. add to mustwatch array
  7.2 load array in must have view
 8.1 save selected  for history view -> add to history array
  8.2 using nscoding  archive  history array
    8.3 use nsuser defaults to save and reload


*/
