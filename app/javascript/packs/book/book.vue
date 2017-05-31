<template>
  <div id="book">
    <div class="container">
      <div class="row">
        <div class="col-md-12 col-md-offset-2">
          <div class="col-md-6">
            <input type="text" v-model="addbook" class="form-control"/>
          </div>
          <div class="col-md-6">
            <button @click="addBook()" class="btn btn-success">Add Book</button>
          </div>
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-7 col-md-offset-2">
          <table class="table">
            <thead>
              <tr>
                <th>#</th>
                <th>Book Title</th>
                <th>Operations</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for='(book, index) in books'>
                <td>{{ index + 1 }}</td>
                <td>{{ book.title }}</td>
                <td></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'book',
  data() {
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
