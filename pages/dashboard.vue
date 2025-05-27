```vue
<template>
  <div class="space-y-6">
    <!-- Overview Stats -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div v-for="stat in stats" :key="stat.name" 
           class="bg-white rounded-lg shadow p-6">
        <div class="flex items-center">
          <div class="bg-indigo-100 rounded-full p-3">
            <component :is="stat.icon" class="w-6 h-6 text-indigo-600" />
          </div>
          <div class="ml-4">
            <h3 class="text-sm font-medium text-gray-500">{{ stat.name }}</h3>
            <p class="text-2xl font-semibold text-gray-900">{{ stat.value }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Recent Analysis -->
      <div class="bg-white rounded-lg shadow">
        <div class="p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Recent Analysis</h2>
          <div class="space-y-4">
            <div v-for="analysis in recentAnalysis" :key="analysis.id" 
                 class="border-b border-gray-200 last:border-0 pb-4 last:pb-0">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-sm text-gray-900">{{ analysis.content }}</p>
                  <div class="flex items-center mt-1 space-x-2">
                    <span class="text-xs text-gray-500">{{ analysis.account }}</span>
                    <span class="text-xs text-gray-500">•</span>
                    <span class="text-xs text-gray-500">{{ analysis.time }}</span>
                  </div>
                </div>
                <div :class="{
                  'bg-green-100 text-green-800': analysis.sentiment === 'positive',
                  'bg-red-100 text-red-800': analysis.sentiment === 'negative',
                  'bg-gray-100 text-gray-800': analysis.sentiment === 'neutral'
                }" class="px-2.5 py-0.5 rounded-full text-xs font-medium">
                  {{ analysis.sentiment }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Tracked Stocks -->
      <div class="bg-white rounded-lg shadow">
        <div class="p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Tracked Stocks</h2>
          <div class="space-y-4">
            <div v-for="stock in trackedStocks" :key="stock.symbol" 
                 class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div>
                <h3 class="font-medium text-gray-900">{{ stock.symbol }}</h3>
                <p class="text-sm text-gray-500">{{ stock.name }}</p>
              </div>
              <div class="text-right">
                <p :class="{
                  'text-green-600': stock.sentiment > 0.6,
                  'text-red-600': stock.sentiment < 0.4,
                  'text-gray-600': stock.sentiment >= 0.4 && stock.sentiment <= 0.6
                }" class="font-semibold">
                  {{ (stock.sentiment * 100).toFixed(1) }}% Positive
                </p>
                <p class="text-sm text-gray-500">{{ stock.posts }} posts analyzed</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  UsersIcon,
  DocumentTextIcon,
  ChartBarIcon
} from '@heroicons/vue/24/outline'

// Mock data - replace with real data from Supabase
const stats = [
  {
    name: 'Tracked Accounts',
    value: '24',
    icon: UsersIcon
  },
  {
    name: 'Posts Analyzed',
    value: '2,847',
    icon: DocumentTextIcon
  },
  {
    name: 'Tracked Stocks',
    value: '12',
    icon: ChartBarIcon
  }
]

const recentAnalysis = [
  {
    id: 1,
    content: 'Excited about the new AI chip announcement! This will revolutionize the industry. $NVDA',
    account: '@techtrader',
    time: '2 hours ago',
    sentiment: 'positive'
  },
  {
    id: 2,
    content: 'Market conditions looking uncertain. Keeping a close watch on $AAPL',
    account: '@marketanalyst',
    time: '4 hours ago',
    sentiment: 'neutral'
  },
  {
    id: 3,
    content: 'Disappointing earnings report from $META. Below expectations.',
    account: '@stockguru',
    time: '6 hours ago',
    sentiment: 'negative'
  }
]

const trackedStocks = [
  {
    symbol: 'NVDA',
    name: 'NVIDIA Corporation',
    sentiment: 0.82,
    posts: 156
  },
  {
    symbol: 'AAPL',
    name: 'Apple Inc.',
    sentiment: 0.65,
    posts: 243
  },
  {
    symbol: 'META',
    name: 'Meta Platforms Inc.',
    sentiment: 0.45,
    posts: 189
  },
  {
    symbol: 'TSLA',
    name: 'Tesla Inc.',
    sentiment: 0.71,
    posts: 278
  }
]
</script>
```