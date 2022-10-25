
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
               nameToFavoriteNumbre[_name] = _favoriteNumber;
             }



            //Mapping un array para hacer la busquedas mas facil, es un diccionario

         mapping(string => uint256) public nameToFavoriteNumbre;



}