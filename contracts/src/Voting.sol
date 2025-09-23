//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// CONTRACT START

contract Voting{

    // ========================================
    // EVENTS
    // ========================================

    event Vote(uint indexed candidateIndex, string indexed candidateName, uint voteCount);

    // ========================================
    // STATE VARIABLES
    // ========================================
    address public owner;
    uint public candidateId  = 1;
    uint public totalVotes = 0;

    // ========================================
    // MAPPING
    // ========================================

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

     // ========================================
    // COSNTRUCTOR
    // ========================================   

    constructor(){
        owner = msg.sender;
    }

    // ========================================
    // MODIFIER
    // ========================================

    modifier onlyOwner(){
        require(owner == msg.sender, "Only the owner can register a candidate.");
        _;
    }

    // ========================================
    // STRUCT
    // ========================================

    struct Candidate{
        uint candidateIndex;
        string name;
        uint votes;
    }

    // ========================================
    // FUNCTIONS
    // ========================================

    // Unique Candidate
    function addCandidate(string memory _name) external onlyOwner{ 
        bytes memory nameBytes = bytes(_name);
        if (nameBytes.length < 3){
            revert("Invalid name. Minimum of 3 characters");
        }
        for (uint i = 1 ; i < candidateId ; i++){
            require(
                keccak256(bytes(candidates[i].name)) != keccak256(bytes(_name)),
                "Candidate is already registered"
            );
        }
        candidates[candidateId] = Candidate(candidateId, _name, 0);
        candidateId ++;    
    }

    // Unique vote by user
    function vote(uint _candidateIndex) external returns (string memory){  
        if (hasVoted[msg.sender]){
            revert("voter has already voted.");
        }
        
        if (_candidateIndex <= 0 || _candidateIndex >= candidateId){
            revert("Candidate does not exist");
        }

        candidates[_candidateIndex].votes ++;
        hasVoted[msg.sender] = true;
        totalVotes ++;
        return ("vote confirmed!");
    } 
        
    // Return all candidates and number votes
    function getCandidates() external view returns(Candidate[] memory){
        Candidate[] memory list = new Candidate[](candidateId - 1);
        for (uint i = 1 ; i < candidateId; i++){
            list[i - 1] = candidates[i];
        }
        return list;
    } 

    //Return winner candidate
    function getWinner()external view returns(Candidate memory){
        Candidate memory winner = candidates[1];
        for (uint i = 2; i < candidateId; i++){
            if(winner.votes < candidates[i].votes){
                winner = candidates[i];
            }    
        }
        return winner;
    } 
}