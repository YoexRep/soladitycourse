
//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage{

        uint256 public favoriteNumber;

        function store(uint256 _favoriteNumber) public {
            favoriteNumber = _favoriteNumber;
        }


            //View, pure

         function retrieve() public view returns(uint256){
                return favoriteNumber;
         }

         /*
         
                las funciones con view y pure no gastan gas, al menos de que sean invocadas desde otra parte que si gaste
         
         
         */





}