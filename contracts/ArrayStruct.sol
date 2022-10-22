//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ArrayStruct{



/*Podemos crear structura de datos como objetos para guardar informacion */
People public person =  People({favoriteNumber: 2, name: "Yoel"});


struct People{
    uint256 favoriteNumber;
    string name;
}


//la otra manera es creando un array de estructura 

//Los corchetes indica que quiero crea un tipo de dato array dinamico, para asi poder agregar tantas personas como yo quiera
People[] public people;

//La palabra clave memory, se usa porque el EVM necesita un lugar para guardar los parametros pasados
    function addPersona(string memory _name, uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
    }



}