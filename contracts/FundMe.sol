//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

//Contrato para revisir dinero 

//Importo la libreria priceConverter
import "./PriceConverter.sol";


contract Fundme{


        //Le indico que voy a usar la liberia priceConverter para los tipos de datos uint256 es por eso que puedo usar las funciones en msg.value
     using PriceConverter  for uint256;

              //Este valor se multiplica por 1e18 para agregar 18 ceros al numero indicado, y que se pueda dividir sin perder valor con los comas flotantes
        uint256 public constant MINIMUM_USD = 50 * 1e18; //1 * 10 **18

      
      
  //Array de donantes
       address[] public funders;
        
        //mapping para guardar cada direccion con la cantidad de dinero donando
        mapping(address => uint256) public addressToAmountFunded;


        // Las funciones que van a recibir dinero necesitan tener la palabra clave PAYABLE
        function fund() public payable{

            //El require indica cual sera el valor minimu al momento de desploy el contrato, y si no cumple con el requisito devuelve el mensaje de error. 
            //require(getConversionRate(msg.value) >= minimunUsd, "Saldo insuficiente"); -- como se hacia antes de la libreria

            //Aqui ya no es necesario pasar la variable, ya que la data que pase es el objeto msg.value, seria lo mismo que hacer getConversionRate(msg.value);
            require(msg.value.getConversionRate() >= MINIMUM_USD, "Saldo insuficiente");

            //Hago un push en el array de los donadores
           funders.push(msg.sender);


            //Agrego a mi diccionario la direccion con el valor donado.
          addressToAmountFunded[msg.sender] = msg.value;

        }

            //Variable para guardar la direccion del creador del contrato, y de tipo imutable para gastar menos gas
        address public  immutable i_owner;

        constructor(){
            //Inicializo la variable owner 
            i_owner = msg.sender;
        }


        function withdraw() public onlyOwner {

               

                for(uint256 funderIndex =0; funderIndex < funders.length; funderIndex ++){
                    address funder = funders[funderIndex];
                    addressToAmountFunded[funder] = 0;
                }

                funders = new address[](0);
                
 //    Call devuelve 2 parametros   // Direccion contrato // call invoca funcion y le pasa el value, usando el addrees(this).balance     
                (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");

                require(callSuccess, "fallo al llamar");






        }

//Son tipos de errores perzonalisados para ahorrar gas
        error NotOwner();


        modifier onlyOwner{
            _;
             //Le indico que que si la persona que esta enviando no es el dueño, no puede retirar los fondos 
               
                //require(msg.sender == i_owner, "Sender is not owner"); //Se puede usar de esta manera, o de la manera con el error perzonalizad NotOwner
                if(msg.sender != i_owner){revert NotOwner();}
        }


        //Se ejecuta cuando no se indica un calldata, si falla invoca a fallback
        receive() external payable{
                fund();
        }


//Fallback se ejecuta aunque haya calldata, pero no lo encuentre, de esta manera un persona uqe envie dinero a nuestro contranto, si precionar la manera fund, sera redireccionado
        fallback() external payable{
            fund();
        }

     
      


}