<!-- <template>
  <div style="width: 600px">
    <vue-table-dynamic 
      :params="params" 
      ref="table"
    >
    </vue-table-dynamic>
  </div>
</template> -->

<!-- compactMode -->
<!-- :fixed-header="true" -->
<template>
  <div style="margin: 20px;">
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{
        enabled: false,
        placeholder: 'Search Cashback Rates',
      }"
      :pagination-options="{
        enabled: true,
        perPage: 20
      }">
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field == 'txid'">
          <!-- style="font-weight: bold; color: blue;" -->
          <a :href="props.row.txid" target="_blank">txid link</a> 
        </span>
        <span v-else>
          {{props.formattedRow[props.column.field]}}
        </span>
      </template>
    </vue-good-table>
  </div>
</template>





<script>
// import VueTableDynamic from 'vue-table-dynamic'

// import VueGoodTablePlugin from 'vue-good-table';
// // import the styles
// import 'vue-good-table/dist/vue-good-table.css'
// Vue.use(VueGoodTablePlugin);


import 'vue-good-table/dist/vue-good-table.css'
import { VueGoodTable } from 'vue-good-table';

import Vue from 'vue'
import VueMeta from 'vue-meta'
Vue.use(VueMeta)
// import { db } from '../main'

// Get a RTDB instance
import firebase from 'firebase/app'
import 'firebase/database'

var firebaseConfig = {
  apiKey: process.env.VUE_APP_fb_apikey,
  authDomain: process.env.VUE_APP_fb_authdomain,
  databaseURL: process.env.VUE_APP_fb_dburl,
  projectId: process.env.VUE_APP_fb_projectid,
  storageBucket: process.env.VUE_APP_fb_storagebucket,
  messagingSenderId: process.env.VUE_APP_fb_msgsenderid,
  appId: process.env.VUE_APP_fb_appid,
  measurementId: process.env.VUE_APP_fb_measurementid
};
  if (!firebase.apps.length) {
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  }

const db = firebase
  // .initializeApp({ databaseURL: 'https://MY-DATABASE.firebaseio.com' })
  .database()

// console.log("todos: ", db.ref('cbtable'));
// // retrieve a collection
// db.ref('cbtable').once('value', snapshot => {
//   const documents = snapshot.val()
//   console.log("got cbtable: ", documents)
//   // do something with documents
// })

// export default {
//   name: 'Demo',
//   // firebase: function () {
//   //    return {
//   //        fbObj: db.ref('cbtable')
//   //    }
//   // },
//   firebase: {
//     fbObj: db.ref('cbtable')
//   },
//   computed: {
//     data() {
//         return this.fbObj;
//     }
//   },
//   data() {
//     return {
//       params: {
//         data: this.fbObj,
//         // [
//         //   ['Index', 'Data1', 'Data2', 'Data3'],
//         //   [1, 'b3ba90', '7c95f7', '9a3853'],
//         //   [2, 'ec0b78', 'ba045d', 'ecf03c'],
//         //   [3, '63788d', 'a8c325', 'aab418']
//         // ],
//         header: 'row',
//         enableSearch: true,
//         sort: [0, 1]
//       }
//     }
//   },
//   methods: {
//   },
//   components: { VueTableDynamic }
// }


export default {
  name: 'my-component',
  // firebase: function () {
  //   return {
  //     fbObj: db.ref('cbtable'),
  //     tableitems: []
  //   }
  // },
  // watch: {
  //   '$route': 'fetchData'
  // },
  methods: {
    fetchData() {
      db.ref("gorucu").on("value", snapshot => {
        let data = snapshot.val();
        let messages = [];
        Object.keys(data).forEach(key => {
          // console.log("each data[key]: ", data[key]);
          var msgtopush = {merchant: key, ...data[key]};
          // console.log("msgtopush: ", msgtopush);
          messages.push(msgtopush);
          // messages.push({
          //   merchant: key,
          //   lolli: data[key].lolli,
          //   fold: data[key].fold,
          //   strike: data[key].strike,
          //   updatedAt: ''
          // });
        });
        this.rows = messages;
        // this.tableitems = messages;
        // this.tableitems = [{ merchant:"Amazon", lolli:0.01, fold: 0.01, createdAt: ''}];
        // this.mytableitems = [{ merchant:"Amazon", lolli:0.01, fold: 0.01, createdAt: ''}];
        // this.rows = [{ merchant:"Amazon", lolli:0.01, fold: 0.01, createdAt: ''}];
        // console.log("fetchData this.rows: ", this.rows);
        // viewMessage.messages = messages;
      });    
    },
  },
  created() {
    // let viewMessage = this;
    // const itemsRef = fire.database().ref("cbtable");
    this.fetchData()
  },
  data(){
    // console.log("data return this.rows: ", this.rows);
    return {
      columns: [
        {
          label: 'Account',
          field: 'account',
        },
        {
          label: 'Crop - Region',
          field: 'cropregion',
          // type: 'number',
          // type: 'percentage',
        },
        {
          label: 'Precipitation',
          field: 'precipitation',
          // type: 'number',
          // type: 'percentage',
        },
        {
          label: 'Amount Invested',
          field: 'amount',
          // type: 'number',
          // type: 'percentage',
        },
        {
          label: 'txid',
          field: 'txid',
          // type: 'number',
          // type: 'percentage',
        },
        // {
        //   label: 'Liquigate',
        //   field: 'liquigate',
        //   // type: 'number',
        //   // type: 'percentage',
        // },
        {
          // 📅
          label: 'Created At',
          field: 'createdAt',
          type: 'date',
          dateInputFormat: 'T',
          dateOutputFormat: 'MMM do yyyy HH:mm:ss',
        },
        // {
        //   label: 'Percent',
        //   field: 'cashback',
        //   type: 'percentage',
        // },
      ],
      rows: [],
      // mytableitems: []
      // rows: [
      //      { merchant:"Amazon", lolli:0.01, fold: 0.01, createdAt: ''},
      //   // { id:1, name:"John", age: 20, createdAt: '',score: 0.03343 },
      //   // { id:2, name:"Jane", age: 24, createdAt: '2011-10-31', score: 0.03343 },
      //   // { id:3, name:"Susan", age: 16, createdAt: '2011-10-30', score: 0.03343 },
      //   // { id:4, name:"Chris", age: 55, createdAt: '2011-10-11', score: 0.03343 },
      //   // { id:5, name:"Dan", age: 40, createdAt: '2011-10-21', score: 0.03343 },
      //   // { id:6, name:"John", age: 20, createdAt: '2011-10-31', score: 0.03343 },
      // ],
    };
  },
  components: {
    VueGoodTable,
  }
};
</script>





