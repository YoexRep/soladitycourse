//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;


//Esta librery me guarda todas las funciones para los calculos de math, y la puedo utilizar para tipos de datos que yo quiera ejemplo uint256.value.getprice();


//Importo esta interfaz, para el ABI, del contrato que me dara el precio de ETH, esto es un DATA FEED decentralizado de chain link
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter{


        //Funcion vista para ver la version del pricefeed

    //Las funciones dentro de una libreria deben ser internal
        function getVersion() internal view returns (uint256){
                AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
                return priceFeed.version(); 
        }


        function getPrice() internal view returns(uint256){

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

        function getConversionRate(uint256 ethAmount)internal view returns(uint256){
    
            uint256 ethPrice = getPrice(); // Esta funcion me devolvera el precio de etherium pero me lo vuevle con muchos 0, por lo que tengo que dividir para quitarle esos 0 extras

            uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;

        //Esto me devuelve la cantidad en usd, pero con 18 ceros
            return ethAmountInUsd;


        }


      
      



}