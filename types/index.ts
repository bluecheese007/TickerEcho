export interface User {
  id: string;
  email: string;
  created_at: string;
}

export interface SocialAccount {
  id: string;
  user_id: string;
  platform: string;
  account_handle: string;
  created_at: string;
}

export interface StockTicker {
  id: string;
  symbol: string;
  company_name: string;
  created_at: string;
}

export interface PostAnalysis {
  id: string;
  social_account_id: string;
  post_id: string;
  post_content: string;
  sentiment: 'positive' | 'negative' | 'neutral';
  confidence_score: number;
  analyzed_at: string;
  created_at: string;
}