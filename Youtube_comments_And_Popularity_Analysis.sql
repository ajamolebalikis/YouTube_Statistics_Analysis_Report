-- YOUTUBE COMMENTS AND POPULARITY ANALYSIS
-- WHICH KEYWORDS ARE ASSOCIATED WITH THE HIGHEST PERFORMIMG VIDEOS?
-- CONSIDER ANALYZING BY VIEWS, LIKES AND COMMENTS
-- ARE THERE COMMON TOPICS OR CONTENT TYPES

SELECT Keyword, COUNT(Video_ID) AS video_count,
      AVG(CAST(Views AS FLOAT)) AS avg_views,
	  AVG(CAST(Likes AS FLOAT)) AS avg_likes,
	  AVG(CAST(Comments AS FLOAT)) AS avg_comments,
	  SUM(Views) AS total_views,
	  SUM(Likes) AS total_likes,
	  SUM(Comments) AS total_comments
FROM "videos-stats"
GROUP BY Keyword
ORDER BY avg_views DESC, avg_likes DESC, avg_comments DESC;

-- DO VIDEOS WITH HIGH ENGAGEMENT(LIKES/VIEWS/COMMENTS) TENDS TO HAVE MORE POSITIVE, NEGATIVE OR NEUTRAL COMMENTS?
-- USE AVERAGE SENTIMENT ACROSS COMMENTS PER VIDEO
-- DO HIGH PERFORMING VIDEOS ATTRACT MORE SENTIMENT

SELECT vs.Keyword, vs.Video_ID, vs.Views, vs.Likes, vs.Comments,
      AVG(CAST(c.Sentiment AS FLOAT)) AS avg_sentiment,
	  CASE 
	     WHEN AVG(CAST(c.Sentiment AS FLOAT)) > 0.3 THEN 'Postive'
		 WHEN AVG(CAST(c.Sentiment AS FLOAT)) < 0.3 THEN 'Negative'
		 ELSE 'Neutral'
		 END AS sentiment_category
FROM "videos-stats"  vs
LEFT JOIN "Comments" c ON vs.Video_ID = c.Video_ID
GROUP BY vs.Keyword, vs.Video_ID, vs.Views, vs.Likes, vs.Comments
ORDER BY vs.views DESC, vs.Likes DESC, vs.Comments DESC;

-- WHAT IS THE REALTIONSHIP OF BETWEEN COMMENT VOLUME AND COMMENT SENTIMENT?
-- DO VIDEOS WITH MORE COMMENTS HAVE POLARIZED (0 OR 2) REACTIONS?
-- ARE NEUTRAL COMMENTS MORE COMMON ON LOW-ENGAGEMENT VIDEOS?

SELECT vs.Keyword, vs.Video_ID, vs.Comments,
      AVG(CAST(c.Sentiment AS FLOAT)) AS avg_sentiment,
	  COUNT(CASE WHEN c.Sentiment IN(0,2) THEN 1 END) * 1.0 / COUNT (c.Comments_comment) AS sentiment_polarization,
	  COUNT(CASE WHEN c.sentiment = 0 THEN 1 END) * 1.0 / COUNT (c.Comments_comment) AS percentage_of_neutral_comments
FROM "videos-stats" vs
LEFT JOIN "Comments" c ON vs.Video_ID = c.Video_ID
GROUP BY vs.Keyword, vs.Video_ID, vs.Comments
ORDER BY vs.Comments DESC;

-- WHICH VIDEOS HAVE THE MOST LIKED COMMENTS AND WHAT IS THE SENTIMENT OF THES TOP COMMENTS
-- ARE THE TOP-LIKED COMMENTS GENERALLY POSITIVE OR NEGATIVE
-- DO THEY ALIGN WITH THE VIDEO POPULARITY
SELECT vs.Likes, vs.Views, vs.Comments, c.Video_ID, c.Comments_comment,
     MAX(c.Comment_likes) AS most_liked_comments,
	 AVG(CAST(c.Sentiment AS FLOAT)) AS sentiment_comment,
     CASE
	     WHEN AVG(CAST(c.Sentiment AS FLOAT)) > 0.3 THEN 'Positive'
		 WHEN AVG(CAST(c.Sentiment AS FLOAT)) < 0.3 THEN 'Negative'
		 ELSE 'Neutral'
		 END AS sentiment_category
FROM "Comments" c
JOIN "videos-stats" vs ON c.Video_ID = vs.Video_ID
GROUP BY c.Video_ID, c.Comments_comment, vs.Likes, vs.Views, vs.Comments
ORDER BY most_liked_comments DESC;

-- WHAT PROPORTION OF VIDEOS HAVE DISABLED COMMENTS OR HIDDEN LIKE COUNTS?
-- DO THESE VIDEOS STILL PERFORM WELL IN TERMS OF VIEWS
-- IS THERE A TREND BY KEYWORD OR PUBLISHING YEAR

SELECT Keyword, YEAR(Published_at) AS publish_year,
      COUNT(*) AS total_videos,
	  COUNT(CASE WHEN Comments = 0 OR Comments IS NULL THEN 1 END) * 1.0 / COUNT (*) AS disabled_comments_percent,
	  COUNT(CASE WHEN Likes = 0 OR Likes IS NULL THEN 1 END) * 1.0 /COUNT (*) AS hidden_likes_percent,
	  AVG(CASE WHEN Comments = 0 OR Comments IS NULL THEN Views END) AS avg_views_disabled_comments,
	  AVG(CASE WHEN Likes = 0 OR Likes IS NULL THEN Views END) AS avg_views_hidden_likes,
	  AVG(Views) AS avg_views_overall
FROM "videos-stats"
GROUP BY Keyword, Year(Published_at)
ORDER BY publish_year DESC, disabled_comments_percent DESC, hidden_likes_percent DESC;

-- ARE THERE KEYWORD THAT CONSISTENTLY RESULT IN HIGHER COMMENT SENTIMENT OR MORE LIKED COMMENTS
-- CAN CREATORS USE THIS INSIGHT TO DRIVR MORE ENGAGEMENT

SELECT vs.Keyword,
      AVG(CAST(c.Sentiment AS FLOAT)) AS avg_comment_sentiment,
	  AVG(CAST(c. Comment_likes AS FLOAT)) AS avg_comment_likes
FROM "videos-stats" vs
LEFT JOIN "Comments" c ON vs.Video_ID = vs.Video_ID
GROUP BY vs.Keyword
ORDER BY avg_comment_sentiment DESC, avg_comment_likes DESC;
     
-- HOW DOES THE PUBLICATION DATE RELATE TO PERFORMANCE
-- ARE NEWER VIDEOS TRENDING BETTER OR WORSE THAN OLDER ONES
-- DOES SENTIMENT VARY OVER TIME

SELECT YEAR(Published_at) AS publish_year,
      AVG(CAST(Views AS FLOAT)) AS avg_views,
	  AVG(CAST(Likes AS FLOAT)) AS avg_likes,
	  AVG(CAST(Comments AS FLOAT)) AS avg_comments,
	  AVG(CAST(c.Sentiment AS FLOAT)) AS avg_comment_sentiment
FROM "videos-stats" vs
LEFT JOIN "Comments" c ON vs.Video_ID = c.Video_ID
GROUP BY YEAR(Published_at)
ORDER BY publish_year DESC;