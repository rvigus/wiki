## DB concepts in Postgres 
In `tables.sql` we have a simple set of table definitions for a blogging platform.

The following relationships exist:
* Users to posts: One-to-many (1 user can write multiple posts)
* Posts to comments: One-to-many (A post can have multiple comments)
* Users to comments: One-to-many (A user can write multiple comments)
* Posts to tags: Many-to-many (A post can have multiple tags, and a tag can be present on multiple posts)

Normalization:
* 1NF: Each table has a primary key, and the values in each column of a table are atomic (no repeating groups or arrays as row values)
* 2NF: The table is in 1NF and all non-key attributes are fully functionally dependent on the primary key
* 3NF: The schema is in 2NF, and all the columns in a table are only dependent on the primary key, not on other columns.

In simple english:
1NF: 
* Has a primary key (each record is uniquely identifiable) 
* Atomic -> each "cell" value contains only a single value or piece of info.

2NF:
* Already in 1NF
* All information in the table is directly related to the primary key
  * For example, in the Posts table, every piece of information (title, content, published_at, status) is specifically about the post identified by post_id.

3NF:
* Already in 2NF
* No indirect dependencies -> aka no column depends on another non-primary key column.
  * For instance, in the Comments table, everything about a comment (who made it, which post it's on, the content of the comment) is directly related to the comment_id, not indirectly through another column.


### SQL
Looking at one of the create table statements:
```
CREATE TABLE PostTags (
    post_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (post_id, tag_id),
    CONSTRAINT fk_post
        FOREIGN KEY(post_id) 
        REFERENCES Posts(post_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_tag
        FOREIGN KEY(tag_id) 
        REFERENCES Tags(tag_id)
        ON DELETE CASCADE
);
```

Foreign key constraint on the post_id and tag_id columns. A foreign key is just a column that uniquely 
identifies a row in another table. By explicitly creating this key, we can guarantee referential integrity. 
Referential integrity states that you cannot add a record to the table that contains the foreign key unless 
there is a corresponding record in the linked table. 

Constraints prevent actions being taken that would leave orphaned records in the database. So we couldn't delete a post
from Posts without also deleting the corresponding records in PostTags and Comments.

CASCADE operations -> ON DELETE CASCADE -> means that if a record in the referenced table is deleted, then all related records
in the table with the foreign key will be deleted as well.

## Indexes
Implicit indexes are created for primary keys and unique constraints. 
If we frequently ran queries on Posts that filtered on a user_id, then we could add an index to the user_id column.
Indexes speed up reads, but slow down writes. INSERTS/UPDATES/DELETES will be slower because the index needs to be updated as well.
Indexes also take up space, so we don't want to add them to every column.
