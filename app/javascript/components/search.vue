<template>
  <div class="search">
    <div class="col-xs-12 text-center">
      <h1>Search event</h1>
    </div>
    <form v-on:submit.prevent="onSubmit" class="row form-inline">
      <div class="row mt mb">
        <div class="form-group col-xs-12 col-sm-6 col-sm-offset-2">
          <label class="sr-only" for="name">Search by name</label>
          <input type="text" class="form-control" id="name" placeholder="Search by name" v-model="name" style='width:100%'>
        </div>
        <div class="form-group col-xs-12 col-sm-2">
          <label class="sr-only" for="city">Search by city</label>
          <input type="text" class="form-control" id="city" placeholder="Search by city" v-model="city" style='width:100%'>
        </div>
      </div>
      <div class="row mt mb">
        <div class="form-group col-xs-12 col-sm-3 col-sm-offset-3">
          <label class="sr-only" for="category">Category</label>
          <select class="form-control" v-model="categorySelected" style='width:100%'>
            <option value="" selected>Select Category</option>
            <option
              v-for="category in categoriesList"
              v-bind:value="category.id">
              {{ category.name }}
            </option>
          </select>
        </div>
        <div class="form-group col-xs-12 col-sm-3">
          <label class="sr-only" for="start-date">Date</label>
          <input type="date" class="form-control" id="start-date" placeholder="Search by name" v-model="startDate" style='width:100%'>
        </div>
      </div>
      <div class="row text-center mt mb">
        <button type="submit" class="btn btn-primary col-xs-12 col-sm-2 col-sm-offset-5">Search</button>
      </div>
    </form>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        categoriesList: [],
        name: "",
        city: "",
        categorySelected: "",
        startDate: this.$moment().format('YYYY-MM-DD')
      }
    },
    mounted: function() {
      this.fetchCategories()
    },
    methods: {
      onSubmit: function() {
        this.$emit('search', this.name, this.categorySelected, this.city, this.startDate)
      },
      fetchCategories: function() {
        this.$http.get('/api/categories').then(response => {
          this.categoriesList = response.data
        }).catch(error => {
          alert(`Error : ${error}`)
        });
      }
    }
  }
</script>

<style scoped>
</style>
