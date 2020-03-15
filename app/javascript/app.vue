<template>
  <div id="app" class="app">
    <router-view 
      v-if="!this.$store.state.loading"
    />
    <Flash />
  </div>
</template>

<script>
import Flash from 'components/Flash.vue'

export default {
  components: {
    Flash
  }
}
</script>