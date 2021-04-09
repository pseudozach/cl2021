pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract OpenWeatherConsumer is ChainlinkClient {
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    uint256 public result;

    constructor() public {
        setPublicChainlinkToken();
        // oracle.sol contract address 
        oracle = 0xAa00CcC5A59459e1C13268E8270E1E0417440D35;

        // node running modified openweather adapter that can fetch rainfall
        jobId = "9f16101a8677468a874dfc948c809806";
        fee = 0.1 * 10 ** 18;
    }
    
    /**
     * Initial request
     */
    function requestForecast(string memory _city) public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillEthereumPrice.selector);
        req.add("city", _city);

        //get percentage of precipitation for the city
        req.add("copyPath", "list.0.pop");

        // convert to percentage
        int timesAmount = 10**2;
        req.addInt("times", timesAmount);
        
        sendChainlinkRequestTo(oracle, req, fee);
    }
    
    /**
     * Callback function
     */
    function fulfillEthereumPrice(bytes32 _requestId, uint256 _result) public recordChainlinkFulfillment(_requestId) {
        result = _result;
    }
}
