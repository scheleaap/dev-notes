# Exif

Notes:
* AllDates is a shortcut for 3 tag names: DateTimeOriginal, CreateDate and ModifyDate.

What | How | Notes
--- | --- | ---
Set date/time | `exiftool "-alldates=2011:03:14 12:34:56"`
Set date/time based on filename | `exiftool "-alldates<filename"`
Rename files based on date/time (with format, counter and lower-cased extension) | `exiftool "-filename<DateTimeOriginal" -d "%Y%m%d_%H%M%S%%-c.%%le"` | https://www.joelotz.com/blog/2022/bulk-rename-photos-to-date-taken-with-exiftool.html
Set file create/modify date based on EXIF data | `exiftool "-FileCreateDate<DateTimeOriginal" "-FileModifyDate<DateTimeOriginal"`
