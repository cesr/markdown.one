<template>
  <div id="editor">
    <div
      :class="'editor-actions' + ' show-' + showTools"
      @mouseover="showTools = true"
    >
      <div class="editor-actions-left">
        <div class="share-link" v-if="this.url">{{ url }}</div>
      </div>
      <div class="editor-actions-right">
        <div class="counter">
          <span class="counter-amount">
            {{ wordCount }}
          </span>
          <span class="counter-unit">
            words
          </span>
        </div>
        <div class="counter">
          <span class="counter-amount">
            {{ characterCount }}
          </span>
          <span class="counter-unit">
            characters
          </span>
        </div>
        <div class="counter">
          <span class="counter-amount">
            {{ readingTime }}
          </span>
          <span class="counter-unit">
            reading time
          </span>
        </div>
      </div>
    </div>
    <textarea
      class="editor-content"
      v-model="content"
      @input="writing"
      placeholder="Write here, you can use Markdown. When posts are auto-saved you're redirected to the editing url, save it if you want to edit your post in the future."
      autofocus
    >{{ content }}</textarea>
  </div>
</template>

<script>
import axios from 'axios'

let saveTimeout;

export default {
  data: function () {
    return {
      content: '',
      url: '',
      showTools: false,
      saving: false
    }
  },
  created () {
    if (this.$route.params.postId && this.$route.params.token) {
      axios
        .get('/api/posts/' + this.$route.params.postId)
        .then((response) => {
          this.content = response.data.content
          this.url = window.location.protocol + '//' + window.location.host + '/p/' + this.$route.params.postId
        })
        .catch((error) => {
          this.$store.dispatch('setFlash', {
            type: 'alert',
            message: error
          })
          this.$router.push({ path: '/' })
        })
        .finally(() => {
          this.showUI()
        })
    }
  },
  computed: {
    wordCount () {
      return this.content ? this.content.split(" ").length : 0
    },
    characterCount () {
      return this.content.length
    },
    readingTime () {
      let totalTime = Math.round(this.content.split(" ").length / 200 * 60)
      let minutes = Math.floor(totalTime / 60)
      let seconds = totalTime % 60;
      return minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0')
    }
  },
  methods: {
    writing () {
      this.showTools = false
      this.saving = true
      clearTimeout(saveTimeout)
      saveTimeout = setTimeout(this.savePost, 1000)
    },
    savePost () {
      if (this.url && this.$route.params.token) {
        return axios
          .patch('/api/posts/' + this.$route.params.postId + '?token=' + this.$route.params.token, { content: this.content })
          .then((response) => {
            this.url = window.location.protocol + '//' + window.location.host + '/p/' + response.data.uuid
          })
          .catch((error) => {
            this.$store.dispatch('setFlash', {
              type: 'alert',
              message: error
            })
          })
          .finally(() => {
            this.showUI()
          })
      } else {
        return axios
          .post('/api/posts', { content: this.content })
          .then((response) => {
            this.url = window.location.protocol + '//' + window.location.host + '/p/' + response.data.uuid
            this.$router.push({ path: '/edit/' + response.data.uuid + '/' + response.data.token })
          })
          .catch((error) => {
            this.$store.dispatch('setFlash', {
              type: 'alert',
              message: error
            })
          })
          .finally(() => {
            this.showUI()
          })
      }
    },
    showUI () {
      this.saving = false
      this.showTools = true
      clearTimeout(saveTimeout)
    }
  }
}
</script>