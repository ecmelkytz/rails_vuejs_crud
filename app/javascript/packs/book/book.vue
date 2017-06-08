<template>
  <div id="book">
    <navbar-book></navbar-book>
    <div class="container">
      <br><br>
      <center><h1>Books</h1></center>
      <br>
      <div class="row">
        <div class="col-md-12 col-md-offset-2">
          <form>
            <div class="col-md-6">
              <input type="text" v-model="book" class="form-control" autofocus="true">
            </div>
            <div class="col-md-6">
              <button @click="addBook()" class="btn btn-primary" :disabled="!book.length">Add Book</button>
            </div>
          </form>
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
                <th>Like Count</th>
                <th>Operations</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for='(book, index) in books'>
                <td>{{ index + 1 }}</td>
                <td v-show="!book.editable" @click='toggleEdit(this, book)' style="cursor: pointer;">{{ book.title }}</td>
                <input type="text" v-model="book.title" v-bind:id="book.title" v-show="book.editable" @blur="editBook(book)">
                <td>{{ book.like_count }}</td>
                <td>
                  <button class="btn btn-default btn-xs" @click="likeBook(book)">Like</button>
                  <button class="btn btn-default btn-xs" @click="dislikeBook(book)">Dislike</button>
                  <button class="btn btn-danger btn-xs" @click="deleteBook(book.id)">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

import Navbar from '../book/navbar.vue'

export default {
  name: 'book',
  components: {
    'navbar-book': Navbar
  },
  data() {
    return {
      books: [],
      book: ''
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
      this.$http.post('books.json', {title: this.book}, {})
        .then((res) => this.fetchBook(), this.book = '')
        .catch((error) => console.log('Got a problem' + error));
    },
    likeBook(book) {
      let count = book.like_count + 1
      this.$http.put('books/' + book.id, {like_count: count})
        .then((res) => this.fetchBook(), this.book = '')
        .catch((error) => console.log('Got a problem' + error));
    },
    dislikeBook(book) {
      if (book.like_count > 0) {
        let count = book.like_count - 1
        this.$http.put('books/' + book.id, {like_count: count})
          .then((res) => this.fetchBook(), this.book = '')
          .catch((error) => console.log('Got a problem' + error));
      }
    },
    deleteBook(book_id) {
      this.$http.delete('books/' + book_id)
        .then((res) => this.fetchBook())
        .catch((error) => console.log('Got a problem' + error));
    },
    toggleEdit: function(ev, book) {
      this.$http.put('books/' + book.id, {editable: true})
        .then((res) => this.fetchBook())
    },
    editBook(book) {
      this.$http.put('books/' + book.id, {editable: false, title: book.title })
        .then((res) => this.fetchBook())
    },
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
