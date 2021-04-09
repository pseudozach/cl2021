<template>
	<div>
		<!-- form wrapper -->
		<fvl-form method="post" :data="form" url="/create">
		  <!-- Text input component -->
		  

		  <!-- Textarea component -->
		  <!-- <fvl-textarea :value.sync="form.bio" label="Bio" name="bio" /> -->

		  <!-- Radio component with options -->
		  <!-- <fvl-radio :checked.sync="form.pet" :options="{'cat': 'Cat', 'dog': 'Dog'}" label="Favorite pet" name="pet" /> -->

		  <fvl-select
			  label="Select Crop - Region Pair"
			  name="region"
			  placeholder="-- Crop - Region --"
			  :allowEmpty="false"
			  :options="{ 'gujarat': 'Cotton - India', 'Nuwara Eliya': 'Tea - Sri Lanka', 'hunan': 'Rice - China', iowa: 'Corn - USA' }"
			  :selected.sync="form.cropregion"
			/>
			<!-- Gujarat / ceylon / hunan / Iowa -->

			<div id="popholder" style="margin: 10px;" v-if="poptext != ''">{{poptext}}</div>
			<!-- <div id="txholderholder" v-if="txid != ''">Transaction ID: {{txid}}</div> -->
			<!-- <div id="stuffholderholder" v-if="stuff != ''">stuff: {{stuff}}</div> -->
		  <!-- Submit button -->
		  <!-- <fvl-submit>Validate</fvl-submit> -->

<!--     	<button
            type="button"
            class="btn-primary"
            @click="setstuff"
          >
            set stuff
      	</button> -->

      	<VueLoadingButton 
            aria-label="Get Precipitation Data from Oracle"
            class="button"
            @click.native="getpop"
            :loading="isLoading"
            :styled="true"
      	>Get Precipitation Data from Oracle
      	</VueLoadingButton>
<!--     	<button
            type="button"
            class="btn-primary"
            @click="getpop"
          >
            Get Precipitation Data from Oracle
      	</button> -->
      	
      	<fvl-input :value.sync="form.amount" label="Amount (eth)" name="amount" style="margin-top: 10px;"/>

<!--     	<button
            type="button"
            class="btn-primary"
            @click="triggercontract"
          >
            Deposit to Contract
      	</button> -->


      	<VueLoadingButton 
            aria-label="Deposit to Contract"
            class="button"
            @click.native="triggercontract"
            :loading="isLoadingContract"
            :styled="true"
      	>Deposit to Contract
      	</VueLoadingButton>

		</fvl-form>
	</div>
</template>

<style>
	@import '~formvuelar/dist/formvuelar.css';
	.pointer-events-none {
		display: none;
	}
</style>

<script>
	import { FvlForm, FvlInput, FvlTextarea, FvlRadio, FvlSubmit, FvlSelect } from 'formvuelar'
	import VueLoadingButton from 'vue-loading-button'

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

export default {
	name: 'my-component',
	data() {
	return {
	    form: {
	        amount: '',
	        cropregion: ''
	    	},
	    txid: '',
	    pop: '',
	    poptext: '',
	    stuff: '',
	    isLoading: false,
	    isLoadingContract: false,
		}
	},
    components: {
        FvlForm,
        FvlInput,
        FvlTextarea,
        FvlRadio,
        FvlSubmit,
        FvlSelect,
        VueLoadingButton,
    },
    methods: {
    	setstuff(){

    		let thisthing = this
    		console.log("1setting stuff to yes ", this.stuff);
    		thisthing.stuff = "yes";
    		console.log("2setting stuff to yes ", this.stuff);
    	},
    	getpop(){
    		let thisthing = this
    		console.log("get pop contract ", this.form.cropregion);
    		this.poptext = "Getting precipitation for " + this.form.cropregion + ". Please wait...";
    		thisthing.isLoading = true;
	      	let web3 = window.web3;
      		web3 = new Web3(web3.currentProvider);
	 		web3.eth.defaultAccount=web3.eth.accounts[0]
    		var contractABI = [
				{
					"inputs": [],
					"stateMutability": "nonpayable",
					"type": "constructor"
				},
				{
					"anonymous": false,
					"inputs": [
						{
							"indexed": true,
							"internalType": "bytes32",
							"name": "id",
							"type": "bytes32"
						}
					],
					"name": "ChainlinkCancelled",
					"type": "event"
				},
				{
					"anonymous": false,
					"inputs": [
						{
							"indexed": true,
							"internalType": "bytes32",
							"name": "id",
							"type": "bytes32"
						}
					],
					"name": "ChainlinkFulfilled",
					"type": "event"
				},
				{
					"anonymous": false,
					"inputs": [
						{
							"indexed": true,
							"internalType": "bytes32",
							"name": "id",
							"type": "bytes32"
						}
					],
					"name": "ChainlinkRequested",
					"type": "event"
				},
				{
					"inputs": [
						{
							"internalType": "bytes32",
							"name": "_requestId",
							"type": "bytes32"
						},
						{
							"internalType": "uint256",
							"name": "_result",
							"type": "uint256"
						}
					],
					"name": "fulfillEthereumPrice",
					"outputs": [],
					"stateMutability": "nonpayable",
					"type": "function"
				},
				{
					"inputs": [
						{
							"internalType": "string",
							"name": "_city",
							"type": "string"
						}
					],
					"name": "requestForecast",
					"outputs": [],
					"stateMutability": "nonpayable",
					"type": "function"
				},
				{
					"inputs": [],
					"name": "result",
					"outputs": [
						{
							"internalType": "uint256",
							"name": "",
							"type": "uint256"
						}
					],
					"stateMutability": "view",
					"type": "function"
				}
			];
			//openweatherconsumer contract - 0x54b9660Bd9FCE18E8Cd40f630DDAEA00F6c13aeF

	 	// 	var etherAmount = web3.toBigNumber(this.form.amount);
			// var weiValue = web3.toWei(etherAmount,'ether');
	      	var thecontract = web3.eth.contract(contractABI);
	 		var MyContract = thecontract.at('0x54b9660Bd9FCE18E8Cd40f630DDAEA00F6c13aeF');
	 		// var mydata = MyContract.requestForecast.getData("hunan");
	 		var oracletxid;
			MyContract.requestForecast(this.form.cropregion, function(err, res){
				if(err){
					console.log("err: ", err);
					thisthing.isLoading = false;
				}
				//gives tx as output
				console.log("res: ", res);
				oracletxid = res;
				thisthing.poptext = "Triggered oracle transaction: " + res + ". Fetching precipitation data, please wait...";
				setTimeout(() => {
					MyContract.result.call(function(err, res){
						if(err){
							console.log("result err: ", err);
							thisthing.isLoading = false;
						}
						//gives percentage of precipitation
						// console.log("result: ", res);
						console.log("pop: ", parseInt(res, 10));
						thisthing.pop = parseInt(res, 10);
						thisthing.poptext = "Current chance of Precipitation: " + parseInt(res, 10)+"%";
						if(parseInt(res, 10) > 5){
							thisthing.poptext += "\nRain is good for this crop. Long this crop by depositing any amount into the contract."
						} else {
							thisthing.poptext += "\nLess rain than needed. Short this crop by depositing any amount into the contract."
						}
						thisthing.isLoading = false;
					  	db.ref("gorucu").push({account: web3.eth.accounts[0], cropregion: thisthing.form.cropregion, precipitation: thisthing.pop, amount: thisthing.form.amount, txid: "https://kovan.etherscan.io/tx/"+oracletxid, createdAt: firebase.database.ServerValue.TIMESTAMP});
					});
				}, 30000);
			})

    	},
      triggercontract() {
      	let thisthing = this
      	console.log("trigger contract ", this.form.amount);
      	this.poptext = "Depositing funds to the contract. Please wait...";
      	thisthing.isLoadingContract = true;
      	let web3 = window.web3;
      	web3 = new Web3(web3.currentProvider);
      	let myaddress = web3.eth.coinbase;
      	web3.eth.getBalance(myaddress, function (err, newBalance) { console.log(parseInt(newBalance, 10));});

      	// console.log("preparing deposit");
      	var contractABI = [
			{
				"constant": false,
				"inputs": [],
				"name": "invest",
				"outputs": [],
				"payable": true,
				"stateMutability": "payable",
				"type": "function"
			},
			{
				"constant": false,
				"inputs": [],
				"name": "withdraw",
				"outputs": [],
				"payable": false,
				"stateMutability": "nonpayable",
				"type": "function"
			}
		];
 		var etherAmount = web3.toBigNumber(this.form.amount);
		var weiValue = web3.toWei(etherAmount,'ether');
      	var thecontract = web3.eth.contract(contractABI);
 		var MyContract = thecontract.at('0x9b2D8E28fE37dec5417C540ff7245f16be9661AD');
		MyContract.invest({from: web3.eth.accounts[0], value: weiValue}, function(err, res){
			if(err){
				console.log("err: ", err);
				thisthing.isLoadingContract = false;
			}
			//gives tx as output
			console.log("res: ", res);
			thisthing.poptext = "Triggered deposit transaction: " + res;
			thisthing.isLoadingContract = false;
		  	db.ref("gorucu").push({account: web3.eth.accounts[0], cropregion: thisthing.form.cropregion, precipitation: thisthing.pop, amount: thisthing.form.amount, txid: "https://kovan.etherscan.io/tx/"+res, createdAt: firebase.database.ServerValue.TIMESTAMP});
		})
        // this.$emit('close');
      },
    },
}

</script>

