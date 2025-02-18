CREATE TABLE [Dim_Date] (
    [date_id] int identity(1,1) constraint PK_date primary key,
    [Release_Date] datetime,
    [release_day] int,
    [release_week] int,
    [release_month] int,
    [release_quarter] int,
    [release_year] int
)

CREATE TABLE [Dim_Adult] (
    [adult_id] int identity(1,1) constraint PK_adult primary key,
    [adult] bit constraint PK_adult primary key
)

CREATE TABLE [Dim_Runtime] (
    [runtime_id] int identity(1,1) constraint PK_runtime primary key,
    [runtime] float,
    [runtime_category] nvarchar(255)
)

CREATE TABLE [Dim_Language] (
    [language_id] int identity(1,1) constraint PK_language primary key,
    [original_language] nvarchar(255)
)

CREATE TABLE [Dim_Country] (
    [country_id] int identity(1,1) constraint PK_country primary key,
    [production_countries] nvarchar(255)
)

CREATE TABLE [Dim_Company] (
    [company_id] int identity(1,1) constraint PK_company primary key,
    [production_companies] nvarchar(255)
)

CREATE TABLE [Dim_Genre] (
    [genre_id] int identity(1,1) constraint PK_genre primary key,
    [genres] nvarchar(255)
)

CREATE TABLE [Dim_Movie] (
    [movie_id] float constraint PK_movie primary key,
    [title] nvarchar(255),
    [status] nvarchar(255),
    [homepage] nvarchar(255),
    [imdb_id] nvarchar(255),
    [tagline] nvarchar(255),
    [spoken_languages] nvarchar(255)
)

CREATE TABLE [Fact_raw] (
    [fact_id] int identity(1,1) constraint PK_fact_raw primary key,
    [movie_id] float,
    [title] nvarchar(255),
    [vote_average] float,
    [vote_count] float,
    [status] nvarchar(255),
    [release_date] datetime,
    [revenue] float,
    [runtime] float,
    [adult] bit,
    [budget] float,
    [homepage] nvarchar(255),
    [imdb_id] nvarchar(255),
    [original_language] nvarchar(255),
    [popularity] float,
    [tagline] nvarchar(255),
    [genres] nvarchar(255),
    [production_companies] nvarchar(255),
    [production_countries] nvarchar(255),
    [spoken_languages] nvarchar(255),
    [runtime_range] nvarchar(255)
)

CREATE TABLE [Fact] (
    [fact_id] int constraint PK_fact primary key,
    [date_id] int,
    [adult] bit,
    [runtime_id] int, 
    [language_id] int,
    [country_id] int,
    [company_id] int,
    [genre_id] int,
    [popularity_id] int,
    [movie_id] varchar(50),
    [vote_average] varchar(50),
    [vote_count] varchar(50),
    [revenue] varchar(50),
    [budget] varchar(50)
)

CREATE TABLE [Fact] (
    [fact_id] int,
    [date_id] int,
    [adult_id] int,
    [runtime_id] int,
    [language_id] int,
    [country_id] int,
    [company_id] int,
    [genre_id] int,
    [movie_id] float,
    [vote_average] float,
    [vote_count] float,
    [revenue] float,
    [budget] float,
    [popularity] float
)

ALTER TABLE Fact
ADD CONSTRAINT FK_date FOREIGN KEY(date_id) REFERENCES Dim_Date(date_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_adult FOREIGN KEY(adult_id) REFERENCES Dim_Adult(adult_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_runtime FOREIGN KEY(runtime_id) REFERENCES Dim_Runtime(runtime_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_language FOREIGN KEY(language_id) REFERENCES Dim_Language(language_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_country FOREIGN KEY(country_id) REFERENCES Dim_Country(country_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_company FOREIGN KEY(company_id) REFERENCES Dim_Company(company_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_genre FOREIGN KEY(genre_id) REFERENCES Dim_Genre(genre_id)

ALTER TABLE Fact
ADD CONSTRAINT FK_movie FOREIGN KEY(movie_id) REFERENCES Dim_Movie(movie_id)


ALTER TABLE Fact DROP CONSTRAINT FK_date;
ALTER TABLE Fact DROP CONSTRAINT FK_adult;
ALTER TABLE Fact DROP CONSTRAINT FK_runtime;
ALTER TABLE Fact DROP CONSTRAINT FK_language;
ALTER TABLE Fact DROP CONSTRAINT FK_country;
ALTER TABLE Fact DROP CONSTRAINT FK_company;
ALTER TABLE Fact DROP CONSTRAINT FK_genre;
ALTER TABLE Fact DROP CONSTRAINT FK_movie;

truncate table Dim_Date;
truncate table Dim_Adult;
truncate table Dim_Runtime;
truncate table Dim_Language;
truncate table Dim_Country;
truncate table Dim_Company;
truncate table Dim_Genre;
truncate table Dim_Movie;
truncate table Fact_raw;
truncate table Fact;

--Câu 1: Tổng doanh thu và ngân sách của các phim theo khoảng thời lượng chiếu.
SELECT 
    {[Measures].[Revenue], [Measures].[Budget]} ON COLUMNS,
    NONEMPTY([Dim Runtime].[Runtime Range].Children) ON ROWS
FROM 
    [TMDB Movies];

--Câu 2: Liệt kê 5 bộ phim có doanh thu cao nhất, sắp xếp theo thứ tự giảm dần.
SELECT 
    {[Measures].[Revenue]} ON COLUMNS,
    ORDER(
        TOPCOUNT(
            [Dim Movie].[Title].Children, 
            5, 
            [Measures].[Revenue]
        ), 
        [Measures].[Revenue], 
        DESC
    ) ON ROWS
FROM 
    [TMDB Movies];

--Câu 3: Thống kê 10 tên phim có ngân sách cao nhất được công chiếu vào năm 2023, sắp xếp giảm dần theo độ phổ biến.
SELECT 
    {[Measures].[Budget], [Measures].[Vote Count], [Measures].[Popularity]} ON COLUMNS,
    ORDER(
        TOPCOUNT(
            [Dim Movie].[Title].Children, 
            10, 
            [Measures].[Budget]
        ), 
        [Measures].[Popularity], 
        DESC
    ) ON ROWS
FROM 
    [TMDB Movies]
WHERE 
    [Dim Date].[Release Year].&[2023];

--Câu 4: Số lượng phim được công bố vào các quý của năm 2023.
SELECT 
    [Measures].[Number of Movies] ON COLUMNS,
    [Dim Date].[Release Quarter].Members ON ROWS
FROM 
    [TMDB Movies]
WHERE 
    [Dim Date].[Release Year].&[2023];

--Câu 5: Thống kê tên phim, số lượng bình chọn và điểm bình chọn trung bình của các bộ phim có ngân sách trên 1.5 tỷ đô la.
WITH MEMBER [Measures].[Mean Average Vote] AS 
    IIF(
        [Measures].[Number of Movies] <> 0, 
        [Measures].[Vote Average] / [Measures].[Number of Movies], 
        NULL
    )

SELECT 
    {[Measures].[Mean Average Vote], [Measures].[Vote Count]} ON COLUMNS,
    FILTER(
        [Dim Movie].[Title].Children, 
        [Measures].[Revenue] > 1500000000
    ) ON ROWS
FROM 
    [TMDB Movies];

--Câu 6: Top 3 bộ phim có ngân sách cao nhất theo 3 ngôn ngữ: Anh, Việt và Trung.
SELECT 
    [Measures].[Budget] ON COLUMNS,
    
    GENERATE(
        {
            [Dim Language].[Original Language].&[vi],
            [Dim Language].[Original Language].&[en],
            [Dim Language].[Original Language].&[cn]
        },	
        TOPCOUNT(
            [Dim Language].[Original Language].CURRENTMEMBER * 
            [Dim Movie].[Title].CHILDREN,
            3,
            [Measures].[Budget]
        ) 
    ) ON ROWS

FROM [TMDB Movies];

--Câu 7: Thống kê 2 phim phổ biến nhất có tiêu đề bắt đầu bằng ký tự “H” ở từng năm từ năm 2020 đến 2024.
SELECT 
    {[Measures].[Popularity]} ON COLUMNS,

    GENERATE(
        {[Dim Date].[Release Year].&[2020] : [Dim Date].[Release Year].&[2024]},
        
        TOPCOUNT(
            FILTER(
                [Dim Movie].[Title].Children,
                LEFT([Dim Movie].[Title].CurrentMember.Name, 1) = "H"
            ),
            2,
            [Measures].[Popularity]
        )
    ) ON ROWS

FROM [TMDB Movies];

SELECT 
    {[Measures].[Popularity]} ON COLUMNS,

    GENERATE(
        {[Dim Date].[Release Year].&[2020] : [Dim Date].[Release Year].&[2024]},
        
        CROSSJOIN(
            {[Dim Date].[Release Year].CurrentMember}, -- Thêm cột năm

            TOPCOUNT(
                FILTER(
                    [Dim Movie].[Title].Children,
                    LEFT([Dim Movie].[Title].CurrentMember.Name, 1) = "H"
                ),
                2,
                [Measures].[Popularity]
            )
        )
    ) ON ROWS

FROM [TMDB Movies];

--Câu 8: Số lượng phim, số lượng bình chọn và điểm bình chọn trung bình theo các mốc thời lượng có ngôn ngữ gốc là Anh, Trung, Việt.
WITH MEMBER [Measures].[Mean Average Vote] AS 
    IIF(
        [Measures].[Number of movies] > 0, 
        [Measures].[Vote Average] / [Measures].[Number of movies], 
        NULL
    )

SELECT 
    {[Measures].[Number of movies], [Measures].[Vote Count], [Measures].[Mean Average Vote]} ON COLUMNS,

    NONEMPTY(
        CROSSJOIN(
            [Dim Runtime].[Runtime Range].Children,
            {
                [Dim Language].[Original Language].&[vi],
                [Dim Language].[Original Language].&[en],
                [Dim Language].[Original Language].&[cn]
            }
        )
    ) ON ROWS

FROM [TMDB Movies];

---Câu 9: Tổng doanh thu của các phim được công bố từ năm 2020 đến năm 2024, thực hiện drilldown từ năm sang quý.
select [Measures].[Revenue] on columns,
drilldownlevel(
	{[Dim Date].[Date].[Release Year].&[2021]:[Dim Date].[Date].[Release Year].&[2023]}
)on rows
from [TMDB Movies];

SELECT 
    [Measures].[Revenue] ON COLUMNS,
    DRILLDOWNLEVEL(
        { [Dim Date].[Date].[Release Year].&[2020] : [Dim Date].[Date].[Release Year].&[2024] }
    ) ON ROWS
FROM 
    [TMDB Movies];

--Câu 10: Số lượt bình chọn và điểm thịnh hành của các bộ phim có ngôn ngữ gốc là tiếng Việt, tiếng Anh, có thời lượng dưới 1h công chiếu từ năm 2020 đến 2023.
SELECT 
    {[Measures].[Popularity], [Measures].[Vote Count]} ON COLUMNS,

    NONEMPTY(
        CROSSJOIN(
            {[Dim Date].[Release Year].&[2020] : [Dim Date].[Release Year].&[2023]},
            {[Dim Language].[Original Language].&[vi], [Dim Language].[Original Language].&[en]}
        )
    ) ON ROWS

FROM [TMDB Movies]

WHERE [Dim Runtime].[Runtime Range].&[under 1h];

--Câu 11: Thống kê số lượng và phần trăm các bộ phim có chi phí sản xuất lớn hơn doanh thu (gặp tình trạng lỗ) trong 5 năm gần nhất.
WITH 
    MEMBER [Measures].[Losses Movies Count] AS
        COUNT(
            FILTER(
                [Dim Movie].[Movie Id].CHILDREN,
                [Measures].[Revenue] < [Measures].[Budget]  -- Lọc các phim có doanh thu thấp hơn chi phí
            )
        )

    MEMBER [Measures].[Losses Movies Per] AS
        IIF(
            [Measures].[Number of Movies] <> 0, 
            [Measures].[Losses Movies Count] / [Measures].[Number of Movies], 
            NULL  -- Tránh lỗi chia cho 0
        )

SELECT 
    {[Measures].[Losses Movies Count], [Measures].[Number of Movies], [Measures].[Losses Movies Per]} ON COLUMNS,

    {[Dim Date].[Release Year].&[2020] : [Dim Date].[Release Year].&[2024]} ON ROWS

FROM [TMDB Movies];

--Câu 12: Thống kê số lượng phim và tổng số lượt bình chọn theo từng quý từ năm 2021 đến 2024 của hai ngôn ngữ là tiếng Anh và tiếng Việt.
SELECT 
    {[Measures].[Number of Movies], [Measures].[Vote Count]} ON COLUMNS,

    NONEMPTY(
        CROSSJOIN(
            {[Dim Date].[Release Year].&[2021] : [Dim Date].[Release Year].&[2024]}, 
            [Dim Date].[Release Quarter].CHILDREN,
            {
                [Dim Language].[Original Language].&[vi],
                [Dim Language].[Original Language].&[en]
            }
        )
    ) ON ROWS

FROM [TMDB Movies];

--Câu 13: Thống kê số lượng phim và tổng doanh thu theo từng năm từ 2021 đến 2024, phân loại theo độ tuổi người xem cho phép (trên 18 tuổi hay không).
SELECT 
    {[Measures].[Number of Movies], [Measures].[Revenue]} ON COLUMNS,

    NONEMPTY(
        CROSSJOIN(
            {[Dim Date].[Release Year].&[2021] : [Dim Date].[Release Year].&[2024]}, 
            [Dim Adult].[Adult].MEMBERS
        )
    ) ON ROWS

FROM [TMDB Movies];

--Câu 14: Top 5 các phim có lượt bình chọn thấp nhất được công chiếu trong khoảng từ năm 2021 đến 2024, có doanh thu và ngân sách lớn hơn 0.
SELECT 
    {[Measures].[Budget], [Measures].[Revenue], [Measures].[Vote Count]} ON COLUMNS,

    BOTTOMCOUNT(
        FILTER(
            NONEMPTY(
                [Dim Movie].[Title].MEMBERS * 
                {[Dim Date].[Release Year].&[2022] : [Dim Date].[Release Year].&[2024]}
            ),
            [Measures].[Budget] > 0 AND [Measures].[Revenue] > 0
        ),
        5,
        [Measures].[Vote Count]
    ) ON ROWS

FROM [TMDB Movies];

--Câu 15: Thống kê tổng số lượt bình chọn, điểm thịnh hành, tổng ngân sách của các năm có số lượng phim công chiếu lớn hơn 15,000, sắp xếp theo thứ tự giảm dần theo tổng ngân sách.
SELECT 
    {[Measures].[Popularity], [Measures].[Vote Count], [Measures].[Budget], [Measures].[Number of Movies]} ON COLUMNS,

    ORDER(
        FILTER(
            [Dim Date].[Release Year].MEMBERS, 
            [Measures].[Number of Movies] >= 15000
        ),
        [Measures].[Budget],
        DESC
    ) ON ROWS

FROM [TMDB Movies];

---

--Câu 16: Liệt kê 10 bộ phim có doanh thu cao nhất, sắp xếp theo thứ tự tăng dần.
SELECT 
    [Measures].[Revenue] ON COLUMNS,

    ORDER(
        TOPCOUNT(
            [Dim Movie].[Title].CHILDREN, 
            10, 
            [Measures].[Revenue]
        ), 
        [Measures].[Revenue], 
        ASC
    ) ON ROWS

FROM [TMDB Movies];

--Câu 17: Top 5 quốc gia có doanh thu cao nhất theo từng quý năm 2023.
SELECT
    [Dim Date].[Release Quarter].[Release Quarter].Members ON COLUMNS,
    TOPCOUNT(
        [Dim Country].[Production Countries].[Production Countries].Members,
        5,
        [Measures].[Revenue]
    ) ON ROWS
FROM [TMDB Movies]
WHERE [Dim Date].[Release Year].&[2023];

--Câu 18: Top 2 tháng có doanh thu cao nhất trong năm 2020.
SELECT  [Measures].[Revenue] on COLUMNS,
   TOPCOUNT(
        [Dim Date].[Release Month].[Release Month].members,
        2,
        [Measures].[Revenue]
    ) ON ROWS
FROM [TMDB Movies]
WHERE [Dim Date].[Release Year].&[2020];

--Câu 19: Thống kê doanh thu và số lượng phim theo quốc gia có từ 10,000 phim trở lên, sắp xếp theo doanh thu giảm dần.
SELECT 
    {[Measures].[Revenue], [Measures].[Number of Movies]} ON COLUMNS,
    
    ORDER(
        [Dim Country].[Production Countries].MEMBERS - 
        [Dim Country].[Production Countries].[All], 
        [Measures].[Revenue], 
        DESC
    )
    
    HAVING [Measures].[Number of Movies] >= 10000 
    ON ROWS

FROM [TMDB Movies];

--Câu 20: Top 3 bộ phim có lượt bình chọn cao nhất bắt đầu bằng chữ 'D' theo từng năm từ 2022 đến 2024.
SELECT 
    [Measures].[Vote Count] ON COLUMNS,

    GENERATE(
        {[Dim Date].[Release Year].&[2022] : [Dim Date].[Release Year].&[2024]},	
        
        TOPCOUNT(
            FILTER(
                [Dim Date].[Release Year].CURRENTMEMBER * [Dim Movie].[Title].CHILDREN,
                LEFT([Dim Movie].[Title].CURRENTMEMBER.NAME, 1) = 'D'
            ),
            3,
            [Measures].[Vote Count]
        )
    ) ON ROWS

FROM [TMDB Movies];

--Câu 21: Doanh thu theo năm và drilldown đến cấp tiếp theo (2023 - 2024).
SELECT 
    [Measures].[Revenue] ON COLUMNS,

    DRILLDOWNLEVEL(
        {
            [Dim Date].[Hierarchy].[Release Year].&[2023] : 
            [Dim Date].[Hierarchy].[Release Year].&[2024]
        }
    ) ON ROWS

FROM [TMDB Movies];

--Câu 22: Số lượt bình chọn & điểm đánh giá trung bình của phim tiếng Nhật & Anh có thời lượng lớn hơn 3h (2021 - 2023).
SELECT 
    {[Measures].[Vote Count], [Measures].[Vote Average]} ON COLUMNS,

    (
        {[Dim Date].[Release Year].&[2021] : [Dim Date].[Release Year].&[2023]},
        {
            [Dim Language].[Original Language].&[ja],
            [Dim Language].[Original Language].&[en]
        }
    ) ON ROWS

FROM [TMDB Movies]

WHERE 
    [Dim Runtime].[Runtime Range].&[Over 3h];

--Câu 23: Số lượng phim sản xuất theo quốc gia, sắp xếp giảm dần.
SELECT 
    [Measures].[Number of Movies] ON COLUMNS,

    ORDER(
        [Dim Country].[Production Countries].MEMBERS,
        [Measures].[Number of Movies],
        DESC
    ) ON ROWS

FROM [TMDB Movies];

--Câu 24: Số lượt bình chọn & điểm đánh giá trung bình theo quý (2023 - 2024) cho phim tiếng Anh & tiếng Trung.
SELECT
    {[Measures].[Vote Count], [Measures].[Vote Average]} ON COLUMNS,

    NONEMPTY(
        {[Dim Date].[Release Year].&[2023] : [Dim Date].[Release Year].&[2024]} *
        [Dim Date].[Release Quarter].CHILDREN *
        {
            [Dim Language].[Original Language].&[en],
            [Dim Language].[Original Language].&[cn]
        }
    ) ON ROWS

FROM [TMDB Movies];