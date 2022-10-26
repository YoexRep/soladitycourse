//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

//Contrato para revisir dinero 

//Importo la libreria priceConverter
import "./PriceConverter.sol";


contract Fundme{


        //Le indico que voy a usar la liberia priceConverter para los tipos de datos uint256 es por eso que puedo usar las funciones en msg.value
     using PriceConverter  for uint256;

              //Este valor se multiplica por 1e18 para que cuando compare con el retorno de la funcion getConversionRate esta pueda realmente comparar bien
        uint256 public minimunUsd = 50 * 1e18; //1 * 10 **18

        //Array de donantes
       address[] public funders;
        
        //mapping para guardar cada direccion con la cantidad de dinero donando
        mapping(address => uint256) public addressToAmountFunded;


        // Las funciones que van a recibir dinero necesitan tener la palabra clave PAYABLE
        function fund() public payable{

            //El require indica cual sera el valor minimu al momento de desploy el contrato, y si no cumple con el requisito devuelve el mensaje de error. 
            //require(getConversionRate(msg.value) >= minimunUsd, "Saldo insuficiente"); -- como se hacia antes de la libreria

            //Aqui ya no es necesario pasar la variable, ya que la data que pase es el objeto msg.value, seria lo mismo que hacer getConversionRate(msg.value);
            require(msg.value.getConversionRate() >= minimunUsd, "Saldo insuficiente");

            //Hago un push en el array de los donadores
           funders.push(msg.sender);


            //Agrego a mi diccionario la direccion con el valor donado.
          addressToAmountFunded[msg.sender] = msg.value;

        }


        function withdraw() public {

                for(uint256 funderIndex =0; funderIndex < funders.length; funderIndex ++){
                    address funder = funders[funderIndex];
                    addressToAmountFunded[funder] = 0;
                }

                funders = new address[](0);
                
 //    Call devuelve 2 parametros   // Direccion contrato // call invoca funcion y le pasa el value, usando el addrees(this).balance     
                (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");

                require(callSuccess, "fallo al llamar");



        }

     
      
      



}