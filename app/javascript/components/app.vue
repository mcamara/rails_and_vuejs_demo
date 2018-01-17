<template>
  <div id='app'>
    <div class="row mt mb">
      <search v-on:search="search" />
    </div>
    <div class="row mt mb">
      <div v-if="totalEvents == 0" class="text-center">
        <h2>There are no events that match the search</h2>
      </div>
      <div v-if="totalEvents == -1" class="text-center">
        <h2>Searching...</h2>
      </div>
      <div v-if="totalEvents > 0">
        <h2>Events ({{ totalEvents }} found)</h2>
      </div>
      <event
        v-for="item in eventList"
        v-bind:event="item"
        v-bind:key="item.id"
        v-on:search="search" />
    </div>
    <div class="row mt mb" v-if="totalEvents > eventList.length">
      <div class="col-xs-12 col-sm-4 col-sm-offset-4 mt mb">
        <button type="button" class="btn btn-primary btn-lg btn-block" v-on:click="loadMore()">
          Load more ({{ eventList.length }}/{{ totalEvents }} events in screen)
        </button>
      </div>
    </div>
  </div>
</template>

<script>
  import Event from './event.vue'
  import Search from './search.vue'

  export default {
    components: {
      event: Event,
      search: Search
    },
    data: function () {
      return {
        eventList: [],
        totalEvents: -1,
        page: 1,
        searchName: "",
        searchCategoryId: "",
        searchCity: "",
        searchStartTime: this.$moment().format('YYYY-MM-DD')
      }
    },
    mounted: function()
    {
      this.fetchApiEvents()
    },
    methods: {
      fetchApiEvents: function() {
        this.$http.get('/api/events', {
          params: {
            name: this.searchName,
            categories: [this.searchCategoryId],
            city: this.searchCity,
            start_time: this.searchStartTime,
            page: this.page
          }
        }).then(response => {
          this.eventList = [...this.eventList, ...response.data]
          this.totalEvents = parseInt(response.headers['x-total-count'])
        }).catch(error => {
          alert(`Error : ${error}`)
          // TODO: To improve
        });
      },
      loadMore: function() {
        this.page = this.page + 1
        this.fetchApiEvents()
      },
      search: function(name, categoryId, city, startTime) {
        this.searchName = name
        this.searchCategoryId = categoryId
        this.searchCity = city
        this.searchStartTime = startTime
        this.eventList = []
        this.totalEvents = -1
        this.page = 1
        this.fetchApiEvents()
      }
    }
  }
</script>

<style scoped>
</style>
