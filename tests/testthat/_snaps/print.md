# print_outliers

    Code
      print(filtred_v1)
    Output
      -- 2 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
                                   v1           v2    v3 v12 v13  v14  v15
      Mazda RX4           -0.56047565 -50.00000000  TRUE   A   A <NA>    I
      Mazda RX4 Wag       -0.23017749  32.00000000  TRUE   A   A    C <NA>
      Datsun 710           1.55870831   0.66076974  TRUE   A   A    D <NA>
      Hornet 4 Drive       0.07050839  -2.05298300  TRUE   A   A    B    I
      Hornet Sportabout    0.12928774  -1.49920605  TRUE   A   A    A    I
      Valiant              1.71506499   1.47123312  TRUE   A   A    A    I
      Duster 360           0.46091621   1.45913853  TRUE   A   A    D <NA>
      Merc 240D           -1.26506123   0.14013904  TRUE   A   A <NA>    I
      Merc 230            -0.68685285   0.20918439  TRUE   A   A    A    K
      Merc 280            -0.44566197  -3.03608982  TRUE   A   A    A <NA>
      Merc 280C            1.22408180  -0.48693413  TRUE   B   A    D    I
      Merc 450SE           0.35981383  -1.08786731  TRUE   B   A <NA>    J
      Merc 450SL           0.40077145   0.05785971  TRUE   B   A <NA> <NA>
      Merc 450SLC          0.11068272   1.10397550  TRUE   B   B <NA>    I
      Cadillac Fleetwood  -0.55584113  -0.02561697  TRUE   B   B    A    L
      Lincoln Continental  1.78691314   0.51484639  TRUE   C   B <NA> <NA>
      Chrysler Imperial    0.49785048   0.99005668  TRUE   C   B    A    I
      Fiat 128            -1.96661716   0.30345432  TRUE   C   B <NA> <NA>
      Honda Civic          0.70135590  -0.93007223  TRUE   C   B    A    I
      Toyota Corolla      -0.47279141   0.08403068  TRUE   C   B <NA> <NA>
      Toyota Corona       -1.06782371   0.52677963  TRUE   C   B <NA>    L
      Dodge Challenger    -0.21797491   0.01586862  TRUE   C   B    D <NA>
      AMC Javelin         -1.02600445   0.20535184  TRUE   C   B    A <NA>
      Camaro Z28          -0.72889123   1.01628335  TRUE   C   B    A    I
      Pontiac Firebird    -0.62503927   0.40899897  TRUE   C   B <NA> <NA>
      Fiat X1-9           -1.68669331  -0.70523547  TRUE   C   C <NA>    L
      Porsche 914-2        0.83778704   0.23561433  TRUE   C   D <NA>    I
      Lotus Europa         0.15337312   0.34513003  TRUE   C   D    A    L
      Ford Pantera L      -1.13813694  -1.01979955  TRUE   C   D    D    L
      Volvo 142E                   NA   0.87310493 FALSE   E   E    A    I

---

    Code
      print(filtred_v2)
    Output
      -- 2 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
      Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
      Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
                                     v1          v2    v3 v12 v13  v14  v15
      Datsun 710             1.55870831  0.66076974  TRUE   A   A    D <NA>
      Hornet 4 Drive         0.07050839 -2.05298300  TRUE   A   A    B    I
      Hornet Sportabout      0.12928774 -1.49920605  TRUE   A   A    A    I
      Valiant                1.71506499  1.47123312  TRUE   A   A    A    I
      Duster 360             0.46091621  1.45913853  TRUE   A   A    D <NA>
      Merc 240D             -1.26506123  0.14013904  TRUE   A   A <NA>    I
      Merc 230              -0.68685285  0.20918439  TRUE   A   A    A    K
      Merc 280              -0.44566197 -3.03608982  TRUE   A   A    A <NA>
      Merc 280C              1.22408180 -0.48693413  TRUE   B   A    D    I
      Merc 450SE             0.35981383 -1.08786731  TRUE   B   A <NA>    J
      Merc 450SL             0.40077145  0.05785971  TRUE   B   A <NA> <NA>
      Merc 450SLC            0.11068272  1.10397550  TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.55584113 -0.02561697  TRUE   B   B    A    L
      Lincoln Continental    1.78691314  0.51484639  TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.49785048  0.99005668  TRUE   C   B    A    I
      Fiat 128              -1.96661716  0.30345432  TRUE   C   B <NA> <NA>
      Honda Civic            0.70135590 -0.93007223  TRUE   C   B    A    I
      Toyota Corolla        -0.47279141  0.08403068  TRUE   C   B <NA> <NA>
      Toyota Corona         -1.06782371  0.52677963  TRUE   C   B <NA>    L
      Dodge Challenger      -0.21797491  0.01586862  TRUE   C   B    D <NA>
      AMC Javelin           -1.02600445  0.20535184  TRUE   C   B    A <NA>
      Camaro Z28            -0.72889123  1.01628335  TRUE   C   B    A    I
      Pontiac Firebird      -0.62503927  0.40899897  TRUE   C   B <NA> <NA>
      Fiat X1-9             -1.68669331 -0.70523547  TRUE   C   C <NA>    L
      Porsche 914-2          0.83778704  0.23561433  TRUE   C   D <NA>    I
      Lotus Europa           0.15337312  0.34513003  TRUE   C   D    A    L
      Ford Pantera L        -1.13813694 -1.01979955  TRUE   C   D    D    L
      Ferrari Dino        -100.00000000 -1.41182225  TRUE   C   D    A <NA>
      Maserati Bora        100.00000000 -1.36384225  TRUE   D   D    A    I
      Volvo 142E                     NA  0.87310493 FALSE   E   E    A    I

---

    Code
      print(filtred_v3)
    Output
      -- 1 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
      Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
                                     v1           v2   v3 v12 v13  v14  v15
      Mazda RX4             -0.56047565 -50.00000000 TRUE   A   A <NA>    I
      Mazda RX4 Wag         -0.23017749  32.00000000 TRUE   A   A    C <NA>
      Datsun 710             1.55870831   0.66076974 TRUE   A   A    D <NA>
      Hornet 4 Drive         0.07050839  -2.05298300 TRUE   A   A    B    I
      Hornet Sportabout      0.12928774  -1.49920605 TRUE   A   A    A    I
      Valiant                1.71506499   1.47123312 TRUE   A   A    A    I
      Duster 360             0.46091621   1.45913853 TRUE   A   A    D <NA>
      Merc 240D             -1.26506123   0.14013904 TRUE   A   A <NA>    I
      Merc 230              -0.68685285   0.20918439 TRUE   A   A    A    K
      Merc 280              -0.44566197  -3.03608982 TRUE   A   A    A <NA>
      Merc 280C              1.22408180  -0.48693413 TRUE   B   A    D    I
      Merc 450SE             0.35981383  -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL             0.40077145   0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC            0.11068272   1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.55584113  -0.02561697 TRUE   B   B    A    L
      Lincoln Continental    1.78691314   0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.49785048   0.99005668 TRUE   C   B    A    I
      Fiat 128              -1.96661716   0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic            0.70135590  -0.93007223 TRUE   C   B    A    I
      Toyota Corolla        -0.47279141   0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona         -1.06782371   0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger      -0.21797491   0.01586862 TRUE   C   B    D <NA>
      AMC Javelin           -1.02600445   0.20535184 TRUE   C   B    A <NA>
      Camaro Z28            -0.72889123   1.01628335 TRUE   C   B    A    I
      Pontiac Firebird      -0.62503927   0.40899897 TRUE   C   B <NA> <NA>
      Fiat X1-9             -1.68669331  -0.70523547 TRUE   C   C <NA>    L
      Porsche 914-2          0.83778704   0.23561433 TRUE   C   D <NA>    I
      Lotus Europa           0.15337312   0.34513003 TRUE   C   D    A    L
      Ford Pantera L        -1.13813694  -1.01979955 TRUE   C   D    D    L
      Ferrari Dino        -100.00000000  -1.41182225 TRUE   C   D    A <NA>
      Maserati Bora        100.00000000  -1.36384225 TRUE   D   D    A    I

---

    Code
      print(filtred_v1_omit)
    Output
      -- NA Outliers were removed of 32 rows. ----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
                                   v1           v2   v3 v12 v13  v14  v15
      Mazda RX4           -0.56047565 -50.00000000 TRUE   A   A <NA>    I
      Mazda RX4 Wag       -0.23017749  32.00000000 TRUE   A   A    C <NA>
      Datsun 710           1.55870831   0.66076974 TRUE   A   A    D <NA>
      Hornet 4 Drive       0.07050839  -2.05298300 TRUE   A   A    B    I
      Hornet Sportabout    0.12928774  -1.49920605 TRUE   A   A    A    I
      Valiant              1.71506499   1.47123312 TRUE   A   A    A    I
      Duster 360           0.46091621   1.45913853 TRUE   A   A    D <NA>
      Merc 240D           -1.26506123   0.14013904 TRUE   A   A <NA>    I
      Merc 230            -0.68685285   0.20918439 TRUE   A   A    A    K
      Merc 280            -0.44566197  -3.03608982 TRUE   A   A    A <NA>
      Merc 280C            1.22408180  -0.48693413 TRUE   B   A    D    I
      Merc 450SE           0.35981383  -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL           0.40077145   0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC          0.11068272   1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood  -0.55584113  -0.02561697 TRUE   B   B    A    L
      Lincoln Continental  1.78691314   0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial    0.49785048   0.99005668 TRUE   C   B    A    I
      Fiat 128            -1.96661716   0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic          0.70135590  -0.93007223 TRUE   C   B    A    I
      Toyota Corolla      -0.47279141   0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona       -1.06782371   0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger    -0.21797491   0.01586862 TRUE   C   B    D <NA>
      AMC Javelin         -1.02600445   0.20535184 TRUE   C   B    A <NA>
      Camaro Z28          -0.72889123   1.01628335 TRUE   C   B    A    I
      Pontiac Firebird    -0.62503927   0.40899897 TRUE   C   B <NA> <NA>
      Fiat X1-9           -1.68669331  -0.70523547 TRUE   C   C <NA>    L
      Porsche 914-2        0.83778704   0.23561433 TRUE   C   D <NA>    I
      Lotus Europa         0.15337312   0.34513003 TRUE   C   D    A    L
      Ford Pantera L      -1.13813694  -1.01979955 TRUE   C   D    D    L

---

    Code
      print(filtred_v_all_omit)
    Output
      -- NA Outliers were removed of 32 rows. ----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
                                   v1          v2   v3 v12 v13  v14  v15
      Datsun 710           1.55870831  0.66076974 TRUE   A   A    D <NA>
      Hornet 4 Drive       0.07050839 -2.05298300 TRUE   A   A    B    I
      Hornet Sportabout    0.12928774 -1.49920605 TRUE   A   A    A    I
      Valiant              1.71506499  1.47123312 TRUE   A   A    A    I
      Duster 360           0.46091621  1.45913853 TRUE   A   A    D <NA>
      Merc 240D           -1.26506123  0.14013904 TRUE   A   A <NA>    I
      Merc 230            -0.68685285  0.20918439 TRUE   A   A    A    K
      Merc 280            -0.44566197 -3.03608982 TRUE   A   A    A <NA>
      Merc 280C            1.22408180 -0.48693413 TRUE   B   A    D    I
      Merc 450SE           0.35981383 -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL           0.40077145  0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC          0.11068272  1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood  -0.55584113 -0.02561697 TRUE   B   B    A    L
      Lincoln Continental  1.78691314  0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial    0.49785048  0.99005668 TRUE   C   B    A    I
      Fiat 128            -1.96661716  0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic          0.70135590 -0.93007223 TRUE   C   B    A    I
      Toyota Corolla      -0.47279141  0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona       -1.06782371  0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger    -0.21797491  0.01586862 TRUE   C   B    D <NA>
      AMC Javelin         -1.02600445  0.20535184 TRUE   C   B    A <NA>
      Camaro Z28          -0.72889123  1.01628335 TRUE   C   B    A    I
      Pontiac Firebird    -0.62503927  0.40899897 TRUE   C   B <NA> <NA>
      Fiat X1-9           -1.68669331 -0.70523547 TRUE   C   C <NA>    L
      Porsche 914-2        0.83778704  0.23561433 TRUE   C   D <NA>    I
      Lotus Europa         0.15337312  0.34513003 TRUE   C   D    A    L
      Ford Pantera L      -1.13813694 -1.01979955 TRUE   C   D    D    L

---

    Code
      print(filterd_everything)
    Output
      -- 9 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
                                  v1          v2   v3 v12 v13  v14  v15
      Datsun 710           1.5587083  0.66076974 TRUE   A   A    D <NA>
      Hornet Sportabout    0.1292877 -1.49920605 TRUE   A   A    A    I
      Valiant              1.7150650  1.47123312 TRUE   A   A    A    I
      Duster 360           0.4609162  1.45913853 TRUE   A   A    D <NA>
      Merc 240D           -1.2650612  0.14013904 TRUE   A   A <NA>    I
      Merc 280            -0.4456620 -3.03608982 TRUE   A   A    A <NA>
      Merc 280C            1.2240818 -0.48693413 TRUE   B   A    D    I
      Merc 450SL           0.4007715  0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC          0.1106827  1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood  -0.5558411 -0.02561697 TRUE   B   B    A    L
      Lincoln Continental  1.7869131  0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial    0.4978505  0.99005668 TRUE   C   B    A    I
      Fiat 128            -1.9666172  0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic          0.7013559 -0.93007223 TRUE   C   B    A    I
      Toyota Corolla      -0.4727914  0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona       -1.0678237  0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger    -0.2179749  0.01586862 TRUE   C   B    D <NA>
      AMC Javelin         -1.0260044  0.20535184 TRUE   C   B    A <NA>
      Camaro Z28          -0.7288912  1.01628335 TRUE   C   B    A    I
      Pontiac Firebird    -0.6250393  0.40899897 TRUE   C   B <NA> <NA>
      Porsche 914-2        0.8377870  0.23561433 TRUE   C   D <NA>    I
      Lotus Europa         0.1533731  0.34513003 TRUE   C   D    A    L
      Ford Pantera L      -1.1381369 -1.01979955 TRUE   C   D    D    L

---

    Code
      print(filter_v12)
    Output
      -- 2 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
                                     v1           v2   v3 v12 v13  v14  v15
      Mazda RX4             -0.56047565 -50.00000000 TRUE   A   A <NA>    I
      Mazda RX4 Wag         -0.23017749  32.00000000 TRUE   A   A    C <NA>
      Datsun 710             1.55870831   0.66076974 TRUE   A   A    D <NA>
      Hornet 4 Drive         0.07050839  -2.05298300 TRUE   A   A    B    I
      Hornet Sportabout      0.12928774  -1.49920605 TRUE   A   A    A    I
      Valiant                1.71506499   1.47123312 TRUE   A   A    A    I
      Duster 360             0.46091621   1.45913853 TRUE   A   A    D <NA>
      Merc 240D             -1.26506123   0.14013904 TRUE   A   A <NA>    I
      Merc 230              -0.68685285   0.20918439 TRUE   A   A    A    K
      Merc 280              -0.44566197  -3.03608982 TRUE   A   A    A <NA>
      Merc 280C              1.22408180  -0.48693413 TRUE   B   A    D    I
      Merc 450SE             0.35981383  -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL             0.40077145   0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC            0.11068272   1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.55584113  -0.02561697 TRUE   B   B    A    L
      Lincoln Continental    1.78691314   0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.49785048   0.99005668 TRUE   C   B    A    I
      Fiat 128              -1.96661716   0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic            0.70135590  -0.93007223 TRUE   C   B    A    I
      Toyota Corolla        -0.47279141   0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona         -1.06782371   0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger      -0.21797491   0.01586862 TRUE   C   B    D <NA>
      AMC Javelin           -1.02600445   0.20535184 TRUE   C   B    A <NA>
      Camaro Z28            -0.72889123   1.01628335 TRUE   C   B    A    I
      Pontiac Firebird      -0.62503927   0.40899897 TRUE   C   B <NA> <NA>
      Fiat X1-9             -1.68669331  -0.70523547 TRUE   C   C <NA>    L
      Porsche 914-2          0.83778704   0.23561433 TRUE   C   D <NA>    I
      Lotus Europa           0.15337312   0.34513003 TRUE   C   D    A    L
      Ford Pantera L        -1.13813694  -1.01979955 TRUE   C   D    D    L
      Ferrari Dino        -100.00000000  -1.41182225 TRUE   C   D    A <NA>

---

    Code
      print(filter_v13)
    Output
      -- 2 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
      Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
                                     v1           v2   v3 v12 v13  v14  v15
      Mazda RX4             -0.56047565 -50.00000000 TRUE   A   A <NA>    I
      Mazda RX4 Wag         -0.23017749  32.00000000 TRUE   A   A    C <NA>
      Datsun 710             1.55870831   0.66076974 TRUE   A   A    D <NA>
      Hornet 4 Drive         0.07050839  -2.05298300 TRUE   A   A    B    I
      Hornet Sportabout      0.12928774  -1.49920605 TRUE   A   A    A    I
      Valiant                1.71506499   1.47123312 TRUE   A   A    A    I
      Duster 360             0.46091621   1.45913853 TRUE   A   A    D <NA>
      Merc 240D             -1.26506123   0.14013904 TRUE   A   A <NA>    I
      Merc 230              -0.68685285   0.20918439 TRUE   A   A    A    K
      Merc 280              -0.44566197  -3.03608982 TRUE   A   A    A <NA>
      Merc 280C              1.22408180  -0.48693413 TRUE   B   A    D    I
      Merc 450SE             0.35981383  -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL             0.40077145   0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC            0.11068272   1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.55584113  -0.02561697 TRUE   B   B    A    L
      Lincoln Continental    1.78691314   0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.49785048   0.99005668 TRUE   C   B    A    I
      Fiat 128              -1.96661716   0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic            0.70135590  -0.93007223 TRUE   C   B    A    I
      Toyota Corolla        -0.47279141   0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona         -1.06782371   0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger      -0.21797491   0.01586862 TRUE   C   B    D <NA>
      AMC Javelin           -1.02600445   0.20535184 TRUE   C   B    A <NA>
      Camaro Z28            -0.72889123   1.01628335 TRUE   C   B    A    I
      Pontiac Firebird      -0.62503927   0.40899897 TRUE   C   B <NA> <NA>
      Porsche 914-2          0.83778704   0.23561433 TRUE   C   D <NA>    I
      Lotus Europa           0.15337312   0.34513003 TRUE   C   D    A    L
      Ford Pantera L        -1.13813694  -1.01979955 TRUE   C   D    D    L
      Ferrari Dino        -100.00000000  -1.41182225 TRUE   C   D    A <NA>
      Maserati Bora        100.00000000  -1.36384225 TRUE   D   D    A    I

---

    Code
      print(filter_v14)
    Output
      -- 2 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
      Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
      Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
                                    v1           v2    v3 v12 v13  v14  v15
      Mazda RX4             -0.5604756 -50.00000000  TRUE   A   A <NA>    I
      Datsun 710             1.5587083   0.66076974  TRUE   A   A    D <NA>
      Hornet Sportabout      0.1292877  -1.49920605  TRUE   A   A    A    I
      Valiant                1.7150650   1.47123312  TRUE   A   A    A    I
      Duster 360             0.4609162   1.45913853  TRUE   A   A    D <NA>
      Merc 240D             -1.2650612   0.14013904  TRUE   A   A <NA>    I
      Merc 230              -0.6868529   0.20918439  TRUE   A   A    A    K
      Merc 280              -0.4456620  -3.03608982  TRUE   A   A    A <NA>
      Merc 280C              1.2240818  -0.48693413  TRUE   B   A    D    I
      Merc 450SE             0.3598138  -1.08786731  TRUE   B   A <NA>    J
      Merc 450SL             0.4007715   0.05785971  TRUE   B   A <NA> <NA>
      Merc 450SLC            0.1106827   1.10397550  TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.5558411  -0.02561697  TRUE   B   B    A    L
      Lincoln Continental    1.7869131   0.51484639  TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.4978505   0.99005668  TRUE   C   B    A    I
      Fiat 128              -1.9666172   0.30345432  TRUE   C   B <NA> <NA>
      Honda Civic            0.7013559  -0.93007223  TRUE   C   B    A    I
      Toyota Corolla        -0.4727914   0.08403068  TRUE   C   B <NA> <NA>
      Toyota Corona         -1.0678237   0.52677963  TRUE   C   B <NA>    L
      Dodge Challenger      -0.2179749   0.01586862  TRUE   C   B    D <NA>
      AMC Javelin           -1.0260044   0.20535184  TRUE   C   B    A <NA>
      Camaro Z28            -0.7288912   1.01628335  TRUE   C   B    A    I
      Pontiac Firebird      -0.6250393   0.40899897  TRUE   C   B <NA> <NA>
      Fiat X1-9             -1.6866933  -0.70523547  TRUE   C   C <NA>    L
      Porsche 914-2          0.8377870   0.23561433  TRUE   C   D <NA>    I
      Lotus Europa           0.1533731   0.34513003  TRUE   C   D    A    L
      Ford Pantera L        -1.1381369  -1.01979955  TRUE   C   D    D    L
      Ferrari Dino        -100.0000000  -1.41182225  TRUE   C   D    A <NA>
      Maserati Bora        100.0000000  -1.36384225  TRUE   D   D    A    I
      Volvo 142E                    NA   0.87310493 FALSE   E   E    A    I

---

    Code
      print(filter_v1213)
    Output
      -- 4 Outliers were removed of 32 rows. -----------------------------------------
      
                           mpg cyl  disp  hp drat    wt  qsec vs am gear carb
      Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
      Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
      Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
      Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
      Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
      Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
      Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
      Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
      Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
      Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
      Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
      Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
      Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
      Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
      Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
      Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
      Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
      Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
      Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
      Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
      AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
      Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
      Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
      Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
      Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
      Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
      Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
      Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
                                    v1           v2   v3 v12 v13  v14  v15
      Mazda RX4             -0.5604756 -50.00000000 TRUE   A   A <NA>    I
      Datsun 710             1.5587083   0.66076974 TRUE   A   A    D <NA>
      Hornet Sportabout      0.1292877  -1.49920605 TRUE   A   A    A    I
      Valiant                1.7150650   1.47123312 TRUE   A   A    A    I
      Duster 360             0.4609162   1.45913853 TRUE   A   A    D <NA>
      Merc 240D             -1.2650612   0.14013904 TRUE   A   A <NA>    I
      Merc 230              -0.6868529   0.20918439 TRUE   A   A    A    K
      Merc 280              -0.4456620  -3.03608982 TRUE   A   A    A <NA>
      Merc 280C              1.2240818  -0.48693413 TRUE   B   A    D    I
      Merc 450SE             0.3598138  -1.08786731 TRUE   B   A <NA>    J
      Merc 450SL             0.4007715   0.05785971 TRUE   B   A <NA> <NA>
      Merc 450SLC            0.1106827   1.10397550 TRUE   B   B <NA>    I
      Cadillac Fleetwood    -0.5558411  -0.02561697 TRUE   B   B    A    L
      Lincoln Continental    1.7869131   0.51484639 TRUE   C   B <NA> <NA>
      Chrysler Imperial      0.4978505   0.99005668 TRUE   C   B    A    I
      Fiat 128              -1.9666172   0.30345432 TRUE   C   B <NA> <NA>
      Honda Civic            0.7013559  -0.93007223 TRUE   C   B    A    I
      Toyota Corolla        -0.4727914   0.08403068 TRUE   C   B <NA> <NA>
      Toyota Corona         -1.0678237   0.52677963 TRUE   C   B <NA>    L
      Dodge Challenger      -0.2179749   0.01586862 TRUE   C   B    D <NA>
      AMC Javelin           -1.0260044   0.20535184 TRUE   C   B    A <NA>
      Camaro Z28            -0.7288912   1.01628335 TRUE   C   B    A    I
      Pontiac Firebird      -0.6250393   0.40899897 TRUE   C   B <NA> <NA>
      Fiat X1-9             -1.6866933  -0.70523547 TRUE   C   C <NA>    L
      Porsche 914-2          0.8377870   0.23561433 TRUE   C   D <NA>    I
      Lotus Europa           0.1533731   0.34513003 TRUE   C   D    A    L
      Ford Pantera L        -1.1381369  -1.01979955 TRUE   C   D    D    L
      Ferrari Dino        -100.0000000  -1.41182225 TRUE   C   D    A <NA>

---

    Code
      print(filter_fct)
    Output
      -- 5 Outliers were removed of 32 rows. -----------------------------------------
      
      # A tibble: 27 x 18
           mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb     v1
       * <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
       1  21       6  160    110  3.9   2.62  16.5     0     1     4     4 -0.560
       2  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1  1.56 
       3  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2  0.129
       4  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1  1.72 
       5  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4  0.461
       6  24.4     4  147.    62  3.69  3.19  20       1     0     4     2 -1.27 
       7  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2 -0.687
       8  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4 -0.446
       9  17.8     6  168.   123  3.92  3.44  18.9     1     0     4     4  1.22 
      10  16.4     8  276.   180  3.07  4.07  17.4     0     0     3     3  0.360
      # i 17 more rows
      # i 6 more variables: v2 <dbl>, v3 <lgl>, v12 <fct>, v13 <chr>, v14 <chr>,
      #   v15 <fct>

