import Vue from 'vue'
import App from '../app.vue'
import { sync } from 'vuex-router-sync'
import router from '../router'
import { store } from '../store'

const unsync = sync(store, router)

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    el,
    router,
    store,
    render: h => h(App),
    created () {
      // this.$store.dispatch('bootstrap')
    }
  })
})