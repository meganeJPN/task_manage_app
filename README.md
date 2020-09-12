# テーブルスキーマ

## Users

| カラム名        | データ型 |
| --------------- | -------- |
| name            | string   |
| mail            | string   |
| password_digest | string   |

## Tasks

| カラム名 | データ型 |
| -------- | -------- |
| name     | string   |
| content  | text     |
| status   | integer  |
| priority | integer  |
| deadline | datetime |
| user_id  | integer  |

## Task_labels

| カラム名 | データ型 |
| -------- | -------- |
| task_id  | integer  |
| label_id | integer  |

## Labels

| カラム名 | データ型 |
| -------- | -------- |
| task_id  | integer  |
| label_id | integer  |

# heroku へのデプロイ手順

## 1. heroku を作成する

'heroku create'

## 2. heroku に push する

### master ブランチを push する場合

'git push heroku master'

### master ブランチ以外を push する場合

'git push heroku [ブランチ名]:master --force'

## 3. heroku 上で migrate する

'heroku run rails db:migrate RAILS_ENV=production'
