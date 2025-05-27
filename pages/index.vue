<template>
  <div class="max-w-4xl mx-auto">
    <div class="text-center mb-12">
      <h1 class="text-4xl font-bold text-gray-900 mb-4">Welcome to TickerEcho</h1>
      <p class="text-xl text-gray-600">
        Your AI-powered social media analysis tool for smarter trading decisions
      </p>
    </div>

    <!-- Steps Section -->
    <div class="grid md:grid-cols-2 gap-8 mb-12">
      <div v-for="(step, index) in steps" :key="index" 
           class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
        <div class="flex items-center mb-4">
          <div class="bg-indigo-100 rounded-full p-3 mr-4">
            <component :is="step.icon" class="w-6 h-6 text-indigo-600" />
          </div>
          <span class="text-sm font-semibold text-indigo-600">Step {{ index + 1 }}</span>
        </div>
        <h3 class="text-xl font-semibold text-gray-900 mb-2">{{ step.title }}</h3>
        <p class="text-gray-600">{{ step.description }}</p>
      </div>
    </div>

    <!-- Call to Action -->
    <div class="bg-gradient-to-r from-indigo-600 to-purple-600 rounded-lg p-8 text-center">
      <h2 class="text-2xl font-bold text-white mb-4">Ready to enhance your trading strategy?</h2>
      <p class="text-white/90 mb-6">
        Start analyzing social media sentiment for your favorite stocks today.
      </p>
      <div class="flex flex-col sm:flex-row justify-center gap-4">
        <button class="bg-white text-indigo-600 px-6 py-3 rounded-lg font-semibold hover:bg-indigo-50 transition-colors">
          Get Started
        </button>
        <a href="https://www.paypal.com" target="_blank" rel="noopener noreferrer"
           class="bg-indigo-700 text-white px-6 py-3 rounded-lg font-semibold hover:bg-indigo-800 transition-colors">
          Support Us
        </a>
      </div>
    </div>
  </div>
</template>

<script setup>
import {
  UserGroupIcon,
  ChartBarIcon,
  PresentationChartLineIcon,
  LightBulbIcon
} from '@heroicons/vue/24/outline'

const steps = [
  {
    icon: UserGroupIcon,
    title: 'Connect Your Influencers',
    description: 'Select and connect the social media accounts of influential traders and market analysts you trust.'
  },
  {
    icon: ChartBarIcon,
    title: 'Link Your Stocks',
    description: 'Associate your favorite stocks like NVIDIA (NVDA) or Apple (AAPL) with the connected accounts.'
  },
  {
    icon: PresentationChartLineIcon,
    title: 'Monitor Analysis',
    description: 'Watch your personalized dashboard update in real-time with AI-powered sentiment analysis.'
  },
  {
    icon: LightBulbIcon,
    title: 'Make Informed Decisions',
    description: 'Use the analyzed data and insights to make more informed trading decisions.'
  }
]
</script>