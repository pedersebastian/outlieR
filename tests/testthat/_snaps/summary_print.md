# summary_nofail

    Code
      summary(filtred_v1)
    Output
      +-----------------------------------------+
      |                                         |
      |   2 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v1       |dbl           |Yes            |          2|6.5 %     |        1|

---

    Code
      summary(filtred_v2)
    Output
      +-----------------------------------------+
      |                                         |
      |   2 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v2       |dbl           |Yes            |          2|6.2 %     |        0|

---

    Code
      summary(filtred_v3)
    Output
      +-----------------------------------------+
      |                                         |
      |   1 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v3       |lgl           |Yes            |          1|3.1 %     |        0|

---

    Code
      summary(filtred_v1_omit)
    Output
      +------------------------------------------+
      |                                          |
      |   NA Outliers were removed of 32 rows.   |
      |                                          |
      +------------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v1       |dbl           |Yes            |          2|6.5 %     |        1|

---

    Code
      summary(filtred_v_all_omit)
    Output
      +------------------------------------------+
      |                                          |
      |   NA Outliers were removed of 32 rows.   |
      |                                          |
      +------------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v1       |dbl           |Yes            |          2|6.5 %     |        1|
      |v2       |dbl           |Yes            |          2|6.2 %     |        0|
      |v3       |lgl           |Yes            |          1|3.1 %     |        0|

---

    Code
      summary(filterd_everything)
    Output
      +-----------------------------------------+
      |                                         |
      |   9 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |mpg      |dbl           |No             |          0|          |        0|
      |cyl      |dbl           |No             |          0|          |        0|
      |disp     |dbl           |No             |          0|          |        0|
      |hp       |dbl           |No             |          0|          |        0|
      |drat     |dbl           |No             |          0|          |        0|
      |wt       |dbl           |No             |          0|          |        0|
      |qsec     |dbl           |No             |          0|          |        0|
      |vs       |dbl           |No             |          0|          |        0|
      |am       |dbl           |No             |          0|          |        0|
      |gear     |dbl           |No             |          0|          |        0|
      |carb     |dbl           |Yes            |          1|3.1 %     |        0|
      |v1       |dbl           |Yes            |          2|6.5 %     |        1|
      |v2       |dbl           |Yes            |          2|6.2 %     |        0|
      |v3       |lgl           |Yes            |          1|3.1 %     |        0|
      |v12      |fct           |Yes            |          2|6.2 %     |        0|
      |v13      |chr           |Yes            |          2|6.2 %     |        0|
      |v14      |chr           |Yes            |          3|10 %      |       12|
      |v15      |fct           |Yes            |          3|10 %      |       12|

---

    Code
      summary(filter_v12)
    Output
      +-----------------------------------------+
      |                                         |
      |   2 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v12      |fct           |Yes            |          2|6.2 %     |        0|

---

    Code
      summary(filter_v13)
    Output
      +-----------------------------------------+
      |                                         |
      |   2 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v13      |chr           |Yes            |          2|6.2 %     |        0|

---

    Code
      summary(filter_v14)
    Output
      +-----------------------------------------+
      |                                         |
      |   2 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v14      |chr           |Yes            |          3|10 %      |       12|

---

    Code
      summary(filter_v1213)
    Output
      +-----------------------------------------+
      |                                         |
      |   4 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v12      |fct           |Yes            |          2|6.2 %     |        0|
      |v14      |chr           |Yes            |          3|10 %      |       12|

---

    Code
      summary(filter_fct)
    Output
      +-----------------------------------------+
      |                                         |
      |   5 Outliers were removed of 32 rows.   |
      |                                         |
      +-----------------------------------------+
      
      -- Summary Table of outliers ---------------------------------------------------
      
      
      |Variable |Variable Type |Outlier Exist? | N Outliers|% Outlier | N of NAs|
      |:--------|:-------------|:--------------|----------:|:---------|--------:|
      |v12      |fct           |Yes            |          2|6.2 %     |        0|
      |v13      |chr           |Yes            |          2|6.2 %     |        0|
      |v14      |chr           |Yes            |          3|10 %      |       12|

