<template>
  <div id="book">
    <input type="text" v-model="addbook"/>
    <button @click="addBook()">Add Book</button>
  </div>
</template>

<script>

export default {
  name: 'book',
  created() {
    fetch('books.json')
    .then((res) => { return res.json() })
    .then((res) => { this.books = res })
  },
  data: function () {
    return {
      message: "Hello Vue!",
      addbook: '',
      books: []
    }
  },
  methods: {
    addBook() {
      this.$http.post('books.json', {title: this.addbook}, {})
        .then((res) => window.location = "/books")
        .catch( (error) => console.log('Got a problem' + error));
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
