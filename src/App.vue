<template>
  <div id="app">
    <!-- <img alt="Vue logo" src="./assets/logo.png"> -->
    <div>
      <img alt="logo" src="./assets/icon.png">
      <h1>Gorucu - Bet on Nature</h1>
      <p>Autoinvest on crops based on rainfall. Powered by Chainlink Oracles. (Only Kovan Testnet for now)</p>
    </div>
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <!-- <Form /> -->
    <div>
<!--       <button
        type="button"
        class="btn"
        @click="showModal"
      >
        Open Modal!
      </button>   -->   


    <VueLoadingButton
      aria-label="Start"
      class="button"
      @click.native="showModal"
      :loading="false"
      :styled="true"
    >Start</VueLoadingButton>

      <Metamask />
    </div>


    <Modal
      v-show="isModalVisible"
      @close="closeModal"
    />


   <!--  <button id="show-modal" @click="showModal = true">Show Modal</button>
    <modal v-if="showModal" @close="showModal = false">
      <Form2 />
    </modal> -->
    <Table/>
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import Table from './components/table.vue'
// import Form from './components/form.vue'
// import Form2 from './components/form2.vue'
import Modal from './components/modal.vue';
// import Form2 from './components/form2.vue'
import Metamask from './components/metamask.vue';
import VueLoadingButton from "vue-loading-button";

import Vue from 'vue'
Vue.component("modal", {
  template: "#modal-template"
});

export default {
  name: 'app',
  components: {
    // HelloWorld,
    Table,
    // Form,
    // Form2,
    Modal,
    Metamask,
    VueLoadingButton
  },
  data() {
    return {
      isModalVisible: false,
    };
  },
  methods: {
    showModal() {
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
