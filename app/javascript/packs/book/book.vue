<template>
  <div id="book">
    <div class="container">
      <div class="col-md-12">
        <center>
          <input type="text" v-model="addbook"/>
          <button @click="addBook()">Add Book</button>
          <table>
            <thead>
              <tr>
                <th>Title</th>
                <th colspan="3"></th>
              </tr>
            </thead>
            <tbody>
              <div v-for="book in books">
                {{ book.title }}
              </div>
            </tbody>
          </table>
        </center>
      </div>
    </div>
  </div>

</template>

<script>

export default {
  name: 'book',
  data: function () {
    return {
      books: [],
      addbook: ''
    }
  },
  created() {
    this.fetchBook();
  },
  methods: {
    fetchBook() {
      fetch('books.json')
      .then((res) => { return res.json() })
      .then((res) => { this.books = res })
    },
    addBook() {
      this.$http.post('books.json', {title: this.addbook}, {})
        .then((res) => this.fetchBook())
        .catch( (error) => console.log('Got a problem' + error));
    }
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
