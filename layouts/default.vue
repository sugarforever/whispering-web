<script setup>
const links = [{
  label: 'Home',
  icon: 'i-heroicons-home',
  to: '/'
}]
</script>
<template>
  <UContainer>
    <UBreadcrumb :links="links" class="py-4" />

    <UDivider class="mb-4" />
    <slot />
  </UContainer>
</template>
