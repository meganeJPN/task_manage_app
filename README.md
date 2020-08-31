# テーブルスキーマ
## Users
| カラム名        | データ型 |
|-----------------|----------|
| name            | string   |
| mail            | string   |
| password_digest | string   |


## Tasks
| カラム名 | データ型 |
|----------|----------|
| name     | string   |
| content  | text     |
| status   | integer  |
| priority | integer  |
| deadline | datetime |
| user_id  | integer  |


## Task_labels
| カラム名 | データ型 |
|----------|----------|
| task_id  | integer  |
| label_id | integer  |


## Labels
| カラム名 | データ型 |
|----------|----------|
| task_id  | integer  |
| label_id | integer  |
