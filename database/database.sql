DROP SCHEMA IF EXISTS agdatabase;
CREATE SCHEMA agdatabase;
USE agdatabase;
CREATE TABLE user (userid int NOT NULL PRIMARY KEY AUTO_INCREMENT, github VARCHAR(255), last_name VARCHAR(255), first_name VARCHAR(255));
CREATE TABLE admin (userid INT NOT NULL PRIMARY KEY, FOREIGN KEY (userid) REFERENCES user(userid));
CREATE TABLE teacher (userid INT NOT NULL PRIMARY KEY, FOREIGN KEY (userid) REFERENCES user(userid));
CREATE TABLE student (userid INT NOT NULL PRIMARY KEY, student_number INT NOT NULL, FOREIGN KEY (userid) REFERENCES user(userid));
CREATE TABLE course (courseid INT NOT NULL PRIMARY KEY AUTO_INCREMENT, course_name VARCHAR(255) NOT NULL, single_assignments INT,groups_assignments INT,description VARCHAR(255),number_of_slipdays INT,is_slipdays BOOL,is_private_repositories BOOL,is_code_review BOOL);
CREATE TABLE teacher_course (userid INT NOT NULL, courseid INT NOT NULL, FOREIGN KEY (userid) REFERENCES teacher(userid), FOREIGN KEY (courseid) REFERENCES course(courseid), PRIMARY KEY (userid, courseid));
CREATE TABLE student_course (userid INT NOT NULL, courseid INT NOT NULL, FOREIGN KEY (userid) REFERENCES student(userid),FOREIGN KEY (courseid) REFERENCES course(courseid), PRIMARY KEY (userid, courseid));
CREATE TABLE groups (groupid INT NOT NULL PRIMARY KEY, groups_name VARCHAR(255));
CREATE TABLE student_group (userid INT NOT NULL, groupid INT NOT NULL, FOREIGN KEY (userid) REFERENCES student(userid), FOREIGN KEY (groupid) REFERENCES groups(groupid), PRIMARY KEY (userid, groupid));
CREATE TABLE asmt (asmtid INT NOT NULL PRIMARY KEY, number INT NOT NULL, course_name VARCHAR(255) NOT NULL, courseid INT NOT NULL, FOREIGN KEY (courseid) REFERENCES course(courseid));
CREATE TABLE student_asmt (userid INT NOT NULL, asmtid INT NOT NULL,FOREIGN KEY (userid) REFERENCES student(userid),FOREIGN KEY (asmtid) REFERENCES asmt(asmtid), PRIMARY KEY (userid, asmtid));
CREATE TABLE groups_asmt (groupid INT NOT NULL, asmtid INT NOT NULL,FOREIGN KEY (groupid) REFERENCES groups(groupid),FOREIGN KEY (asmtid) REFERENCES asmt(asmtid), PRIMARY KEY (groupid, asmtid));
CREATE TABLE org (orgid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,name VARCHAR(255) NOT NULL, url VARCHAR(255) NOT NULL);
CREATE TABLE course_organization (courseid INT NOT NULL, orgid INT NOT NULL,FOREIGN KEY (courseid) REFERENCES course(courseid),FOREIGN KEY (orgid) REFERENCES org(orgid), PRIMARY KEY (courseid, orgid));
CREATE TABLE repo (repoid INT NOT NULL PRIMARY KEY, name VARCHAR(255) NOT NULL, url VARCHAR(255) NOT NULL, groups_name VARCHAR(255) NOT NULL, groupid INT NOT NULL,FOREIGN KEY (groupid) REFERENCES groups(groupid));
CREATE TABLE org_repo (orgid INT NOT NULL, repoid INT NOT NULL,FOREIGN KEY (orgid) REFERENCES org(orgid),FOREIGN KEY (repoid) REFERENCES repo(repoid), PRIMARY KEY (orgid, repoid));
CREATE TABLE student_repo (userid INT NOT NULL, repoid INT NOT NULL,FOREIGN KEY (userid) REFERENCES student(userid),FOREIGN KEY (repoid) REFERENCES repo(repoid), PRIMARY KEY (userid, repoid));
