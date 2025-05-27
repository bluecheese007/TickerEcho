```vue
<template>
  <header class="bg-white shadow">
    <nav class="container mx-auto px-4 py-4">
      <div class="flex justify-between items-center">
        <NuxtLink to="/" class="text-2xl font-bold text-indigo-600">TickerEcho</NuxtLink>
        <div class="flex gap-4">
          <NuxtLink 
            to="/dashboard" 
            class="text-gray-600 hover:text-indigo-600 transition-colors"
            active-class="text-indigo-600"
          >
            Dashboard
          </NuxtLink>
          <NuxtLink 
            to="/account" 
            class="text-gray-600 hover:text-indigo-600 transition-colors"
            active-class="text-indigo-600"
          >
            Account
          </NuxtLink>
        </div>
      </div>
    </nav>
  </header>
</template>
```