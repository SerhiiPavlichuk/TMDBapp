<!-- PROJECT LOGO -->

  <p align="center">
  This is an application that shows films and TV shows that are currently in trend
  </p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About The Project](#about-the-project)
* [Features](#features)
* [Technologies Used](#technologies-used)

<!-- ABOUT THE PROJECT -->
## About The Project

Video-presentation [here](https://youtu.be/rRBmJgV-E0Y)


## Features
- Movies
   - Custom tableView with trend movies 
   - Detail movie information, with cast in custom collectionView and video
   - Add/Remove from the "Watch later" list
   
- TvShows
   - Custom tableView with trend tvShows 
   - Detail tvShows information, with video and additional info
   - Add/Remove from the "Watch later" list


## Technologies Used

* MVVM app architecture
* Parsing JSON from [TheMealDB API](https://www.themealdb.com/) and [TheCoctailDB API](https://www.thecocktaildb.com/) transforming it to fit the required model, along with persisting the data.
* Keeping a clear separation of concerns between classes (API managers, model controllers and carving datasources away from view controllers).
* Using 3rd party libraries with CocoaPods.
* RealmSwift
* Networking using Alamofire
* UISegmentedControl 
* Autolayout
* Custom UITableViews, UICollectionViews
* Animation
