pragma solidity ^0.5.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";

contract StudentGrades {
    
    using SafeMath for uint;
    
    struct Student{
        string name;
        string email;
        uint[5] grades;
        uint weighted_sum;
        string letter_grade;
    }
    
    mapping(uint => Student) student_list;
    uint[] list_ids;
    
    function computeWeightedSum(uint[5] memory grades) pure internal returns(uint) {
        uint sum_assignment_grades = 0;
        for(uint i=0; i<=3; i++) {
            sum_assignment_grades += grades[i];
        }
        return sum_assignment_grades.mul(15) + grades[4].mul(40);
    }
    
    function toLetter(uint weighted_sum) pure internal returns(string memory) {
        if(weighted_sum < 6000){
            return "F";
        }
        if(weighted_sum < 6900){
            return "D";
        }
        if(weighted_sum < 7900){
            return "C";
        }
        if(weighted_sum < 8900){
            return "B";
        }
        return "A";
    }
    
    // from https://stackoverflow.com/questions/47129173/how-to-convert-uint-to-string-in-solidity
    function uintToStr(uint _i) internal pure returns (string memory _uintAsString) {
        uint number = _i;
        if (number == 0) {
            return "0";
        }
        uint j = number;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (number != 0) {
            bstr[k--] = byte(uint8(48 + number % 10));
            number /= 10;
        }
        return string(bstr);
    }
    
    // from https://ethereum.stackexchange.com/questions/78559/how-can-i-slice-bytes-strings-and-arrays-in-solidity
    function getSlice(uint256 begin, uint256 end, string memory text) internal pure returns (string memory) {
        bytes memory a = new bytes(end-begin+1);
        for(uint i=0;i<=end-begin;i++){
            a[i] = bytes(text)[i+begin-1];
        }
        return string(a);    
    }
    
    function create(uint id, string memory name, string memory email, uint[5] memory grades) public {
        uint weighted_sum = computeWeightedSum(grades);
        string memory letter_grade = toLetter(weighted_sum);
        list_ids.push(id);
        student_list[id] = Student(name, email, grades, weighted_sum, letter_grade);
    }
    
    function read(uint id) view public returns(string memory,string memory,uint[5] memory,string memory,string memory) {
	// just a UI fix to show the number as decimal, it might be better to do this off-chain in practice though
        string memory weighted_sum_str = uintToStr(student_list[id].weighted_sum);
        uint decimal_pos = bytes(uintToStr(student_list[id].weighted_sum.div(100))).length;
        weighted_sum_str = string(abi.encodePacked(getSlice(1, decimal_pos, weighted_sum_str), ".", getSlice(decimal_pos+1, 3, weighted_sum_str)));
        return(student_list[id].name, student_list[id].email, student_list[id].grades, weighted_sum_str, student_list[id].letter_grade);
    }
    
    function getIDs() view public returns(uint[] memory) {
        return list_ids;
    }
    
    function getNumStudents() view public returns(uint) {
        return list_ids.length;
    }
    
    function destroy(uint id) public {
        delete student_list[id];
    }
}