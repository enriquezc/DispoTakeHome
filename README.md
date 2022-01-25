# DispoTakeHome

### Chosen Approach

As a broad overview, I decided to implement MVVM in this take home, despite it being a little bit overkill in some spots. I used Alamofire to make my endpoint calls, to simplify some of the work around URLSession, and then used the existing structs provided to inform what data was pertinent where. I also used a singleton as my network layer to ensure all my network calls were being handled by the same object and could be more accessible by both view models.

### Further Work

If I were to continue working on this project, I would implement testing across the whole. Since I chose to go with MVVM, this would be relatively easy, since I can make simple tests for both view models, that make behavior very easy to mock. In addition, I could mock my GIFNetworkLayer, and then use that to write additional tests. Finally, I would implement some sort of messaging to the user should there be any bad values returned from the server. 