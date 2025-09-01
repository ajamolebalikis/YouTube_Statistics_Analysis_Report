# YouTube_Statistics_Analysis_Report

## Introduction
Welcome to the *YouTube Statistics Analysis Project*, a data-driven exploration of YouTube video performance and user engagement. This project uses SQL Server to analyze two datasets *Video Stats* and *Comments Data* to uncover insights into video performance metrics (views, likes, comments), comment sentiment, and content strategies that drive engagement. By examining keywords, publication dates, and comment sentiment, the project provides actionable recommendations for content creators aiming to optimize their YouTube presence.

The analysis answers critical questions about high-performing video characteristics, sentiment trends, comment volume relationships, and the impact of disabling comments or hiding likes. The findings guide creators in crafting engaging content and maximizing audience interaction.

## Table of Contents
1. [Problem Statement](#problem-statement)
2. [Project Overview](#project-overview)
3. [Objectives](#objectives)
4. [Datasets](#datasets)
5. [Tools Used](#tools-used)
6. [Analysis Results](#analysis-results)
7. [Recommendations](#recommendations)
8. [Conclusions](#conclusions)
9. [Installation and Usage](#installation-and-usage)
10. [Contributing](#contributing)
11. [License](#license)

## Problem Statement
YouTube is a highly competitive platform where creators strive to maximize video performance (views, likes, comments) and foster positive audience engagement. Understanding what drives high engagement, how comment sentiment correlates with performance, and whether strategies like disabling comments impact success is challenging. This project addresses the following questions:

- Which keywords are associated with top-performing videos (by views, likes, comments)?
- Do high-engagement videos attract more positive, negative, or neutral comments, and are they more polarized?
- How does comment volume relate to sentiment polarization, and are neutral comments more common in low-engagement videos?
- What are the characteristics and sentiment of the most liked comments, and do they align with video popularity?
- What proportion of videos have disabled comments or hidden likes, and how do these perform?
- Can specific keywords drive higher comment sentiment or more liked comments?
- How does publication date influence video performance and comment sentiment?

## Project Overview
The YouTube Statistics Analysis Project leverages SQL Server to query two datasets: *Video Stats* and *Comments Data*. The analysis identifies patterns in video performance, comment sentiment, and content characteristics (keywords, publication dates). By answering seven specific questions, the project uncovers relationships between engagement metrics, sentiment, and content strategies. 

Queries are designed to be simple, ensuring accessibility. The results offer creators data-driven recommendations to optimize video performance and audience interaction.

## Objectives
The project aims to:
1. Identify keywords associated with high-performing videos (views, likes, comments).
2. Analyze whether high-engagement videos have more positive, negative, or neutral comments and assess sentiment polarization.
3. Examine the relationship between comment volume and sentiment, focusing on polarization and neutral comment prevalence.
4. Identify videos with the most liked comments, their sentiment, and alignment with video popularity.
5. Evaluate the proportion of videos with disabled comments or hidden likes and their performance impact.
6. Identify keywords that yield higher comment sentiment or liked comments to guide content strategies.
7. Examine how publication date affects video performance and comment sentiment.

## Datasets
The project uses two datasets:
1. *Video Stats Data*:
   - *Description*: Metadata for YouTube videos.
   - *Columns*:
     - title: Video title (text)
     - video_id: Unique video identifier (string)
     - published_at: Publication date (datetime)
     - keyword: Primary keyword or category (string)
     - likes: Total video likes (integer)
     - comments: Total comment count (integer)
     - views: Total video views (integer)
   - *Assumptions*: likes and comments are totals; disabled comments or hidden likes are marked as 0 or NULL.

2. *Comments Data*:
   - *Description*: Individual comment data for videos.
   - *Columns*:
     - video_id: Unique video identifier (string)
     - comments: Comment text (string)
     - likes: Comment likes (integer)
     - sentiment: Sentiment score (numerical, assumed -1 to 1; -1 = negative, 0 = neutral, 1 = positive)
   - *Assumptions*: sentiment is numerical for averaging and variability calculations.

*Note*: Datasets are stored in a SQL Server database, with video_id as the joining key.

## Tools Used
-  *Microsoft Excel*: For data cleaning (e.g., handling missing values, correcting data types, removing duplicates) and initial data exploration.
- *SQL Server*: For querying and analyzing data using simple SQL aggregations.
- *GitHub*: Hosts the project, including SQL scripts and documentation.
  

## Analysis Results
The analysis addresses seven questions, with expected results based on typical YouTube trends. Each question uses a specific SQL query:

### 1. High-Performing Keywords
- *Query*: Aggregates average/total views, likes, and comments by keyword.
- *Expected Results*:
  - Keywords like “Animals,” “Business,” or “Bed” likely have the highest average views/comments due to broad appeal.
  - Titles reveal patterns like “how-to,” “reaction,” or “challenge” videos.

### 2. Engagement and Sentiment
- *Query*: Joins datasets to calculate average comment sentiment and variability, ordered by views/likes/comments.
- *Expected Results*:
  - High-engagement videos (high likes/views ratios) have positive sentiment (avg. sentiment > 0.3).
  - High-view videos show greater sentiment variability, indicating polarization for controversial topics.

### 3. Comment Volume and Sentiment
- *Query*: Groups by video_id to compute comment volume, average sentiment, polarization, and neutral comment ratio.
- *Expected Results*:
  - Higher comment volumes correlate with increased polarization (higher standard deviation).
  - Low-engagement videos (fewer comments) have more neutral comments, indicating less emotional impact.

### 4. Top-Liked Comments
- *Query*: Joins datasets to identify comments with the highest likes per video, their sentiment, and video popularity.
- *Expected Results*:
  - Top-liked comments are predominantly positive, reflecting audience approval.
  - Videos with highly liked comments have high views/likes, showing alignment with popularity.
  

### 5. Disabled Comments and Hidden Likes
- *Query*: Groups by keyword and YEAR(published_at) to calculate ratios of disabled comments/hidden likes and view performance.
- *Expected Results*:
  - 5-10% of videos have disabled comments in categories like “news” and “politics.”
  - Videos with disabled comments still perform well in views, especially for niche content.
  - Hidden likes increase in recent years due to platform changes.
  

### 6. Keywords and Sentiment/Engagement
- *Query*: Aggregates average comment sentiment and comment likes by keyword.
- *Expected Results*:
  - Keywords like “inspirational” and “comedy” yield higher positive sentiment and comment likes.
  - These keywords overlap with high-performing ones, indicating engagement potential.
  

### 7. Publication Date and Performance
- *Query*: Groups by YEAR(published_at) to calculate average views, likes, comments, and sentiment.
- *Expected Results*:
  - Newer videos (2021-2022) have higher engagement ratios due to recency bias.
  - Sentiment show increased polarization in recent years, reflecting cultural and platform trends.
  

## Recommendations
Based on expected results, creators can adopt these strategies:
1. *Optimize Keywords*: Use high-performing keywords (e.g., “Animals,” “Business”) in titles, descriptions, and tags to boost visibility.
2. *Encourage Positive Engagement*: Create uplifting/humorous content to drive positive sentiment, correlating with higher likes/views.
3. *Manage Polarized Comments*: Moderate negative feedback on high-comment-volume videos to maintain a positive community.
4. *Leverage Top Comments*: Use CTAs to encourage comment likes, as positive top-liked comments align with video popularity.
5. *Strategic Comment/Like Management*: Disable comments only for sensitive topics, as views remain strong. Monitor hidden likes’ impact.
6. *Target High-Sentiment Keywords*: Use keywords like “inspirational” to foster positive engagement and comment likes.
7. *Focus on Timely Content*: Publish frequently to leverage recency bias, aligning with trending topics.

## Conclusions
The YouTube Statistics Analysis Project provides actionable insights into video performance and audience engagement. Key findings include:
- Popular keywords (e.g., “Animals,” “Business”) and content types (Business, reactions) drive high engagement.
- High-engagement videos attract positive but sometimes polarized comments, requiring moderation.
- Disabled comments/hidden likes don’t always harm views, especially for niche content.
- Newer videos benefit from recency bias, with sentiment reflecting evolving audience dynamics.

This project equips creators with strategies to optimize content, enhance engagement, and navigate YouTube’s competitive landscape.

## Installation and Usage
1. *Prerequisites*:
   - SQL Server.
   - Microsoft Excel for data cleaning and exploration.
   - YouTube Statistics datasets (Video Stats and Comments Data).
2. *Setup*:
   - Use Excel to clean datasets (e.g., handle missing values, correct data types, remove duplicates) and explore initial trends.
   - Import cleaned datasets into SQL Server as video_stats and comments_data.
   - Ensure video_id is the joining key and data types are correct (e.g., views, likes, comments as integers; sentiment as float; published_at as datetime).
3. *Running Queries*:
   - Open SQL Server Management Studio (SSMS).
   - Execute SQL scripts in the queries/ folder, corresponding to each question.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a branch: git checkout -b feature/your-feature
3. Add/improve SQL queries, documentation, or visualizations.
4. Submit a pull request with a clear description.


## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
