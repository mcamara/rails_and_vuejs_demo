<template>
  <div id='app'>
    <event
      v-for="item in eventList"
      v-bind:event="item"
      v-bind:key="item.id" />
  </div>
</template>

<script>
  import VueAxios from 'vue-axios/dist/vue-axios.min'
  import Event from './event.vue'

  export default {
    components: {
      event: Event
    },
    data: function () {
      return {
        eventList: []
      }
    },
    mounted: function()
    {
      this.fetchApiEvents("", "", "")
    },
    methods: {
      fetchApiEvents: function(city, category, name) {
        this.$http.get('/api/events', {
          params: {
            city: city,
            categories: [category],
            name: name
          }
        }).then(response => {
          console.log(response.data)
          this.eventList = response.data
        }).catch(error => {
          console.log(error)
          alert(`Error : ${error}`)
          // TODO: To improve
        });
      }
    }
  }
</script>

<style scoped>
</style>
