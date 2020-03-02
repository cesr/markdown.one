import Vue from 'vue'
import Router from 'vue-router'

const vuePath = '/'
const editPath = '/edit/'

const routerOptions = [
  {
    path: vuePath,
    name: 'EmptyEditor',
    component: 'Editor'
  },
  {
    path: editPath,
    name: 'Redirect',
    redirect: function (to) {
      if (to.query.redirect) {
        var path = to.query.redirect
        delete to.query.redirect
        return {
          path: editPath + path,
          query: to.query
        }
      } else {
        return {
          path: vuePath,
          query: to.query
        }
      }
    }
  },
  {
    path: editPath + ':postId/:token',
    name: 'Editor',
    component: 'Editor'
  }
]

const routes = routerOptions.map(route => {
  return {
    ...route,
    component: () => import(`../components/${route.component}.vue`)
  }
})

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes
})

export default router
