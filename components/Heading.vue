<script setup lang="ts">
import { defineProps } from 'vue';

const props = defineProps<{text: string}>()
</script>

<template>
  <h1 class="heading">{{ props.text }}</h1>
</template>

<style>
.heading {
  background-color: #2b90b6;
  background-image: linear-gradient(45deg, #4ec5d4 10%, #146b8c 20%);
  background-size: 100%;
  background-clip: text;
  -webkit-background-clip: text;
  -moz-background-clip: text;
  -webkit-text-fill-color: transparent;
  -moz-text-fill-color: transparent;
}
</style>
