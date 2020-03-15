<template>
  <div :class="'flash flash-' + flashMessage.show">
    <div :class="'flash-message flash-message-' + flashMessage.type" @click="destroyFlash">
      {{ flashMessage.message }}
    </div>
  </div>
</template>
<script>
let destroyTimeout;

export default {
  computed: {
    flashMessage () {
      return this.$store.state.flash
    }
  },
  watch: {
    flashMessage (newFlash, oldFlash) {
      if (newFlash.show != false) {
        destroyTimeout = setTimeout(this.destroyFlash, 5000)
      }
    }
  },
  methods: {
    destroyFlash () {
      clearTimeout(destroyTimeout)
      this.$store.dispatch('setFlash', {
        show: false
      })
    }
  }
}
</script>