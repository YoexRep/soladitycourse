//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory{


//  Creo un listado de contratos simpleStorage
        SimpleStorage[] public simpleStorageArray;


        // Creo 1 contrato y lo almaceno en el array
        function createSimpleStorageContract() public {
            SimpleStorage simpleStorage = new SimpleStorage();
            simpleStorageArray.push(simpleStorage);


        }


        //Funcion para guardar un contrato en en contrato storagefactory
        /*Para interactuar con cualquier contrato siempre necesitaras 2 cosas:
        
            1- Address -- es la direccion de memoria del contrato- esta la podemos obtener desde nuestra variable simpleStorageArray, ya que guarda la direccion de memoria
            2- ABI - Aplicacion binary Interface -- El abi le dira como exactamente puede interactuar con el contrato, son todos los inputs y output del contrato
        
        
        */

        //Me recibe el indice y el numero de contrato para guardar en el contrato
        function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
                SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
                simpleStorage.store(_simpleStorageNumber);


        }


//Me recibe el indice y me devuelve el numero 
        function sfGet(uint256 _simpleStorageIndex) public view returns (uint256 ){
             SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
                return simpleStorage.retrieve();
        }










}