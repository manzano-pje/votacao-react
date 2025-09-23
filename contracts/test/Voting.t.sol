// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {Test} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";

contract VotingTest is Test{
    Voting public voting;

    // Simulate Voters
    address public owner;
    address public voter1;
    address public voter2;
    string public name1;
    string public name2;


    function setUp() public {
        // Create addresses for voters
        voter1 = address(2);
        voter2 = address(3);
        name1 = "Alice";
        name2 = "Bob";

        voting = new Voting();
        owner = address(this);     
    }

    // Test for the addCandidate function (Owner)
    function testAddCandidate() public{
        uint candidateId = voting.candidateId();
        vm.prank(owner);
        voting.addCandidate("Alice");
        assertEq(voting.candidateId(), candidateId + 1);
    }

        // test candidate null
    function testAddCandidateNull() public{
        uint candidateId = voting.candidateId();
        vm.expectRevert("Invalid name. Minimum of 3 characters");
        voting.addCandidate("");
        assertEq(voting.candidateId(), candidateId);
    }
    
    // Test name candidate <4 caracters
    function testAddCandidateInvalid() public {   
        uint candidateId = voting.candidateId();
        vm.expectRevert("Invalid name. Minimum of 3 characters");
        voting.addCandidate("My");
        assertEq(voting.candidateId(), candidateId);
    }

    // Test for tbe addCandidateNotOwner function (not owner)
    function testAddCandidateNotOwner() public{
        uint candidateId = voting.candidateId();
        vm.prank(voter1);
        vm.expectRevert();
        voting.addCandidate("Alice");
    }

    // Test for the duplicated candidate
    function testAddCandidateDuplicated() public{
        uint candidateId = voting.candidateId();
        vm.prank(owner);
        voting.addCandidate("Alice");
        assertEq(voting.candidateId(), candidateId + 1);
    }

    // Test for the vote function
    function testVote() public{
        vm.prank(voter1);
        vm.expectRevert("Candidate does not exist");
        voting.vote(1); // supondo que 1 seja o ID do candidato
        assertFalse(voting.hasVoted(voter1));
    }

    //Test read All Candidates
    function testGetAllCandidates() public {
        vm.prank(owner);
        voting.addCandidate("Alice");

        vm.prank(owner);
        voting.addCandidate("Bob");

        Voting.Candidate[] memory list = voting.getCandidates();

        assertEq(list.length, 2);
        assertEq(list[0].name, "Alice");
        assertEq(list[0].votes, 0);
        assertEq(list[1].name, "Bob");
        assertEq(list[1].votes, 0);
    }

    function testGetWinnerNoVotes() public {
        vm.prank(owner);
        voting.addCandidate("Alice");

        vm.prank(owner);
        voting.addCandidate("Bob");

        Voting.Candidate memory winner = voting.getWinner();
        assertEq(winner.name, "Alice"); // deve ser o primeiro, porque ninguém votou
    }

    function testGetWinnerWithVotes() public {
        vm.prank(owner);
        voting.addCandidate("Alice"); // id = 1

        vm.prank(owner);
        voting.addCandidate("Bob");   // id = 2

        // Voter1 vota em Bob
        vm.prank(voter1);
        voting.vote(2);

        // Voter2 vota em Bob
        vm.prank(voter2);
        voting.vote(2);

        Voting.Candidate memory winner = voting.getWinner();
        assertEq(winner.name, "Bob");
        assertEq(winner.votes, 2);
    }
}