<template>
  <div class="event col-xs-12 col-sm-6 col-lg-4">
    <div class="event-image">
      <img :src="event.image_url">
    </div>
    <div class="event-title">
      <h3>{{ event.name }}</h3>
      <h4>{{ event.city.name }}</h4>
    </div>

  </div>
</template>

<script>
  export default {
    props: ['event']
  }
</script>

<style scoped>
  div.event {
    padding: 40px;
    height: 350px;
  }
  .event-image {
    height: 180px;
    width: 100%;
    overflow: hidden
  }

  .event-image img {
    height: auto;
  }
</style>
