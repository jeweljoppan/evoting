pragma solidity ^0.4.17;

contract Voting{
    address public manager;
    address[] public players;
    
    function Voting() public{
        manager = msg.sender;
    }
    
     
    event AddedCandidate(uint candidateID); 
    
    modifier restricted {
        require(msg.sender == manager);
        _;
    }
    
    modifier limit {
        for ( uint i = 0; i< numvoters; i++){
            if (players[i] == msg.sender){
                revert();
            }
        }
        _;
    }  
    
    struct voter{
        //uint weighted;
        string uid;
        uint candidateIDvote;
        bool voted;
        
    }
    
    struct candidate{
        string name;
        string party;
        bool doesExist;
        
    }
    
    uint numcandidates;
    uint numvoters;
    
    mapping (uint => candidate)  candidates;
    mapping (uint => voter) voters;
    
    function addCandidate(string name, string party) public restricted {
        uint candidateID = numcandidates++;
        candidates[candidateID] = candidate(name,party,true);
        AddedCandidate(candidateID);
         
    }
    function vote(string uid, uint candidateID) public limit {
        if(candidates[candidateID].doesExist == true) {
            uint voterID = numvoters++;
            voters[voterID] = voter(uid,candidateID, true);
            players.push(msg.sender);
                
            }
            
    }
    
    
    function totalVotes(uint candidateID) public view returns (uint)   {
        uint numOfVotes = 0;
        for (uint i = 0; i < numvoters; i++) {
            if (voters[i].candidateIDvote == candidateID) {
                numOfVotes++;
            }
        }
        return numOfVotes; 
    }
    function getNumOfCandidates() public view returns(uint) {
        return numcandidates;
    }

    function getNumOfVoters() public view returns(uint) {
        return numvoters;
    }
    
    function getCandidate(uint candidateID) public view returns (uint,string, string) {
        return (candidateID,candidates[candidateID].name,candidates[candidateID].party);
    }
}
   
    
