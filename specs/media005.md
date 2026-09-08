# Importing Movies from CSV

## Description

User must be able to add Movies from CSV file. This file is from Letterboxd site and contains the
following format:

```csv
Date,Name,Year,Letterboxd URI,Rating,Rewatch,Tags,Watched Date
2025-07-23,Renfield,2023,https://boxd.it/arfzJ9,4,,"source:netflix, genre:action, genre:comedy, genre:horror, tmdb_id:649609",2025-07-18
2025-07-23,The Amateur,2025,https://boxd.it/arfVBB,3.5,,"source:disney+, genre:thriller, genre:action, genre:drama, tmdb_id:1087891",2025-07-19
2025-07-23,The Beekeeper,2024,https://boxd.it/arg4cF,3,,"source:primevideo, genre:action, genre:drama, tmdb_id:866398",2025-07-22
2025-08-03,Deep Cover,2025,https://boxd.it/azTQZP,3,,"source:nextflix, tmdb_id:1239193, genre:action, genre:comedy",2025-07-22
2025-08-07,The Internship,2013,https://boxd.it/aDdymH,3.5,,"source:netflix, genre:comedy, tmdb_id:116741",2025-08-04
```

Where:

* `Date`: is the Letterboxd entry date
* `Name`: is the movie name
* `Year`: is the year the movie was watched
* `Letterboxd URI`: is the link to my review on Letterboxd
* `Rating`: is the rating that I gave to the movie on this entry
* `Rewatch`: is whether I have rewatched the movie (Yes or null)
* `Tags`: are the tags associated with the movie
* `Watched Date`: is the date I watched the movie

If there are previous data inputted, all the data must be deleted.

System must be able to display a link to the review, so the user can access it on a new tab on a
browser.

As movies are editable only on Letterboxd, there is no option to edit the movie. The Movie card
should contain all data. The value of the `Tags` field should be visible on a popup dialog. The
`Tags` field may be `null`.

## Acceptance Criteria

1. Code is clean
2. Tests are implemented and passing
3. Refer to `media000.md` for additional requirements
