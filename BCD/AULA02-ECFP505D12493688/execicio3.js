const entrada = require('readline-sync');

function converterParaFahrenheit(celsius) {
    let fahrenheit = (celsius * 9/5) + 32;
    return fahrenheit;
}

const tempC = entrada.questionFloat("Digite a temperatura em Celsius: ");
const tempF = converterParaFahrenheit(tempC);

console.log(`A temperatura convertida e: ${tempF.toFixed(1)}°F`);

