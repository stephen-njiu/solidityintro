// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {AggregatorV3Interface} from "@chainlink/contracts@1.4.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe {
    address public ethUsd = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address public btcUsd = 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43;
    int256 public  minBal = 2e15;
    address[] public funders;
    address public owner;
    
    mapping(address funder => uint256) public addressToAmountFunded;
    function fund() public payable {
        // allow users to send $ 
        // Have a minimum amount of $ sent
        require(getConversionRate(int256(msg.value)) > minBal, "Not enough Money");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
    // Transactions - Function Call
    // Nonce: tc count for the account
    // Gas Price: price per unit of gas (in wei)
    // Gas Limit: max gas that this tx can use 
    // To: address that the tx is sent to 
    // Value: amount of wei to send 
    // Data: what to send to the To address 
    // v,r,s: components of tx signature 
    // cryptographic algo

        AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */

    constructor() {
        dataFeed = AggregatorV3Interface(
            ethUsd
        );
    }
    // Returns the latest answer.

    function getPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function getConversionRate(int256 ethAmount) public view returns (int256) {
        int256 ethPrice = getPrice();
        int ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function withdraw() onlyOwner public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Sender is not the owner");
        _;
    }
}

