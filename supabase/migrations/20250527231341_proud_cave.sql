/*
  # Initial Schema for TickerEcho

  1. New Tables
    - `users`: Store user information
      - `id` (uuid, primary key)
      - `email` (text, unique)
      - `created_at` (timestamp)
    
    - `social_accounts`: Store social media account information
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key)
      - `platform` (text) - Twitter, Truth Social, etc.
      - `account_handle` (text)
      - `created_at` (timestamp)
    
    - `stock_tickers`: Store stock ticker information
      - `id` (uuid, primary key)
      - `symbol` (text) - Stock symbol (e.g., TSLA, NVDA)
      - `company_name` (text)
      - `created_at` (timestamp)
    
    - `account_tickers`: Junction table linking social accounts to stock tickers
      - `id` (uuid, primary key)
      - `social_account_id` (uuid, foreign key)
      - `stock_ticker_id` (uuid, foreign key)
      - `created_at` (timestamp)
    
    - `post_analysis`: Store analysis of social media posts
      - `id` (uuid, primary key)
      - `social_account_id` (uuid, foreign key)
      - `post_id` (text) - Original post ID from the platform
      - `post_content` (text)
      - `sentiment` (text) - 'positive', 'negative', 'neutral'
      - `confidence_score` (float)
      - `analyzed_at` (timestamp)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to:
      - Read their own data
      - Create and update their own data
*/

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own data"
  ON users
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Social accounts table
CREATE TABLE IF NOT EXISTS social_accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  platform text NOT NULL,
  account_handle text NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(platform, account_handle)
);

ALTER TABLE social_accounts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own social accounts"
  ON social_accounts
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own social accounts"
  ON social_accounts
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

-- Stock tickers table
CREATE TABLE IF NOT EXISTS stock_tickers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  symbol text UNIQUE NOT NULL,
  company_name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE stock_tickers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read stock tickers"
  ON stock_tickers
  FOR SELECT
  TO authenticated
  USING (true);

-- Account tickers junction table
CREATE TABLE IF NOT EXISTS account_tickers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  social_account_id uuid REFERENCES social_accounts(id) ON DELETE CASCADE NOT NULL,
  stock_ticker_id uuid REFERENCES stock_tickers(id) ON DELETE CASCADE NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(social_account_id, stock_ticker_id)
);

ALTER TABLE account_tickers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own account tickers"
  ON account_tickers
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM social_accounts
      WHERE social_accounts.id = account_tickers.social_account_id
      AND social_accounts.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert own account tickers"
  ON account_tickers
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM social_accounts
      WHERE social_accounts.id = account_tickers.social_account_id
      AND social_accounts.user_id = auth.uid()
    )
  );

-- Post analysis table
CREATE TABLE IF NOT EXISTS post_analysis (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  social_account_id uuid REFERENCES social_accounts(id) ON DELETE CASCADE NOT NULL,
  post_id text NOT NULL,
  post_content text NOT NULL,
  sentiment text NOT NULL CHECK (sentiment IN ('positive', 'negative', 'neutral')),
  confidence_score float NOT NULL CHECK (confidence_score >= 0 AND confidence_score <= 1),
  analyzed_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  UNIQUE(social_account_id, post_id)
);

ALTER TABLE post_analysis ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own post analysis"
  ON post_analysis
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM social_accounts
      WHERE social_accounts.id = post_analysis.social_account_id
      AND social_accounts.user_id = auth.uid()
    )
  );

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_social_accounts_user_id ON social_accounts(user_id);
CREATE INDEX IF NOT EXISTS idx_account_tickers_social_account_id ON account_tickers(social_account_id);
CREATE INDEX IF NOT EXISTS idx_account_tickers_stock_ticker_id ON account_tickers(stock_ticker_id);
CREATE INDEX IF NOT EXISTS idx_post_analysis_social_account_id ON post_analysis(social_account_id);
CREATE INDEX IF NOT EXISTS idx_post_analysis_analyzed_at ON post_analysis(analyzed_at);