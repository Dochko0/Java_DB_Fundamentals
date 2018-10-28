#CREATE SCHEMA bugtig;
 #01
CREATE TABLE users(
	id	INT Primary Key AUTO_INCREMENT,
	username VARCHAR(30) Unique NOT NULL,
	password VARCHAR(30) NOT NULL,
	email	VARCHAR(50) NOT NULL
);

CREATE TABLE repositories(
	id	INT Primary Key AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE repositories_contributors(
	repository_id	INT,
	contributor_id int
);

CREATE TABLE issues(
	id	INT Primary Key AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	issue_status VARCHAR(6) NOT NULL,
    repository_id	INT NOT NULL,
    assignee_id	INT NOT NULL
);

CREATE TABLE commits(
	id	INT Primary Key AUTO_INCREMENT,
	message VARCHAR(255) NOT NULL,
	issue_id INT,
    repository_id	INT NOT NULL,
    contributor_id	INT NOT NULL
);

CREATE TABLE files(
	id	INT Primary Key AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    size DECIMAL(10,2) NOT NULL,
	parent_id INT,
    commit_id	INT NOT NULL
);



ALTER TABLE repositories_contributors
ADD Constraint fk_repositories_contributors_users
FOREIGN KEY repositories_contributors(contributor_id)
REFERENCES users(id);

ALTER TABLE repositories_contributors
ADD Constraint fk_repositories_contributors_repositories
FOREIGN KEY repositories_contributors(repository_id)
REFERENCES repositories(id);


ALTER TABLE issues
ADD Constraint fk_issues_repositories
FOREIGN KEY issues(repository_id)
REFERENCES repositories(id);

ALTER TABLE issues
ADD Constraint fk_issues_users
FOREIGN KEY issues(assignee_id)
REFERENCES users(id);

ALTER TABLE commits
ADD Constraint fk_commits_issues
FOREIGN KEY commits(issue_id)
REFERENCES issues(id);

ALTER TABLE commits
ADD Constraint fk_commits_repositories
FOREIGN KEY commits(repository_id)
REFERENCES repositories(id);

ALTER TABLE commits
ADD Constraint fk_commits_users
FOREIGN KEY commits(contributor_id)
REFERENCES users(id);

ALTER TABLE files
ADD Constraint fk_files_commits
FOREIGN KEY files(commit_id)
REFERENCES commits(id);

ALTER TABLE files
ADD Constraint fk_files_files
FOREIGN KEY files(parent_id)
REFERENCES files(id);



#02


#05
SELECT id, username
FROM users
ORDER BY id;

#06
SELECT * FROM repositories_contributors
WHERE repository_id = contributor_id
order by repository_id;

#07
SELECT id, name, size
FROM files
WHERE size>1000 and name LIKE '%html%'
ORDER BY size DESC;

#08
SELECT i.id, concat(u.username, ' : ', i.title) as issue_assignee
FROM 
issues i
JOIN users u
ON i.assignee_id = u.id
ORDER BY i.id DESC;

#09
SELECT d.id, d.name, concat(d.size, 'KB')
FROM files f
RIGHT JOIN files d
ON f.parent_id = d.id
WHERE f.id Is NULL
ORDER BY d.id;

#10
SELECT i.repository_id, r.name, count(i.id) as issues_count
FROM issues i
join repositories r
ON r.id=i.repository_id
GROUP BY i.repository_id
ORDER BY issues_count DESC , repository_id ASC
LIMIT 5;

#11
SELECT r.id, r.name,
	(
	SELECT count(*)
    FROM commits
    WHERE commits.repository_id=r.id  
	)as commits_count,
	count(u.id) as contributors_counts
FROM users u
JOIN repositories_contributors rc
ON rc.contributor_id = u.id
JOIN repositories r
ON r.id = rc.repository_id
GROUP BY r.id
ORDER BY contributors_counts DESC, r.id ASC
LIMIT 1;

#12
SELECT u.id, u.username, count(c.id) as commits
FROM users u
JOIN issues i
ON u.id= i.assignee_id
join commits c
ON c.issue_id=i.id
WHERE c.contributor_id=u.id
GROUP BY u.id
ORDER BY commits DESC, u.id;

