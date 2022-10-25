//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

//Contrato para revisir dinero 


//Importo esta interfaz, para el ABI, del contrato que me dara el precio de ETH, esto es un DATA FEED decentralizado de chain link
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract Fundme{

            //Este valor se multiplica por 1e18 para que cuando compare con el retorno de la funcion getConversionRate esta pueda realmente comparar bien
        uint256 public minimunUsd = 50 * 1e18; //1 * 10 **18


        // Las funciones que van a recibir dinero necesitan tener la palabra clave PAYABLE
        function fund() public payable{

            //El require dinca cual sera el valor minimu al momento de desploy el contrato, y si no cumple con el requisito devuelve el mensaje de error. 
            require(getConversionRate(msg.value) >= minimunUsd, "Saldo insufciente");

        }


        function getPrice() public view returns(uint256){

            //Para obtener el price, necesito llamar el contrato con el ABI, y la direccion del par de moneda de quiero, en este caso sera ETH /USD
            //Y el addres debe de ser la net de prueba con la que este trabajando en este caso Goerli

             // ETH/USD price feed address of Goerli Network.
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
            
            //Esta interfaz me devuelve varios datos, pero solo quiero el precio, asi que dejo sol la variable precio, sin quitar las comas de los otros parametros
            (,int256 price,,,) = priceFeed.latestRoundData();

            //Esto me devuelve el precio de ETH en USD, pero me lo vuelve con muchos ceros mas, ejemplo si vale 1500 dolares, me devolvera 1500000000000 
            //Esto es porque soladity no maneja los , flotantes ya que esto puede hacer perder dinero en la conversion. y por eso se trabaja con numeros enteros
            
            return uint256(price * 1e10); //1e10 == 1x10 == 10000000000

        }

        //Funcion vista para ver la version del pricefeed

        function getVersion() public view returns (uint256){
                AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
                return priceFeed.version(); 
        }

        function getConversionRate(uint256 ethAmount)public view returns(uint256){
    
                uint256 ethPrice = getPrice(); // Esta funcion me devolvera el precio de etherium pero me lo vuevle con muchos 0, por lo que tengo que dividir para quitarle esos 0 extras

            uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;


        //Esto me devuelve la cantidad en usd, pero con 18 ceros
            return ethAmountInUsd;



        }



}