CREATE TABLE [max_ms_collection] (
  [ms_collection_id] int PRIMARY KEY IDENTITY(1, 1),
  [title] varchar(256),
  [collection_type_id] int,
  [collection_previous] int DEFAULT (null),
  [created_by] nvarchar(255),
  [created_at] datetime,
  [updated_at] datetime
)


CREATE TABLE [max_ms_collection_reward] (
  [max_collection_reward_id] int PRIMARY KEY IDENTITY(1, 1),
  [ms_collection_id] int,
  [ms_collection_buff_id] int,
  [collection_type] int,
  [item_id] int,
  [item_value] int,
  [created_at] datetime,
  [updated_at] datetime
)


CREATE TABLE [max_ms_collection_require] (
  [my_collection_require_id] int PRIMARY KEY IDENTITY(1, 1),
  [ms_collection_id] int,
  [item_id] int,
  [item_value] int
)


CREATE TABLE [max_my_collection] (
  [my_collection_id] int PRIMARY KEY IDENTITY(1, 1),
  [charaction_key] int,
  [ms_collection_id] int,
  [completed_at] datetime,
  [claimed_at] datetime,
  [created_at] datetime,
  [updated_at] datetime
)


CREATE TABLE [max_my_collection_record] (
  [my_collection_record_id] int PRIMARY KEY IDENTITY(1, 1),
  [my_collection_id] int,
  [item_id] int,
  [registered_at] datetime,
  [created_at] datetime,
  [updated_at] datetime
)


CREATE TABLE [max_ms_collection_type] (
  [my_collection_type_id] int PRIMARY KEY IDENTITY(1, 1),
  [my_collection_type_name] nvarchar(255),
  [created_at] datetime,
  [updated_at] datetime
)


CREATE TABLE [max_ms_collection_buff] (
  [ms_collection_buff_id] int PRIMARY KEY IDENTITY(1, 1),
  [buff_title_enum] nvarchar(255),
  [character_stat_ATK_STR] INT NOT NULL DEFAULT (0),
  [character_stat_ATK_GRA] INT NOT NULL DEFAULT (0),
  [character_stat_DEF_STR] INT NOT NULL DEFAULT (0),
  [character_stat_DEF_GRA] INT NOT NULL DEFAULT (0),
  [character_stat_CRI] INT NOT NULL DEFAULT (0),
  [character_stat_HP] INT NOT NULL DEFAULT (0),
  [character_stat_SP] INT NOT NULL DEFAULT (0),
  [character_stat_TEAM_ATTACK] INT NOT NULL DEFAULT (0),
  [character_stat_TEAM_DEFENCE] INT NOT NULL DEFAULT (0),
  [character_stat_DOUBLE_ATTACK] INT NOT NULL DEFAULT (0),
  [character_stat_DOUBLE_DEFENCE] INT NOT NULL DEFAULT (0),
  [character_stat_SPECIAL_ATTACK] INT NOT NULL DEFAULT (0),
  [character_stat_SPECIAL_DEFENCE] INT NOT NULL DEFAULT (0),
  [character_stat_CRITICAL_DAMAGE] INT NOT NULL DEFAULT (0),
  [created_at] datetime,
  [updated_at] datetime
)

CREATE PROCEDURE ManageCollectionProgress
    @character_key INT,
    @ms_collection_id INT = NULL,  -- Optional parameter for update/insert
    @is_completed BIT = 0          -- Default value for is_completed is 0
AS
BEGIN
    -- If @ms_collection_id and @is_completed are provided, perform an update or insert
    IF @ms_collection_id IS NOT NULL
    BEGIN
        -- Check if the record exists
        IF EXISTS (
            SELECT 1 
            FROM max_my_collection 
            WHERE charaction_key = @character_key 
            AND ms_collection_id = @ms_collection_id
        )
        BEGIN
            -- Update the existing record
            UPDATE max_my_collection
            SET is_completed = @is_completed,
                completed_at = CASE WHEN @is_completed = 1 THEN GETDATE() ELSE NULL END,  -- Set completed_at if completed
                updated_at = GETDATE()
            WHERE charaction_key = @character_key 
            AND ms_collection_id = @ms_collection_id;
        END
        ELSE
        BEGIN
            -- Insert a new record
            INSERT INTO max_my_collection (charaction_key, ms_collection_id, is_completed, completed_at, created_at, updated_at)
            VALUES (
                @character_key, 
                @ms_collection_id, 
                @is_completed, 
                CASE WHEN @is_completed = 1 THEN GETDATE() ELSE NULL END,  -- Set completed_at if completed
                GETDATE(), 
                GETDATE()
            );
        END
    END

    -- Select query to retrieve collection progress based on @character_key
    SELECT 
        ms_c.ms_collection_id,
        ms_c.title AS collection_title,
        ms_c.collection_type_id,
        ms_c.collection_previous,
        my_c.my_collection_id,
        my_c.completed_at,
        ms_c.created_by,
        ms_c.created_at,
        ms_c.updated_at
    FROM 
        max_ms_collection AS ms_c
    LEFT JOIN 
        max_my_collection AS my_c ON ms_c.ms_collection_id = my_c.ms_collection_id 
        AND my_c.charaction_key = @character_key
    LEFT JOIN 
        max_my_collection AS prev_mc ON ms_c.collection_previous = prev_mc.ms_collection_id 
        AND prev_mc.charaction_key = @character_key
    WHERE 
        (my_c.completed_at IS NULL OR my_c.my_collection_id IS NULL OR my_c.my_collection_id IS NOT NULL)  -- Exclude completed collections
        AND (ms_c.collection_previous IS NULL OR prev_mc.completed_at IS NOT NULL)  -- Only show if prerequisite is completed
    ORDER BY 
        ms_c.ms_collection_id;
END;



-- Mock data mster data collection for max_ms_collection
INSERT INTO max_ms_collection (title, collection_type_id, collection_previous, created_by, created_at, updated_at)
VALUES 
('Root Collection - Tree 1', 1, NULL, 'Admin', '2023-01-01 08:00:00', '2023-01-01 08:00:00'),
('Level 1 - Collection 1.1', 1, 1, 'Admin', '2023-01-01 08:10:00', '2023-01-01 08:10:00'),
('Level 1 - Collection 1.2', 1, 1, 'Admin', '2023-01-01 08:20:00', '2023-01-01 08:20:00'),
('Level 2 - Collection 1.1.1', 1, 2, 'Admin', '2023-01-01 09:00:00', '2023-01-01 09:00:00'),
('Level 2 - Collection 1.1.2', 1, 2, 'Admin', '2023-01-01 09:10:00', '2023-01-01 09:10:00'),
('Level 2 - Collection 1.2.1', 1, 3, 'Admin', '2023-01-01 09:20:00', '2023-01-01 09:20:00'),
('Level 2 - Collection 1.2.2', 1, 3, 'Admin', '2023-01-01 09:30:00', '2023-01-01 09:30:00'),
('Root Collection - Tree 2', 2, NULL, 'Admin', '2023-01-02 08:00:00', '2023-01-02 08:00:00'),
('Level 1 - Collection 2.1', 2, 8, 'Admin', '2023-01-02 08:10:00', '2023-01-02 08:10:00'),
('Level 1 - Collection 2.2', 2, 8, 'Admin', '2023-01-02 08:20:00', '2023-01-02 08:20:00'),
('Level 2 - Collection 2.1.1', 2, 9, 'Admin', '2023-01-02 09:00:00', '2023-01-02 09:00:00'),
('Level 2 - Collection 2.1.2', 2, 9, 'Admin', '2023-01-02 09:10:00', '2023-01-02 09:10:00'),
('Level 2 - Collection 2.2.1', 2, 10, 'Admin', '2023-01-02 09:20:00', '2023-01-02 09:20:00'),
('Level 2 - Collection 2.2.2', 2, 10, 'Admin', '2023-01-02 09:30:00', '2023-01-02 09:30:00');

-- Level 3 of Tree 1
INSERT INTO max_ms_collection (title, collection_type_id, collection_previous, created_by, created_at, updated_at)
VALUES
('Level 3 - Collection 1.1.1.1', 1, 4, 'Admin', '2023-01-01 10:00:00', '2023-01-01 10:00:00'),
('Level 3 - Collection 1.1.1.2', 1, 4, 'Admin', '2023-01-01 10:10:00', '2023-01-01 10:10:00'),
('Level 3 - Collection 1.1.2.1', 1, 5, 'Admin', '2023-01-01 10:20:00', '2023-01-01 10:20:00'),
('Level 3 - Collection 1.1.2.2', 1, 5, 'Admin', '2023-01-01 10:30:00', '2023-01-01 10:30:00'),
('Level 3 - Collection 1.2.1.1', 1, 6, 'Admin', '2023-01-01 10:40:00', '2023-01-01 10:40:00'),
('Level 3 - Collection 1.2.1.2', 1, 6, 'Admin', '2023-01-01 10:50:00', '2023-01-01 10:50:00'),
('Level 3 - Collection 1.2.2.1', 1, 7, 'Admin', '2023-01-01 11:00:00', '2023-01-01 11:00:00'),
('Level 3 - Collection 1.2.2.2', 1, 7, 'Admin', '2023-01-01 11:10:00', '2023-01-01 11:10:00');

-- Data for max_ms_collection_reward
INSERT INTO max_ms_collection_reward (max_collection_reward_id, collection_id, ms_collection_buff_id, collection_type, item_id, item_value, created_at, updated_at)
VALUES
(1, 1, NULL, 1, 101, 10, '2023-01-01 08:00:00', '2023-01-01 08:00:00'),
(2, 1, NULL, 2, 102, 5, '2023-01-01 08:00:00', '2023-01-01 08:00:00'),
(3, 2, NULL, 1, 103, 8, '2023-02-01 09:00:00', '2023-02-01 09:00:00'),
(4, 2, NULL, 3, 104, 12, '2023-02-01 09:00:00', '2023-02-01 09:00:00');

-- Data for max_ms_collection_require
INSERT INTO max_ms_collection_require (my_collection_require_id, ms_collection_id, item_id, item_value)
VALUES
(1, 1, 201, 20),
(2, 1, 202, 15),
(3, 2, 203, 18),
(4, 3, 204, 25);

-- max_ms_collection
