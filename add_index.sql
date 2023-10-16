# mysql -u root -pishocon1 ishocon1 < add_index.sql
CREATE INDEX idx_users_email on users(email);
CREATE INDEX idx_histories_product_id on histories(product_id);
CREATE INDEX idx_histories_user_id on histories(user_id);
CREATE INDEX idx_comments_user_id on comments(user_id);
CREATE INDEX idx_comments_product_id on comments(product_id);
CREATE INDEX idx_comments_created_at on comments(created_at);
CREATE INDEX idx_histories_product_user on histories(product_id, user_id);
