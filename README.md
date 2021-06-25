# GlobalLocatorLib

- GL (Global Locator) code is Base 32, 2 digits can locate a state, 4 digits can locate a county, 6 digits can locate a street block, 8 digits can locate a house, and 10 digits can locate a person location anywhere in the earth.

- GL code uses the format X0Y0X1Y1X2Y2X3Y3, as X0X1X2X3 is the GL Base 32 mapping of the longitude, and Y0Y1Y2Y3 is the GL Base 32 mapping of the latitude.

- GL locations starts from the south pole, from the Pacific ocean, hence California starts with `5` (x axis), then the more east you go and the higher the number, e.g., Florida starts with `8`, Cairo `K`, and China, `U`.

- GL uses the alphanumeric characters except ["A", "I", "L", "O"]

- GL code is case insensitive, i.e. it can be in small letters or in capital letters.

- GL codes can enable sorting by location, as e.g. locations in most of California starts with `5Q`, while Florida locations starts with `8N`

- The difference between Florida and California is 3 digits and the difference in time zone is 3 hours, which means the difference in GL digits can give indication of roughly how much difference in time zone and distance. One digit different from the left is about 750 miles.
