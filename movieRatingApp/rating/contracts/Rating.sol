pragma solidity ^0.5.16;

contract Rating {
    mapping (bytes32 => uint8) public ratingReceived;

    bytes32[] public movieList;

    constructor(bytes32[] memory movieNames) public {
        movieList = movieNames;
    }

    function totalVotesFor(bytes32 movie) view public returns (uint8) {
        return ratingReceived[movie];
    }

    function voteForMovie(bytes32 movie) public {
        ratingReceived[movie] += 1;
    }
}