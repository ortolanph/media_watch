# Movies Validations

## Description

System must show checks for the imported movies:

1. `CHECK_EMPTY_TAGS`
    1. Empty `Tags` field
    2. Symbol: Stop Sign 🛑
    3. When the `Tags` field is empty
2. `CHECK_TAGS_FORMAT`
    1. `Tags` field is not on format
    2. Symbol: YELLOW 🟡
    3. `Tags` format is: `key1:value1, key2:value2`
3. `CHECK_UNIQUE_SOURCE_TAG`
    1. `Tags` field should contain and should contain only one `source` tag
    2. Symbol: ORANGE 🟠
    3. `Tags` invalid example: `source:stream1, source:stream2`
4. `CHECK_UNIQUE_TMDB_ID_TAG`
    1. `Tags` field should contain and should contain only one `tmdb_id` tag
    2. Symbol: PURPLE 🟣
    3. `Tags` invalid example: `tmdb_id:123, tmdb_id:456`
5. `CHECK_NO_GENRE_TAG`
    1. `Tags` field should contain at least one `genre` tag
    2. Symbol: RED Exclamation ❗
    3. `Tags` invalid example: `source:stream1, tmdb_id:456`

Create a button to show a popup to display the list of check symbols.

Put a tip on the movie explaining the failed check.

## Examples

```csv
Date,Name,Year,Letterboxd URI,Rating,Rewatch,Tags,Watched Date
2014-01-29,Jabberwocky,1977,https://boxd.it/2tt2L,4,,,2014-01-28
2015-08-03,The Amazing Spider-Man,2012,https://boxd.it/6wKfT,4,,"netflix,action,comics",2015-08-02
2014-02-02,Circular,2011,https://boxd.it/2uZln,4,,"source:alternative, source:netflix, genre:sci-fi, tmdb_id:235178",2014-02-01
2021-06-27,Argo,2012,https://boxd.it/1X4ItN,5,,"genre:drama, tmdb_id:235178",2021-06-24
2022-01-26,The Last Duel,2021,https://boxd.it/2wkmDt,5,,"source:disney+, genre:drama, genre:historical",2022-01-24
2023-04-21,Parasite,2019,https://boxd.it/495Gen,5,,"genre:comedy, genre:drama, genre:thriller, genre:horror, source:max, tmdb_id:496243, tmdb_id:496243",2023-04-20
2016-12-19,Rogue One: A Star Wars Story,2016,https://boxd.it/cC50f,5,,"genre:sci-fi, tmdb_id:330459",2016-12-15
2024-01-18,Killers of the Flower Moon,2023,https://boxd.it/5CAzWX,5,,"source:appletv, genre:drama, genre:crime, adaptation:facts, adaptation:book, tmdb_id:466420",2024-01-18
```

Results:

* Line 1: CHECK_EMPTY_TAGS
* Line 2: CHECK_TAGS_FORMAT
* Line 3: CHECK_UNIQUE_SOURCE_TAG
* Line 4: CHECK_UNIQUE_SOURCE_TAG
* Line 5: CHECK_UNIQUE_TMDB_ID_TAG
* Line 6: CHECK_UNIQUE_TMDB_ID_TAG
* Line 7: CHECK_NO_GENRE_TAG
* Line 8: OK

## Acceptance Criteria

1. Code is clean
2. Tests are implemented and passing
3. Refer to `media000-spec.md` for additional requirements
