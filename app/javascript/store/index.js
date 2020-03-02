import Vue from 'vue'
import Vuex from 'vuex'
import router from '../router'

Vue.use(Vuex)

export const store = new Vuex.Store({
  state: {
    flash: {
      show: false
    }
  },
  getters: {
  },
  mutations: {
    SET_FLASH(state, flash) {
      if (typeof flash.show == 'undefined') {
        flash.show = true
        state.flash = flash
      } else {
        state.flash.show = flash.show
      }
    }
  },
  actions: {
    setFlash({ commit }, flash) {
      commit("SET_FLASH", flash)
    }
  }
})