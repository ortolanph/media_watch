# Import and Export TV Shows from/to CSV

## Description

User must be able to add TVShows from CSV file. The CSV file must have the following format:

```csv
show,season,yearWatched,source,tmdb_id,kind
Wonderman,1,2026,Disney+,198178,regular
The Office,1,2026,SkyShowTime,2316,regular
The Office,2,2026,SkyShowTime,2316,regular
The Office,3,2026,Disney+,2316,regular
The Office,4,2026,Disney+,2316,regular
The Office,5,2026,Disney+,2316,regular
The Office,6,2026,Disney+,2316,regular
The Office,7,2026,Disney+,2316,regular
The Office,8,2026,Disney+,2316,regular
The Office,9,2026,Disney+,2316,regular
"Star Wars: Maul - Shadow Lord",1,2026,Disney+,289219,limited
Daredevil: Born Again,2,2026,Disney+,202555,regular
X-Men'97,2,2026,Disney+,138502,regular
Silo,3,2026,Apple TV,125988,regular
Batman: Caped Crusader,2,2026,Amazon Prime Video,125909,regular
"Star Wars: Visions Presents - The Ninth Jedi",1,2026,Disney+,289324,limited
"Star Trek: Strange New Worlds",4,2025,SkyShowTime,103516,regular
```

User must be able to export data to CSV in the same format.

If there are previous data inputted, all the data must be deleted.

## Secondary feature

User must be able to copy a show to clipboard into CSV format.

## Acceptance Criteria

1. Code is clean
2. Tests are implemented and passing
3. Refer to `tv000-spec.md` for additional requirements
